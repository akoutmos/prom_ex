defmodule PromEx.Plugins.ObanTest do
  use ExUnit.Case, async: true

  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{PromEx.Plugins.Oban, oban_supervisors: [Oban]}]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!({Registry, keys: :unique, name: Oban.Registry})
    start_supervised!(WebApp.PromEx)

    Events.execute_all(:oban)

    metrics =
      WebApp.PromEx
      |> PromEx.get_metrics()
      |> Metrics.sort()

    assert metrics == Metrics.read_expected(:oban)
  end
end
