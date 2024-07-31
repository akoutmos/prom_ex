defmodule PromEx.Plugins.TeslaTest do
  use ExUnit.Case, async: false

  alias PromEx.Plugins.Tesla
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [Tesla]
    end
  end

  test "telemetry works for start/stop" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:tesla)

    metrics =
      WebApp.PromEx
      |> PromEx.get_metrics()
      |> Metrics.sort()

    assert metrics == Metrics.read_expected(:tesla)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Tesla.event_metrics(otp_app: :prom_ex)) == 1
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert Tesla.polling_metrics([]) == []
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert Tesla.manual_metrics(otp_app: :prom_ex) == []
    end
  end
end
