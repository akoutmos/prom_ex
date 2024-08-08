# TODO: For version 2.0.0 have all of the supported adapters be
# optional deps.
# if Code.ensure_loaded?(TelemetryMetricsPrometheus.Core) do
defmodule PromEx.Storage.Core do
  @behaviour PromEx.Storage

  alias TelemetryMetricsPrometheus.Core

  @impl true
  def scrape(name) do
    if Process.whereis(name),
      do: Core.scrape(name),
      else: :prom_ex_down
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
