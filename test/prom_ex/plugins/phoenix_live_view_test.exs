defmodule PromEx.Plugins.PhoenixLiveViewTest do
  use ExUnit.Case, async: true

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

    metrics =
      WebApp.PromEx
      |> PromEx.get_metrics()
      |> Metrics.sort()

    assert metrics == Metrics.read_expected(:phoenix_live_view)
  end
end
