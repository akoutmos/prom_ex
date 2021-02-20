defmodule PromEx.TelemetryMetricsPrometheus.Core do
  @moduledoc false

  alias Telemetry.Metrics
  alias PromEx.TelemetryMetricsPrometheus.Core.{Aggregator, Exporter, Registry}

  require Logger

  @type metrics :: [Metrics.t()]

  @type prometheus_option ::
          {:metrics, metrics()}
          | {:name, atom()}

  @type prometheus_options :: [prometheus_option()]

  @doc """
  Reporter's child spec.

  This function allows you to start the reporter under a supervisor like this:

  children = [
    {PromEx.TelemetryMetricsPrometheus.Core, options}
  ]

  See `start_child/1` for options.
  """
  @spec child_spec(prometheus_options()) :: Supervisor.child_spec()
  def child_spec(options) do
    opts = ensure_options(options)

    id =
      case Keyword.get(opts, :name, :prometheus_metrics) do
        name when is_atom(name) -> name
        {:global, name} -> name
        {:via, _, name} -> name
      end

    spec = %{
      id: id,
      start: {Registry, :start_link, [opts]}
    }

    Supervisor.child_spec(spec, [])
  end

  @doc """
  Start the `PromEx.TelemetryMetricsPrometheus.Core.Supervisor`

  Available options:
  * `:name` - name of the reporter instance. Defaults to `:prometheus_metrics`
  * `:metrics` - a list of metrics to track.
  """
  @spec start_link(prometheus_options()) :: GenServer.on_start()
  def start_link(options) do
    opts = ensure_options(options)

    Registry.start_link(opts)
  end

  @doc """
  Returns a metrics scrape in Prometheus exposition format for the given reporter
  name - defaults to `:prometheus_metrics`.
  """
  @spec scrape(name :: atom()) :: String.t()
  def scrape(name \\ :prometheus_metrics) do
    config = Registry.config(name)
    metrics = Registry.metrics(name)

    :ok = Aggregator.aggregate(metrics, config.aggregates_table_id, config.dist_table_id)

    Aggregator.get_time_series(config.aggregates_table_id)
    |> Exporter.export(metrics)
  end

  @spec ensure_options(prometheus_options()) :: prometheus_options()
  defp ensure_options(options) do
    Keyword.merge(default_options(), options)
  end

  @spec default_options() :: prometheus_options()
  defp default_options() do
    [
      name: :prometheus_metrics
    ]
  end
end
