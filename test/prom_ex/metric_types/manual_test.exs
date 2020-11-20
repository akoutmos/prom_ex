defmodule PromEx.MetricTypes.ManualTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Manual
  alias Telemetry.Metrics

  describe "build/3" do
    test "should properly build an Manual struct when values are provided" do
      group_name = :phoenix_http_metrics
      mfa = {__MODULE__, :dummy, []}

      metrics = [
        Metrics.counter(
          [:phoenix, :http, :requests, :total],
          event_name: [:phoenix, :http, :requests, :total],
          description: "The number of requests have been serviced."
        )
      ]

      assert %Manual{
               group_name: ^group_name,
               measurements_mfa: ^mfa,
               metrics: ^metrics
             } = Manual.build(group_name, mfa, metrics)
    end
  end
end
