defmodule PromEx do
  @moduledoc """
  PromEx is a plugin based library which can be used to capture
  telemetry events and report them out for consumption by Prometheus.
  The main purpose of this particular library is to provide the
  behaviour that all PromEx plugins leverage so that a consistent
  interface can be achieved and so that leveraging multiple plugins is
  effortless from the user's point of view.

  All metrics collection will be delegated to plugins which can be found here:

  Foundational metrics:
    - [~] `PromEx.Plugins.Application` Application related infomational metrics
    - [~] `PromEx.Plugins.Beam` BEAM virtual machine metrics

  Upcoming Elixir library metrics:
    - [~] Phoenix (https://hexdocs.pm/phoenix/Phoenix.Logger.html)
    - [ ] Ecto (https://hexdocs.pm/ecto/Ecto.Repo.html#module-telemetry-events)
    - [ ] Broadway (https://hexdocs.pm/broadway/Broadway.html#module-telemetry)
    - [ ] Finch (https://hexdocs.pm/finch/Finch.Telemetry.html#content)

  Backlog Elixir library metrics:
    - [ ] Absinthe (https://hexdocs.pm/absinthe/1.5.3/telemetry.html)
    - [ ] Dataloader (https://hexdocs.pm/dataloader/telemetry.html)
    - [ ] GenRMQ (https://hexdocs.pm/gen_rmq/3.0.0/GenRMQ.Publisher.Telemetry.html and https://hexdocs.pm/gen_rmq/3.0.0/GenRMQ.Consumer.Telemetry.html)
    - [ ] Plug (https://hexdocs.pm/plug/Plug.Telemetry.html)
    - [ ] PlugCowboy (https://hexdocs.pm/plug_cowboy/2.4.0/Plug.Cowboy.html#module-instrumentation)
    - [ ] Redix (https://hexdocs.pm/redix/Redix.Telemetry.html)
    - [ ] Tesla (https://hexdocs.pm/tesla/Tesla.Middleware.Telemetry.html)
    - [ ] PhoenixLiveView (https://hexdocs.pm/phoenix_live_view/telemetry.html)
    - [ ] Memcachex (https://hexdocs.pm/memcachex/0.5.0/Memcache.html#module-telemetry)
    - [ ] Oban (https://hexdocs.pm/oban/Oban.Telemetry.html)
    - [ ] Nebulex (https://hexdocs.pm/nebulex/2.0.0-rc.0/telemetry.html)
    - [ ] Horde (https://github.com/derekkraan/horde/blob/master/lib/horde/supervisor_telemetry_poller.ex)
    - [ ] Cachex (Need to open up PR)

  Database cron based metrics:
    - [ ] Postgres (https://github.com/pawurb/ecto_psql_extras for inspiration)
    - [ ] MySQL (https://github.com/prometheus/mysqld_exporter)
    - [ ] Redis (https://github.com/oliver006/redis_exporter)
    - [ ] MongoDB (https://github.com/percona/mongodb_exporter)

  Each plugin also has an accompanying Grafana dashboard that you can
  leverage to plot all of the captured data (see each project's GitHub
  repo for details).

  In order to expose captured metrics, you can leverage the PromEx provided Plug
  found here (for use with Phoenix) `PromEx.Plug`. See that modules' documentation
  for specifics on how to use it.
  """

  alias PromEx.{
    EventMetrics,
    ManualMetrics,
    ManualMetricsManager,
    PollMetrics
  }

  alias TelemetryMetricsPrometheus.Core

  use Supervisor

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
    EventMetrics.build([
      counter("my_app.data_point.count"),
      last_value("my_app.some_other.data_point")
    ])
  end
  ```
  """
  @callback metrics ::
              [PollMetrics.t() | EventMetrics.t() | ManualMetrics.t()]
              | PollMetrics.t()
              | EventMetrics.t()
              | ManualMetrics.t()

  @doc """
  The metrics/1 function is similar to metrics/0 in that it is a list of the
  metrics that the plugin exposes. The only caveat here being that arbitrary
  options may be passed to the plugin to
  """
  @callback metrics(keyword()) ::
              [PollMetrics.t() | EventMetrics.t()] | PollMetrics.t() | EventMetrics.t()

  defmacro __using__(_) do
    quote do
      @behaviour PromEx

      import Telemetry.Metrics, only: [counter: 2, distribution: 2, last_value: 2, sum: 2]
      import PromEx.BucketGenerator

      alias PromEx.{EventMetrics, ManualMetrics, PollMetrics, BucketGenerator}

      def metrics, do: raise("#{__MODULE__} must implement metrics/0 function")

      def metrics(_opts), do: raise("#{__MODULE__} must implement metrics/1 function")

      defoverridable PromEx
    end
  end

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    plugins =
      opts
      |> Keyword.get(:plugins, [])
      |> init_plugins()

    telemetry_metrics = Map.get(plugins, :telemetry_metrics, [])
    poll_metrics = Map.get(plugins, :poll_metrics, [])
    manual_metrics = Map.get(plugins, :manual_metrics, [])

    # Create child specs for each group of poll rates
    telemetry_poller_children = generate_telemetry_poller_child_spec(poll_metrics)

    children = [
      {
        Core,
        metrics: telemetry_metrics,
        require_seconds: false,
        consistent_units: true,
        name: :prom_ex_metrics,
        start_async: false
      },
      {
        ManualMetricsManager,
        metrics: generate_mfa_call_list(manual_metrics),
        delay_manual_start: Keyword.get(opts, :delay_manual_start, :no_delay)
      }
      | telemetry_poller_children
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp init_plugins(plugins) do
    grouped_plugins =
      plugins
      |> Enum.reduce([], fn plugin_definition, acc ->
        [init_plugin(plugin_definition) | acc]
      end)
      |> List.flatten()
      |> Enum.group_by(fn %{__struct__: struct} ->
        struct
        |> Module.split()
        |> List.last()
        |> Macro.underscore()
        |> String.to_existing_atom()
      end)

    event_metrics = Map.get(grouped_plugins, :event_metrics, [])
    poll_metrics = Map.get(grouped_plugins, :poll_metrics, [])
    manual_metrics = Map.get(grouped_plugins, :manual_metrics, [])

    telemetry_metrics =
      (event_metrics ++ poll_metrics ++ manual_metrics)
      |> Enum.map(fn
        %EventMetrics{metrics: metrics} ->
          metrics

        %PollMetrics{metrics: metrics} ->
          metrics

        %ManualMetrics{metrics: metrics} ->
          metrics
      end)
      |> List.flatten()

    %{
      telemetry_metrics: telemetry_metrics,
      event_metrics: event_metrics,
      poll_metrics: poll_metrics,
      manual_metrics: manual_metrics
    }
  end

  defp generate_telemetry_poller_child_spec(pollable_metrics) do
    pollable_metrics
    |> Enum.group_by(fn %PollMetrics{poll_rate: poll_rate} ->
      poll_rate
    end)
    |> Enum.map(fn {poll_rate, pollable_metrics} ->
      measurements =
        pollable_metrics
        |> Enum.map(fn %PollMetrics{measurements_mfa: measurements_mfa} ->
          measurements_mfa
        end)

      {
        :telemetry_poller,
        measurements: measurements, poll_rate: poll_rate
      }
    end)
  end

  defp generate_mfa_call_list(manual_metrics) do
    manual_metrics
    |> Enum.map(fn %ManualMetrics{measurements_mfa: mfa} ->
      mfa
    end)
  end

  @doc """
  A simple passthrough to fetch all of the currently configured metrics. This is
  primarily used by the exporter plug to fetch all of the metrics so that they
  can be scraped.
  """
  def get_metrics do
    Core.scrape(:prom_ex_metrics)
  end

  defp init_plugin({module, opts}) when is_atom(module) do
    module.metrics(opts)
  end

  defp init_plugin(module) when is_atom(module) do
    module.metrics()
  end
end
