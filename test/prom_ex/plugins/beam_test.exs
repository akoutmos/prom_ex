defmodule PromEx.Plugins.BeamTest do
  use ExUnit.Case, async: true

  alias PromEx.Plugins.Beam

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert Beam.event_metrics([]) == []
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Beam.polling_metrics([])) == 4
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Beam.manual_metrics([])) == 4
    end
  end
end
