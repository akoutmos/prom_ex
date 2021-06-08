defmodule PromEx.ETSCronFlusherTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.Phoenix
  alias PromEx.Test.Support.Events

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    @impl true
    def plugins do
      [{Phoenix, router: TestApp.Router}]
    end
  end

  describe "ETSCronFlusherTest" do
    test "should flush ETS metrics at the correct interval" do
      start_supervised!(DefaultPromExSetUp)
      original_timer_ref = get_timer_ref()

      Events.execute_all(:phoenix)

      assert length(get_metrics_table()) == 5
      assert length(get_dist_table()) == 40

      Events.execute_all(:phoenix)

      assert length(get_metrics_table()) == 5
      assert length(get_dist_table()) == 80

      Process.sleep(8_000)

      assert length(get_metrics_table()) == 11
      assert get_dist_table() == []

      new_timer_ref = get_timer_ref()
      assert original_timer_ref != new_timer_ref
      assert is_reference(new_timer_ref)

      PromEx.ETSCronFlusher.defer_ets_flush(DefaultPromExSetUp.__ets_cron_flusher_name__())
      Process.sleep(500)
      defer_new_timer_ref = get_timer_ref()
      assert new_timer_ref != defer_new_timer_ref
      assert is_reference(defer_new_timer_ref)
    end
  end

  defp get_dist_table do
    :ets.tab2list(PromEx.ETSCronFlusherTest.DefaultPromExSetUp.Metrics_dist)
  end

  defp get_metrics_table do
    :ets.tab2list(PromEx.ETSCronFlusherTest.DefaultPromExSetUp.Metrics)
  end

  defp get_timer_ref do
    DefaultPromExSetUp.__ets_cron_flusher_name__()
    |> :sys.get_state()
    |> Map.get(:timer_ref)
  end
end
