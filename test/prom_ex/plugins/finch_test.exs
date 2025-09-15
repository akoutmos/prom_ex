defmodule PromEx.Plugins.FinchTest do
  use ExUnit.Case, async: true

  alias PromEx.Plugins.Finch
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [Finch]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:finch)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :finch)
  end
end