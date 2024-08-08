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

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)

    Events.execute_all(:oban)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :oban)
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
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert [] == ObanPlugin.manual_metrics([])
    end
  end
end
