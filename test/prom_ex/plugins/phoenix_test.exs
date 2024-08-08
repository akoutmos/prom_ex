defmodule PromEx.Plugins.PhoenixTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.Phoenix
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromExMultipleEndpoint do
    use PromEx, otp_app: :web_app

    @additional_routes [
      special_label: "/really-cool-route",
      another_label: ~r(\/another-cool-route)
    ]

    @impl true
    def plugins do
      [
        {Phoenix, endpoints: [{TestApp.Endpoint, routers: [TestApp.Router], additional_routes: @additional_routes}]}
      ]
    end
  end

  defmodule WebApp.PromExSingleEndpoint do
    use PromEx, otp_app: :web_app

    @additional_routes [
      special_label: "/really-cool-route",
      another_label: ~r(\/another-cool-route)
    ]

    @impl true
    def plugins do
      [
        {Phoenix, router: TestApp.Router, additional_routes: @additional_routes, endpoint: TestApp.Endpoint}
      ]
    end
  end

  defmodule WebApp.PromExSingleEndpointNormalizedChannelEvents do
    use PromEx, otp_app: :web_app

    @additional_routes [
      special_label: "/really-cool-route",
      another_label: ~r(\/another-cool-route)
    ]

    @impl true
    def plugins do
      [
        {Phoenix,
         router: TestApp.Router,
         additional_routes: @additional_routes,
         endpoint: TestApp.Endpoint,
         normalize_event_name: fn
           "test_event" -> "test_event"
           _ -> "unknown"
         end}
      ]
    end
  end

  test "telemetry events are accumulated for single endpoint configuration" do
    start_supervised!(WebApp.PromExSingleEndpoint)
    Events.execute_all(:phoenix)

    Metrics.assert_prom_ex_metrics(WebApp.PromExSingleEndpoint, :phoenix)
  end

  test "telemetry events are accumulated for multiple endpoint configuration" do
    start_supervised!(WebApp.PromExMultipleEndpoint)
    Events.execute_all(:phoenix)

    Metrics.assert_prom_ex_metrics(WebApp.PromExMultipleEndpoint, :phoenix)
  end

  test "channel events normalize according to normalize_event_name" do
    start_supervised!(WebApp.PromExSingleEndpointNormalizedChannelEvents)
    Events.execute_all(:phoenix)

    collected_metrics = Metrics.read_collected(WebApp.PromExSingleEndpointNormalizedChannelEvents)

    assert collected_metrics |> Enum.any?(&String.contains?(&1, "unknown"))
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Phoenix.event_metrics(otp_app: :prom_ex, router: Some.Module)) == 4
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert Phoenix.polling_metrics([]) == []
    end
  end
end
