defmodule PromEx.Plugins.ApplicationTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Polling
  alias PromEx.Plugins.Application

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
