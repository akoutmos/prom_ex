defmodule PromEx.Plugins.PromExTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Manual
  alias PromEx.Plugins.PromEx

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert PromEx.event_metrics(router: Some.Module) == []
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert PromEx.polling_metrics([]) == []
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert %Manual{} = PromEx.manual_metrics([])
    end
  end
end
