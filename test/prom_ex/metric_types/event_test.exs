defmodule PromEx.MetricTypes.EventTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Event
  alias Telemetry.Metrics

  describe "build/2" do
    test "should properly build an Event struct when values are provided" do
      group_name = :phoenix_http_metrics

      metrics = [
        Metrics.counter(
          [:phoenix, :http, :requests, :total],
          event_name: [:phoenix, :http, :requests, :total],
          description: "The number of requests have been serviced."
        )
      ]

      assert %Event{
               group_name: ^group_name,
               metrics: ^metrics
             } = Event.build(group_name, metrics)
    end
  end
end
