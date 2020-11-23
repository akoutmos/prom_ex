defmodule PromEx.Plugins.PhoenixTest do
  use ExUnit.Case, async: true

  alias PromEx.Plugins.Phoenix

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Phoenix.event_metrics(router: Some.Module)) == 2
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
