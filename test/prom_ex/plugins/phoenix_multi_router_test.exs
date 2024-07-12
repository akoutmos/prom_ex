defmodule PromEx.Plugins.PhoenixMultiRouterTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.Phoenix
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @additional_routes [
      special_label: "/really-cool-route",
      another_label: ~r(\/another-cool-route)
    ]

    @impl true
    def plugins do
      [
        {
          Phoenix,
          endpoints: [
            {TestApp.Endpoint, routers: [TestApp.ExternalRouter], event_prefix: [:external, :endpoint]},
            {TestApp.Endpoint2,
             routers: [TestApp.InternalRouter],
             event_prefix: [:internal, :endpoint],
             additional_routes: @additional_routes}
          ]
        }
      ]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:phoenix_multi_router)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :phoenix_multi_router)
  end
end
