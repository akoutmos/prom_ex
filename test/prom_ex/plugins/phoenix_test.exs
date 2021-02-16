defmodule PromEx.Plugins.PhoenixTest do
  use ExUnit.Case, async: true

  alias PromEx.Plugins.Phoenix
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{Phoenix, router: WebAppWeb.Router}]
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
