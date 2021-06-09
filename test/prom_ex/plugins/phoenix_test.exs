defmodule PromEx.Plugins.PhoenixTest do
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
      [{Phoenix, router: TestApp.Router, additional_routes: @additional_routes, endpoint: TestApp.Endpoint}]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:phoenix)

    metrics =
      WebApp.PromEx
      |> PromEx.get_metrics()
      |> Metrics.sort()

    assert metrics == Metrics.read_expected(:phoenix)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Phoenix.event_metrics(otp_app: :prom_ex, router: Some.Module)) == 3
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert Phoenix.polling_metrics([]) == []
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Phoenix.manual_metrics(otp_app: :prom_ex, router: Some.Module, endpoint: Some.Endpoint)) == 1
    end
  end
end
