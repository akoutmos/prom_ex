defmodule PromEx.Plugins.ApplicationTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Polling
  alias PromEx.Plugins.Application
  alias PromEx.Test.Support.{Events, Metrics}

  @moduletag :capture_log

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{Application, otp_app: :web_app}]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:application)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :application)
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert Application.event_metrics(otp_app: :test) == []
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert %Polling{} = Application.polling_metrics(otp_app: :test)
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Application.manual_metrics(otp_app: :test)) == 1
    end
  end
end
