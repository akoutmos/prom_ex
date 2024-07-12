defmodule PromEx.Plugins.PlugCowboyTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.PlugCowboy
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @ignore_routes ["/metrics"]

    @impl true
    def plugins do
      [{PlugCowboy, routers: [TestApp.Router], ignore_routes: @ignore_routes}]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:plug_cowboy)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :plug_cowboy)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(
               PlugCowboy.event_metrics(
                 otp_app: :prom_ex,
                 routers: [TestApp.Router],
                 ignore_routes: [
                   metrics: "/metrics"
                 ]
               )
             ) == 1
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert PlugCowboy.polling_metrics([]) == []
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert PlugCowboy.manual_metrics([]) == []
    end
  end
end
