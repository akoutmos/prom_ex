defmodule PromEx.TelemetryMetricsPrometheus.Core do
  @moduledoc """
  Prometheus Reporter for [`Telemetry.Metrics`](https://github.com/beam-telemetry/telemetry_metrics) definitions.

  Provide a list of metric definitions to the `child_spec/1` function. It's recommended to
  add this to your supervision tree.

      def start(_type, _args) do
        # List all child processes to be supervised
        children = [
          {PromEx.TelemetryMetricsPrometheus.Core, [
            metrics: [
              counter("http.request.count"),
              sum("http.request.payload_size", unit: :byte),
              last_value("vm.memory.total", unit: :byte)
            ]
          ]}
        ]

        opts = [strategy: :one_for_one, name: ExampleApp.Supervisor]
        Supervisor.start_link(children, opts)
      end

  Note that aggregations for distributions (histogram) only occur at scrape time.
  These aggregations only have to process events that have occurred since the last
  scrape, so it's recommended at this time to keep an eye on scrape durations if
  you're reporting a large number of distributions or you have a high tag cardinality.

  ## Telemetry.Metrics to Prometheus Equivalents

  Metric types:
    * Counter - Counter
    * Distribution - Histogram
    * LastValue - Gauge
    * Sum - Counter
    * Summary - Summary (Not supported)

  ### Units

  Prometheus recommends the usage of base units for compatibility - [Base Units](https://prometheus.io/docs/practices/naming/#base-units).
  This is simple to do with `:telemetry` and `Telemetry.Metrics` as all memory
  related measurements in the BEAM are reported in bytes and Metrics provides
  automatic time unit conversions.

  Note that measurement unit should used as part of the reported name in the case of
  histograms and gauges to Prometheus. As such, it is important to explicitly define
  the unit of measure for these types when the unit is time or memory related.

  It is suggested to not mix units, e.g. seconds with milliseconds.

  It is required to define your buckets according to the end unit translation
  since this measurements are converted at the time of handling the event, prior
  to bucketing.

  #### Memory

  Report memory as `:byte`.

  #### Time

  Report durations as `:second`. The BEAM and `:telemetry` events use `:native` time
  units. Converting to seconds is as simple as adding the conversion tuple for
  the unit - `{:native, :second}`

  ### Naming

  `Telemetry.Metrics` definition names do not translate easily to Prometheus naming
  conventions. By default, the name provided when creating your definition uses parts
  of the provided name to determine what event to listen to and which event measurement
  to use.

  For example, `"http.request.duration"` results in listening for  `[:http, :request]`
  events and use `:duration` from the event measurements. Prometheus would recommend
  a name of `http_request_duration_seconds` as a good name.

  It is therefore recommended to use the name in your definition to reflect the name
  you wish to see reported, e.g. `http.request.duration.seconds` or `[:http, :request, :duration, :seconds]` and use the `:event_name` override and `:measurement` options in your definition.

  Example:

      Metrics.distribution(
        "http.request.duration.seconds",
        event_name: [:http, :request, :complete],
        measurement: :duration,
        unit: {:native, :second},
        reporter_options: [
          buckets: [0.01, 0.025, 0.05, 0.1, 0.2, 0.5, 1]
        ]
      )

  The exporter sanitizes names to Prometheus' requirements ([Metric Naming](https://prometheus.io/docs/instrumenting/writing_exporters/#naming)) and joins the event name parts with an underscore.

  ### Labels

  Labels in Prometheus are referred to as `:tags` in `Telemetry.Metrics` - see the docs
  for more information on tag usage.

  **Important: Each tag + value results in a separate time series. For distributions, this
  is further complicated as a time series is created for each bucket plus one for measurements
  exceeding the limit of the last bucket - `+Inf`.**

  It is recommended, but not required, to abide by Prometheus' best practices regarding labels -
  [Label Best Practices](https://prometheus.io/docs/practices/naming/#labels)

  ### Missing or Invalid Measurements and Tags

  If a measurement value is missing or non-numeric, the error is logged at the `debug` level
  and the event is not recorded. Events with missing tags are also logged and skipped.

  """

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
