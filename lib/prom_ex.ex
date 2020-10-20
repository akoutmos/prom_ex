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
    - [~] `PromEx.Plugins.Application` Application related informational metrics
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

  alias PromEx.MetricTypes.{
    Event,
    Manual,
    Polling
  }

  alias PromEx.ManualMetricsManager

  alias TelemetryMetricsPrometheus.Core

  alias Telemetry.Metrics.{Counter, Distribution, LastValue, Sum, Summary}

  use Supervisor

  @type telemetry_metrics() :: Counter.t() | Distribution.t() | LastValue.t() | Sum.t() | Summary.t()

  @doc """
  The event_metrics/1 callback returns the configured event based metrics that the
  plugin exposes. If the plugin does not expose any event style metrics, there is a
  default implementation of this function that returns an empty list. In other words,
  if your plugin does not expose any event style metrics, there is no action needed
  on your part.

  This function is expected to either return a single `PromEx.Plugins.Event` struct
  or a list of `PromEx.Plugins.Event` structs.
  """
  @callback event_metrics(keyword()) :: [Event.t()] | Event.t()

  @doc """
  The polling_metrics/1 callback returns the configured polling based metrics that the
  plugin exposes. If the plugin does not expose any polling style metrics, there is a
  default implementation of this function that returns an empty list. In other words,
  if your plugin does not expose any polling style metrics, there is no action needed
  on your part.

  This function is expected to either return a single `PromEx.Plugins.Polling` struct
  or a list of `PromEx.Plugins.Polling` structs.
  """
  @callback polling_metrics(keyword()) :: [Polling.t()] | Polling.t()

  @doc """
  The manual_metrics/1 callback returns the configured manual based metrics that the
  plugin exposes. If the plugin does not expose any manual style metrics, there is a
  default implementation of this function that returns an empty list. In other words,
  if your plugin does not expose any manual style metrics, there is no action needed
  on your part.

  This function is expected to either return a single `PromEx.Plugins.Manual` struct
  or a list of `PromEx.Plugins.Manual` structs.
  """
  @callback manual_metrics(keyword()) :: [Manual.t()] | Manual.t()

  defmacro __using__(_) do
    quote do
      @behaviour PromEx

      import Telemetry.Metrics, only: [counter: 2, distribution: 2, last_value: 2, sum: 2]
      import PromEx.BucketGenerator

      alias PromEx.MetricTypes.{Event, Manual, Polling}

      def event_metrics(_), do: []
      def polling_metrics(_), do: []
      def manual_metrics(_), do: []

      defoverridable PromEx
    end
  end

  @doc """
  Starts a PromEx process with the provided plugins initialized.

  ## Options

  * `:plugins` - The list of plugin modules that you would like PromEx to initialize. Each
    plugin definition can either be a two element tuple with the structure
    `{PlugIn.Module, keyword: "list", of: "options"}` or just the module name `PlugIn.Module`.
    Be sure to check the documentation for each plugin that you are using to ensure that you
    satisfy any required option fields.

  * `:delay_manual_start` - Manual metrics are gathered once on start up and then only when
    you call `PromEx.ManualMetricsManager.refresh_metrics()`. Sometimes, you may have metrics
    that require your entire supervision tree to be started in order to fetch accurate data.
    This option will allow you to delays the initial metrics capture of the
    `ManualMetricsManager` by a certain number of milliseconds or the `:no_delay` atom if you
    want the metrics to be captured as soon as the `ManualMetricsManager` starts up.
  """
  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    # Get options
    manual_start_delay = Keyword.get(opts, :delay_manual_start, :no_delay)

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
        metrics: generate_mfa_call_list(manual_metrics), delay_manual_start: manual_start_delay
      }
      | telemetry_poller_children
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  @doc """
  A simple pass-through to fetch all of the currently configured metrics. This is
  primarily used by the exporter plug to fetch all of the metrics so that they
  can be scraped.
  """
  @spec get_metrics :: String.t()
  def get_metrics do
    Core.scrape(:prom_ex_metrics)
  end

  defp init_plugins(plugins) do
    event_metrics =
      plugins
      |> Enum.map(fn plugin_definition ->
        init_plugin(plugin_definition, :event_metrics)
      end)
      |> List.flatten()

    polling_metrics =
      plugins
      |> Enum.map(fn plugin_definition ->
        init_plugin(plugin_definition, :polling_metrics)
      end)
      |> List.flatten()

    manual_metrics =
      plugins
      |> Enum.map(fn plugin_definition ->
        init_plugin(plugin_definition, :manual_metrics)
      end)
      |> List.flatten()

    telemetry_metrics =
      [event_metrics, polling_metrics, manual_metrics]
      |> List.flatten()
      |> Enum.map(fn
        %Event{metrics: metrics} ->
          metrics

        %Polling{metrics: metrics} ->
          metrics

        %Manual{metrics: metrics} ->
          metrics
      end)
      |> List.flatten()

    %{
      telemetry_metrics: telemetry_metrics,
      event_metrics: event_metrics,
      poll_metrics: polling_metrics,
      manual_metrics: manual_metrics
    }
  end

  defp generate_telemetry_poller_child_spec(pollable_metrics) do
    pollable_metrics
    |> Enum.group_by(fn %Polling{poll_rate: poll_rate} ->
      poll_rate
    end)
    |> Enum.map(fn {poll_rate, pollable_metrics} ->
      measurements =
        pollable_metrics
        |> Enum.map(fn %Polling{measurements_mfa: measurements_mfa} ->
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
    |> Enum.map(fn %Manual{measurements_mfa: mfa} ->
      mfa
    end)
  end

  defp init_plugin({module, opts}, function) when is_atom(module) do
    module
    |> apply(function, [opts])
    |> normalize_plugin()
  end

  defp init_plugin(module, function) when is_atom(module) do
    module
    |> apply(function, [[]])
    |> normalize_plugin()
  end

  defp normalize_plugin(metric_definitions) when is_list(metric_definitions) do
    metric_definitions
  end

  defp normalize_plugin(metric_definition) do
    [metric_definition]
  end
end
