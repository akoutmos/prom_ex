defmodule PromEx.Plugins.PhoenixTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.Phoenix
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromExNoAdditionalRoutes do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{Phoenix, router: TestApp.Router}]
    end
  end

  defmodule WebApp.PromExAdditionalRoutes do
    use PromEx, otp_app: :web_app

    @additional_routes [special_label: "/really-cool-route", another_label: ~r(\/another-cool-route)]

    @impl true
    def plugins do
      [{Phoenix, router: TestApp.Router, additional_routes: @additional_routes}]
    end
  end

  test "telemetry events are accumulated when not using additional routes" do
    start_supervised!(WebApp.PromExNoAdditionalRoutes)
    Events.execute_all(:phoenix)

    metrics =
      WebApp.PromExNoAdditionalRoutes
      |> PromEx.get_metrics()
      |> Metrics.sort()

    assert metrics == Metrics.read_expected(:phoenix)
  end

  test "telemetry events are accumulated when using additional routes" do
    start_supervised!(WebApp.PromExAdditionalRoutes)
    Events.execute_all(:phoenix)

    metrics =
      WebApp.PromExAdditionalRoutes
      |> PromEx.get_metrics()
      |> Metrics.sort()

    assert metrics == Metrics.read_expected(:phoenix)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Phoenix.event_metrics(otp_app: :prom_ex, router: Some.Module)) == 2
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert Phoenix.polling_metrics([]) == []
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert Phoenix.manual_metrics([]) == []
    end
  end
end
