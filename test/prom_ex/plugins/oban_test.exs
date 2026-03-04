defmodule PromEx.Plugins.ObanTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Polling
  alias PromEx.Plugins.Oban, as: ObanPlugin
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [
        {PromEx.Plugins.Oban,
         oban_supervisors: [Oban], job_duration_buckets: [10, 100, 500, 1_000, 5_000, 10_000, 20_000]}
      ]
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
end
