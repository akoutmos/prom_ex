defmodule PromEx.DebugTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO

  alias PromEx.{Debug, MetricTypes.Event}
  alias Telemetry.Metrics

  describe "attach_debugger/1" do
    test "should output debugging information when a Telemetry.Metrics type struct is provided" do
      Metrics.counter(
        [:test_event_total],
        event_name: [:test, :event]
      )
      |> Debug.attach_debugger()

      assert capture_io(fn ->
               :telemetry.execute([:test, :event], %{measurement: 1})
             end) =~ "---- EVENT NAME ----: [:test, :event]"
    end

    test "should output debugging information when an event in the form of a list is provided" do
      Debug.attach_debugger([:tester, :event])

      assert capture_io(fn ->
               :telemetry.execute([:tester, :event], %{measurement: 1})
             end) =~ "---- EVENT NAME ----: [:tester, :event]"
    end
  end
end
