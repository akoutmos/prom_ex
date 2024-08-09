defmodule PromEx.MetricTypes.PollingTest do
  use ExUnit.Case, async: true

  alias PromEx.MetricTypes.Polling
  alias Telemetry.Metrics

  describe "build/3" do
    test "should properly build a default Polling struct when values are provided" do
      group_name = :phoenix_http_metrics
      poll_rate = 10_000
      mfa = {__MODULE__, :dummy, []}

      metrics = [
        Metrics.counter(
          [:phoenix, :http, :requests, :total],
          event_name: [:phoenix, :http, :requests, :total],
          description: "The number of requests have been serviced."
        )
      ]

      assert %Polling{
               group_name: ^group_name,
               poll_rate: ^poll_rate,
               measurements_mfa: ^mfa,
               metrics: ^metrics
             } = Polling.build(group_name, poll_rate, mfa, metrics)
    end

    test "should properly build safe exec Polling struct when values are provided" do
      group_name = :phoenix_http_metrics
      poll_rate = 10_000
      mfa = {__MODULE__, :dummy, []}

      metrics = [
        Metrics.counter(
          [:phoenix, :http, :requests, :total],
          event_name: [:phoenix, :http, :requests, :total],
          description: "The number of requests have been serviced."
        )
      ]

      assert %Polling{
               group_name: ^group_name,
               poll_rate: ^poll_rate,
               measurements_mfa: {PromEx.MetricTypes.Polling, :safe_polling_runner, [^mfa]},
               metrics: ^metrics
             } = Polling.build(group_name, poll_rate, mfa, metrics, detach_on_error: false)
    end
  end
end
