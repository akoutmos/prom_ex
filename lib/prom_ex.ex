defmodule PromEx do
  @moduledoc """
  PromEx is a plugin based library which can be used to capture
  telemetry events and report them out for consumption by Prometheus.
  The main purpose of this particular library is to provide the
  behaviour that all PromEx plugins leverage so that a consistent
  interface can be achieved and so that leveraging multiple plugins is
  effortless from the user's point of view.


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

  * `:drop_metrics_groups` - A list of all the metrics groups that you are not interested in
    tracking. For example, if your application does not leverage Phoenix channels at all but
    you still would like to use the `PromEx.Plugins.Phoenix` plugin, you can pass
    [`:phoenix_channel_event_metrics`] as the value to `:drop_metrics_groups` and that set of
    metrics will not be caputred.



  All metrics collection will be delegated to plugins which can be found here:

  Foundational metrics:
    - [X] `PromEx.Plugins.Application` Application related informational metrics
    - [X] `PromEx.Plugins.Beam` BEAM virtual machine metrics

  Upcoming Elixir library metrics:
    - [X] Phoenix (https://hexdocs.pm/phoenix/Phoenix.Logger.html)
    - [ ] Ecto (https://hexdocs.pm/ecto/Ecto.Repo.html#module-telemetry-events)
    - [ ] Plug (https://hexdocs.pm/plug/Plug.Telemetry.html)
    - [ ] Broadway (https://hexdocs.pm/broadway/Broadway.html#module-telemetry)
    - [ ] Oban (https://hexdocs.pm/oban/Oban.Telemetry.html)
    - [ ] Operating System (http://erlang.org/doc/man/os_mon_app.html)

  Backlog Elixir library metrics:
    - [ ] Absinthe (https://hexdocs.pm/absinthe/1.5.3/telemetry.html)
    - [ ] PhoenixLiveView (https://hexdocs.pm/phoenix_live_view/telemetry.html)
    - [ ] Dataloader (https://hexdocs.pm/dataloader/telemetry.html)
    - [ ] GenRMQ (https://hexdocs.pm/gen_rmq/3.0.0/GenRMQ.Publisher.Telemetry.html and https://hexdocs.pm/gen_rmq/3.0.0/GenRMQ.Consumer.Telemetry.html)
    - [ ] Plug (https://hexdocs.pm/plug/Plug.Telemetry.html)
    - [ ] PlugCowboy (https://hexdocs.pm/plug_cowboy/2.4.0/Plug.Cowboy.html#module-instrumentation)
    - [ ] Redix (https://hexdocs.pm/redix/Redix.Telemetry.html)
    - [ ] Tesla (https://hexdocs.pm/tesla/Tesla.Middleware.Telemetry.html)
    - [ ] Memcachex (https://hexdocs.pm/memcachex/0.5.0/Memcache.html#module-telemetry)
    - [ ] Finch (https://hexdocs.pm/finch/Finch.Telemetry.html#content)
    - [ ] Nebulex (https://hexdocs.pm/nebulex/2.0.0-rc.0/telemetry.html)
    - [ ] Horde (https://github.com/derekkraan/horde/blob/master/lib/horde/supervisor_telemetry_poller.ex)
    - [ ] Cachex (Need to open up PR)
    - [ ] Quantum (https://hexdocs.pm/quantum/3.3.0/telemetry.html#content)

  Database cron based metrics:
    - [ ] Postgres (https://github.com/pawurb/ecto_psql_extras for inspiration)
    - [ ] Mnesia (https://github.com/deadtrickster/prometheus.erl/blob/master/src/collectors/mnesia/prometheus_mnesia_collector.erl for inspiration)
    - [ ] MySQL (https://github.com/prometheus/mysqld_exporter for inspiration)
    - [ ] Redis (https://github.com/oliver006/redis_exporter for inspiration)
    - [ ] MongoDB (https://github.com/percona/mongodb_exporter for inspiration)

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

  alias PromEx.TelemetryMetricsPrometheus.Core

  @doc """
  A simple pass-through to fetch all of the currently configured metrics. This is
  primarily used by the exporter plug to fetch all of the metrics so that they
  can be scraped.
  """
  @spec get_metrics(prom_ex_module :: module()) :: String.t() | :prom_ex_down
  def get_metrics(prom_ex_module) do
    prom_ex_process_name = generate_metrics_module_name(prom_ex_module)

    if Process.whereis(prom_ex_process_name),
      do: Core.scrape(prom_ex_process_name),
      else: :prom_ex_down
  end

  @callback init_opts :: list()
  @callback plugins :: list()
  @callback dashboards :: list()

  defmacro __using__(opts) do
    # Set defaults from opts
    otp_app =
      case Keyword.fetch(opts, :otp_app) do
        {:ok, otp_app} ->
          otp_app

        :error ->
          %Macro.Env{module: calling_module} = __CALLER__
          raise "Failed to initialize #{inspect(calling_module)} due to missing :otp_app option"
      end

    delay_manual_start = Keyword.get(opts, :delay_manual_start, :no_delay)
    drop_metrics_groups = Keyword.get(opts, :drop_metrics_groups, [])
    upload_dashboards_on_start = Keyword.get(opts, :upload_dashboards_on_start, false)

    quote do
      @behaviour PromEx

      alias PromEx.ManualMetricsManager
      alias PromEx.TelemetryMetricsPrometheus.Core

      use Supervisor

      @doc false
      def start_link(_) do
        Supervisor.start_link(__MODULE__, [], name: __MODULE__)
      end

      @impl true
      def init(_) do
        # Get module init options from module callback
        opts = __MODULE__.init_opts()

        # Get options
        manual_start_delay = Keyword.get(opts, :delay_manual_start, :no_delay)

        drop_metrics_groups =
          opts
          |> Keyword.get(:drop_metrics_groups, [])
          |> MapSet.new()

        plugins =
          __MODULE__.plugins()
          |> PromEx.init_plugins(drop_metrics_groups)

        telemetry_metrics = Map.get(plugins, :telemetry_metrics, [])
        poll_metrics = Map.get(plugins, :poll_metrics, [])
        manual_metrics = Map.get(plugins, :manual_metrics, [])

        # Create child specs for each group of poll rates
        telemetry_poller_children = PromEx.generate_telemetry_poller_child_spec(poll_metrics)

        children = [
          {
            Core,
            metrics: telemetry_metrics,
            require_seconds: false,
            consistent_units: true,
            name: PromEx.generate_metrics_module_name(__MODULE__),
            start_async: false
          },
          {
            ManualMetricsManager,
            metrics: PromEx.generate_mfa_call_list(manual_metrics),
            delay_manual_start: manual_start_delay,
            name: PromEx.generate_manual_metrics_module_name(__MODULE__)
          }
          | telemetry_poller_children
        ]

        children =
          if unquote(upload_dashboards_on_start) do
            [
              {
                PromEx.DashboardUploader,
                name: PromEx.generate_uploader_module_name(__MODULE__), prom_ex_module: __MODULE__
              }
              | children
            ]
          else
            children
          end

        Supervisor.init(children, strategy: :one_for_one)
      end

      @doc false
      @impl true
      def init_opts do
        [
          otp_app: unquote(otp_app),
          delay_manual_start: unquote(delay_manual_start),
          drop_metrics_groups: unquote(drop_metrics_groups),
          upload_dashboards_on_start: unquote(upload_dashboards_on_start)
        ]
      end

      @doc false
      @impl true
      def plugins, do: []

      @doc false
      @impl true
      def dashboards, do: []

      defoverridable PromEx
    end
  end

  @doc false
  def init_plugins(plugins, drop_metrics_groups) do
    # Adding default PromEx plugin
    plugins = [PromEx.Plugins.PromEx | plugins]

    # Extract relevant metrics based on type
    event_metrics = extract_relevant_metrics(plugins, :event_metrics, drop_metrics_groups)
    polling_metrics = extract_relevant_metrics(plugins, :polling_metrics, drop_metrics_groups)
    manual_metrics = extract_relevant_metrics(plugins, :manual_metrics, drop_metrics_groups)

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

  @doc false
  def generate_telemetry_poller_child_spec(pollable_metrics) do
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

  @doc false
  def generate_mfa_call_list(manual_metrics) do
    manual_metrics
    |> Enum.map(fn %Manual{measurements_mfa: mfa} ->
      mfa
    end)
  end

  @doc false
  def generate_manual_metrics_module_name(base_module) do
    Module.concat([base_module, ManualMetricsManager])
  end

  @doc false
  def generate_metrics_module_name(base_module) do
    Module.concat([base_module, Metrics])
  end

  @doc false
  def generate_uploader_module_name(base_module) do
    Module.concat([base_module, DashboardUploader])
  end

  defp extract_relevant_metrics(plugins, type, drop_metrics_groups) do
    plugins
    |> Enum.map(fn plugin_definition ->
      init_plugin(plugin_definition, type)
    end)
    |> List.flatten()
    |> Enum.reject(fn %_{group_name: group_name} ->
      MapSet.member?(drop_metrics_groups, group_name)
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
