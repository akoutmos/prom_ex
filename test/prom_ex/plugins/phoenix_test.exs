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

  defmodule WebApp.PromExSingleEndpointAdditionalTags do
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
         additional_tags: [:my_metadata]}
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

  test "telemetry events include additional tags" do
    start_supervised!(WebApp.PromExSingleEndpointAdditionalTags)
    Events.execute_all(:phoenix)

    collected_metrics = Metrics.read_collected(WebApp.PromExSingleEndpointAdditionalTags)

    assert collected_metrics |> Enum.any?(&String.contains?(&1, "my_metadata=\"test\""))
    refute collected_metrics |> Enum.any?(&String.contains?(&1, "non_collected_metadata=\"test\""))
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

  describe "router options order preservation" do
    defp http_tag_values_fn(opts) do
      [_endpoint_info, http_metrics | _] =
        Phoenix.event_metrics(Keyword.merge([otp_app: :prom_ex], opts))

      http_metrics.metrics
      |> List.first()
      |> Map.get(:tag_values)
    end

    defp resolve_action(tag_values_fn, path) do
      conn = %Plug.Conn{method: "GET", request_path: path, host: "localhost", status: 200}
      tag_values_fn.(%{conn: conn}).action
    end

    test "first router wins for overlapping routes" do
      tag_values_fn =
        http_tag_values_fn(
          endpoints: [{TestApp.Endpoint, routers: [TestApp.Router, TestApp.OverlapRouter]}]
        )

      assert resolve_action(tag_values_fn, "/users") == :index
    end

    test "preserves insertion order when deduplicating routers" do
      # [Router, OverlapRouter, Router] should deduplicate to [Router, OverlapRouter]
      tag_values_fn =
        http_tag_values_fn(
          endpoints: [
            {TestApp.Endpoint,
             routers: [TestApp.Router, TestApp.OverlapRouter, TestApp.Router]}
          ]
        )

      # TestApp.Router is first, so its action wins for the overlapping route
      assert resolve_action(tag_values_fn, "/users") == :index
    end

    test "keeps first occurrence when deduplicating, not last" do
      # [OverlapRouter, Router, OverlapRouter] should deduplicate to [OverlapRouter, Router]
      tag_values_fn =
        http_tag_values_fn(
          endpoints: [
            {TestApp.Endpoint,
             routers: [TestApp.OverlapRouter, TestApp.Router, TestApp.OverlapRouter]}
          ]
        )

      # TestApp.OverlapRouter is first, so its action wins for the overlapping route
      assert resolve_action(tag_values_fn, "/users") == :overlap_index
    end
  end
end
