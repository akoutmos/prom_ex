defmodule PromEx.Plugins.PhoenixLiveViewTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.PhoenixLiveView
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [PhoenixLiveView]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:phoenix_live_view)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :phoenix_live_view)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert [_, _] = PhoenixLiveView.event_metrics(otp_app: :prom_ex)
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert [] == PhoenixLiveView.polling_metrics(otp_app: :prom_ex)
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert [] == PhoenixLiveView.manual_metrics([])
    end
  end
end
