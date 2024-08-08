defmodule PromEx.Plugins.PlugRouterTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.PlugRouter
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule TestApp.PromEx do
    use PromEx, otp_app: :test_app

    alias Elixir.TestApp

    @impl true
    def plugins do
      [
        {PlugRouter,
         event_prefix: [:testapp, :plug, :router],
         metric_prefix: [:testapp, :plug, :router],
         routers: [TestApp.PlugRouter],
         ignore_routes: ["/metrics"]}
      ]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(TestApp.PromEx)
    Events.execute_all(:plug_router)

    Metrics.assert_prom_ex_metrics(TestApp.PromEx, :plug_router)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(
               PlugRouter.event_metrics(
                 otp_app: :prom_ex,
                 event_prefix: [:testapp, :plug, :router],
                 metric_prefix: [:testapp, :plug, :router],
                 routers: [TestApp.PlugRouter],
                 ignore_routes: [
                   metrics: "/metrics"
                 ]
               )
             ) == 1
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert PlugRouter.polling_metrics([]) == []
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert PlugRouter.manual_metrics([]) == []
    end
  end
end
