# TODO: For version 2.0.0 have all of the supported adapters be
# optional deps.
# if Code.ensure_loaded?(TelemetryMetricsPrometheus.Core) do
defmodule PromEx.Storage.Core do
  @moduledoc """
  This store uses [TelemetryMetricsPrometheus.Core](https://github.com/beam-telemetry/telemetry_metrics_prometheus_core) as the storage
  mechanism for metrics.
  """

  alias TelemetryMetricsPrometheus.Core

  @behaviour PromEx.Storage
  @dialyzer {:no_return, child_spec: 2}

  @impl true
  def scrape(name) do
    if Process.whereis(name) do
      Core.scrape(name)
    else
      :prom_ex_down
    end
  end

  @impl true
  def child_spec(name, metrics) do
    opts = [
      name: name,
      metrics: metrics,
      require_seconds: false,
      consistent_units: true,
      start_async: false
    ]

    Core.child_spec(opts)
  end
end
