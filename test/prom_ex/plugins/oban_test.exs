defmodule PromEx.Plugins.ObanTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Polling
  alias PromEx.Plugins.Oban, as: ObanPlugin
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{PromEx.Plugins.Oban, oban_supervisors: [Oban]}]
    end
  end

  defmodule MultiObanApp.PromEx do
    use PromEx, otp_app: :multi_oban_app

    @impl true
    def plugins do
      [{PromEx.Plugins.Oban, oban_supervisors: [Oban, Oban.SuperSecret]}]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)

    Events.execute_all(:oban)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :oban)
  end

  test "telemetry events are accumulated for multiple Oban instances" do
    start_supervised!(MultiObanApp.PromEx)

    Events.execute_all(:oban)

    collected_metrics = MultiObanApp.PromEx |> PromEx.get_metrics() |> String.split("\n", trim: true)

    assert Enum.any?(collected_metrics, fn line ->
             String.contains?(line, ~s(name="Oban")) and String.contains?(line, ~s(queue="default"))
           end)

    assert Enum.any?(collected_metrics, fn line ->
             String.contains?(line, ~s(name="Oban.SuperSecret")) and
               String.contains?(line, ~s(queue="default"))
           end)

    assert Enum.any?(collected_metrics, fn line ->
             String.contains?(line, ~s(name="Oban")) and
               String.contains?(line, ~s(queue="events")) and
               String.contains?(line, "25")
           end)

    assert Enum.any?(collected_metrics, fn line ->
             String.contains?(line, ~s(name="Oban.SuperSecret")) and
               String.contains?(line, ~s(queue="events")) and
               String.contains?(line, "50")
           end)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert [_, _, _, _] = ObanPlugin.event_metrics(otp_app: :prom_ex)
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert %Polling{} = ObanPlugin.polling_metrics(otp_app: :prom_ex)
    end

    test "works with multiple Oban instances with different queue configurations" do
      polling_metrics =
        ObanPlugin.polling_metrics(
          otp_app: :prom_ex,
          oban_supervisors: [Oban, Oban.SuperSecret]
        )

      assert %Polling{} = polling_metrics

      assert {PromEx.Plugins.Oban, :execute_queue_metrics, [supervisors]} =
               polling_metrics.measurements_mfa

      assert MapSet.equal?(MapSet.new(supervisors), MapSet.new([Oban, Oban.SuperSecret]))
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert [] == ObanPlugin.manual_metrics([])
    end
  end

  describe "include_zeros_for_missing_queue_states/2" do
    @query_result [{"default", "available", 3}, {"exports", "executing", 1}]

    test "zero-fills queues configured with plain Oban queues" do
      config = %Oban.Config{
        queues: [default: [limit: 10], exports: [limit: 5]],
        plugins: [{Oban.Plugins.Pruner, []}]
      }

      assert ObanPlugin.include_zeros_for_missing_queue_states(@query_result, config) ==
               expected_queue_lengths(["default", "exports"])
    end

    test "zero-fills queues configured with Oban.Pro.Plugins.DynamicQueues" do
      config = %Oban.Config{
        queues: [],
        plugins: [{Oban.Plugins.Pruner, []}, {Oban.Pro.Plugins.DynamicQueues, queues: [default: 10, exports: 5]}]
      }

      assert ObanPlugin.include_zeros_for_missing_queue_states(@query_result, config) ==
               expected_queue_lengths(["default", "exports"])
    end

    test "zero-fills queues configured with Oban.Pro.Queues" do
      # Oban >= 2.24 normalizes `queues: {Oban.Pro.Queues, queues: [...]}` into this shape
      config = %Oban.Config{
        queues: [],
        plugins: [{Oban.Plugins.Pruner, []}, {Oban.Pro.Queues, queues: [default: 10, exports: 5]}]
      }

      assert ObanPlugin.include_zeros_for_missing_queue_states(@query_result, config) ==
               expected_queue_lengths(["default", "exports"])
    end

    test "only reports the queried counts when no queues are configured" do
      config = %Oban.Config{queues: [], plugins: [{Oban.Plugins.Pruner, []}]}

      assert ObanPlugin.include_zeros_for_missing_queue_states(@query_result, config) == %{
               {"default", "available"} => 3,
               {"exports", "executing"} => 1
             }
    end
  end

  defp expected_queue_lengths(queues) do
    zeros = for queue <- queues, state <- Oban.Job.states(), into: %{}, do: {{queue, to_string(state)}, 0}

    Map.merge(zeros, %{{"default", "available"} => 3, {"exports", "executing"} => 1})
  end
end
