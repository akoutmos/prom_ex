defmodule PromEx.ETSCronFlusherTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.Phoenix
  alias PromEx.Test.Support.Events

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    @impl true
    def plugins do
      [{Phoenix, router: TestApp.Router, endpoint: TestApp.Endpoint}]
    end
  end

  defmodule ManualPromExSetUp do
    use PromEx, otp_app: :prom_ex

    @impl true
    def plugins do
      [{Phoenix, router: TestApp.Router, endpoint: TestApp.Endpoint}]
    end

    @impl true
    def init_opts do
      %PromEx.Config{
        disabled: false,
        drop_metrics_groups: MapSet.new(),
        ets_flush_interval: 2_500,
        grafana_agent_config: :disabled,
        grafana_config: :disabled,
        manual_metrics_start_delay: :no_delay,
        metrics_server_config: :disabled
      }
    end
  end

  describe "ETSCronFlusherTest" do
    test "should flush ETS metrics at the correct interval when the default is used" do
      start_supervised!(DefaultPromExSetUp)
      original_timer_ref = get_timer_ref(DefaultPromExSetUp)

      Events.execute_all(:phoenix)

      assert length(get_metrics_table(DefaultPromExSetUp)) == 6
      assert length(get_dist_table(DefaultPromExSetUp)) == 44

      Events.execute_all(:phoenix)

      assert length(get_metrics_table(DefaultPromExSetUp)) == 6
      assert length(get_dist_table(DefaultPromExSetUp)) == 88

      Process.sleep(8_000)

      assert length(get_metrics_table(DefaultPromExSetUp)) == 16
      assert get_dist_table(DefaultPromExSetUp) == []

      new_timer_ref = get_timer_ref(DefaultPromExSetUp)
      assert original_timer_ref != new_timer_ref
      assert is_reference(new_timer_ref)

      PromEx.ETSCronFlusher.defer_ets_flush(DefaultPromExSetUp.__ets_cron_flusher_name__())
      Process.sleep(500)
      defer_new_timer_ref = get_timer_ref(DefaultPromExSetUp)
      assert new_timer_ref != defer_new_timer_ref
      assert is_reference(defer_new_timer_ref)
    end

    test "should flush ETS metrics at the correct interval when the interval is manually set" do
      start_supervised!(ManualPromExSetUp)
      original_timer_ref = get_timer_ref(ManualPromExSetUp)

      Events.execute_all(:phoenix)

      assert length(get_metrics_table(ManualPromExSetUp)) == 6
      assert length(get_dist_table(ManualPromExSetUp)) == 44

      Events.execute_all(:phoenix)

      assert length(get_metrics_table(ManualPromExSetUp)) == 6
      assert length(get_dist_table(ManualPromExSetUp)) == 88

      Process.sleep(3_500)

      assert length(get_metrics_table(ManualPromExSetUp)) == 16
      assert get_dist_table(ManualPromExSetUp) == []

      new_timer_ref = get_timer_ref(ManualPromExSetUp)
      assert original_timer_ref != new_timer_ref
      assert is_reference(new_timer_ref)

      PromEx.ETSCronFlusher.defer_ets_flush(ManualPromExSetUp.__ets_cron_flusher_name__())
      Process.sleep(500)
      defer_new_timer_ref = get_timer_ref(ManualPromExSetUp)
      assert new_timer_ref != defer_new_timer_ref
      assert is_reference(defer_new_timer_ref)
    end
  end

  defp get_dist_table(module) do
    [module, Metrics_dist]
    |> Module.concat()
    |> :ets.tab2list()
  end

  defp get_metrics_table(module) do
    [module, Metrics]
    |> Module.concat()
    |> :ets.tab2list()
  end

  defp get_timer_ref(module) do
    module.__ets_cron_flusher_name__()
    |> :sys.get_state()
    |> Map.get(:timer_ref)
  end
end
