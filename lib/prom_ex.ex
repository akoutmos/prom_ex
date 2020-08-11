defmodule PromEx do
  @moduledoc """
  PromEx is a plugin based library which can be used to capture
  telemetry events and report them out for consumption by Prometheus.
  The main purpose of this particular library is to provide the
  behaviour that all PromEx plugins will leverage so that a consistent
  interface can be achieved and so that leveraging multiple plugins is
  effortless from the user's point of view.

  All metrics gathering will be delegated to plugins which can be found here:

  Elixir libs:
    - plug
    - ecto
    - phoenix
    - BEAM
    - plug_cowboy
    - ecto_sql
    - absinthe
    - redix
    - tesla
    - phoenix_live_view
    - memcachex
    - broadway
    - oban
    - nebulex
    - horde
    - gen_rmq
    - finch

  Database cron based metrics:
    - Postgres (look at https://github.com/pawurb/ecto_psql_extras for inspiration)
    - MySQL
    - Redis
    - MongoDB

  Each plugin also has an accompanying Grafana dashboard that you can
  leverage to plot all of the captured data (see each project's GitHub
  repo for details).

  In order to expose captured metrics, you can leverage the PromEx Plug
  found here (for use with Phoenix or vanilla Plug):
  - exporter (coming soon)
  """

  alias PromEx.{PollableMetrics, StandardMetrics}
  alias TelemetryMetricsPrometheus.Core

  @doc """
  The metrics/0 function returns a list of metrics that will be exposed
  by the given plugin. By using the PromEx module, you have access to the
  following metrics types which are supported by prometheus:
  - counter
  - distribution
  - last_value
  - sum

  For example, if you wanted to expose a group of metrics your metrics/0
  function would look like so:

  ```elixir
  def metrics do
    StandardMetrics.build([
      counter("my_app.data_point.count"),
      last_value("my_app.some_other.data_point")
    ])
  end
  ```
  """
  @callback metrics :: [PollableMetrics.t() | StandardMetrics.t()] | PollableMetrics.t() | StandardMetrics.t()

  @doc """
  The metrics/1 function is similar to metrics/0 in that it is a list of the
  metrics that the plugin exposes. The only caveat here being that arbitrary
  options may be passed to the plugin to
  """
  @callback metrics(keyword()) ::
              [PollableMetrics.t() | StandardMetrics.t()] | PollableMetrics.t() | StandardMetrics.t()

  defmacro __using__ do
    quote do
      @behaviour PromEx

      import Telemetry.Metrics, only: [counter: 2, distribution: 2, last_value: 2, sum: 2]

      alias PromEx.{PollableMetrics, StandardMetrics}

      def metrics, do: raise("#{__MODULE__} must implement metrics/0 function")

      def metrics(_opts), do: raise("#{__MODULE__} must implement metrics/1 function")

      defoverridable PromEx
    end
  end

  @doc """
  This function initializes all of the provided plugins and aggregates the
  metrics list.
  """
  def init_plugins(plugins) do
    {pollable_metrics, standard_metrics} =
      plugins
      |> Enum.reduce([], fn plugin_definition, acc ->
        [init_plugin(plugin_definition) | acc]
      end)
      |> List.flatten()
      |> Enum.split_with(fn
        %PollableMetrics{} -> true
        %StandardMetrics{} -> false
      end)

    # TODO: PromEx needs to be a supervisor that starts the pollers and standard metrics
    # This probably isn't the correct return value
    {Core, metrics: aggregated_metrics, require_seconds: false, consistent_units: true}
  end

  @doc """
  A simple passthrough to fetch all of the currently configured metrics. This is
  primarily used by the exporter plug to fetch all of the metrics so that they
  can be scraped.
  """
  def get_metrics do
    Core.scrape()
  end

  defp init_plugin({module, opts}) when is_atom(module) do
    # TODO: Should there be any PromEx level options like :omit for
    # skipping a single metric point
    module.metrics(opts)
  end

  defp init_plugin(module) when is_atom(module) do
    module.metrics()
  end

  defp validate_metrics(metrics) do
  end
end
