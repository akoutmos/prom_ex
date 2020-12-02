defmodule PromEx do
  @moduledoc """
  PromEx is a plugin based library which can be used to capture
  telemetry events and report them out for consumption by Prometheus.
  The main purpose of this particular library is to provide the
  behaviour that all PromEx plugins leverage so that a consistent
  interface can be achieved and so that leveraging multiple plugins is
  effortless from the user's point of view.

  To use PromEx you need to define a module that uses the PromEx library. When using
  PromEx you have a few options available to you. For example, you can do the
  following:

  ```elixir
  defmodule MyApp.PromEx do
    use PromEx,
      otp_app: :web_app,
      delay_manual_start: :no_delay,
      drop_metrics_groups: [],
      upload_dashboards_on_start: true

    ...
  end
  ```

  The options that you can pass to PromEx are outlined in the following section. In order to
  tell PromEx what plugins you would like to use and what dashboards you would like PromEx to
  upload for you, implement the `plugins/0` and `dashboards/0` callbacks respectively. Each
  plugin also has an accompanying Grafana dashboard that you can leverage to plot all of the
  plugin captured data.

  In order to expose captured metrics, you can leverage the PromEx provided Plug `PromEx.Plug`.
  See the `PromEx.Plug` documentation modules for specifics on how to use it.

  ## Options

  * `:otp_app` - This is a required option and is used by PromEx to fetch the application
    configuration values for the various PromEx caputure modules. Make sure that this value
    matches the `:app` value in `project/0` from your `mix.exs` file. If you use the PromEx
    `mix prom_ex.create` mix task this will be done automatically for you.

  ## PromEx Plugins

  All metrics collection will be delegated to plugins which can be found here:

  Foundational metrics:
    - [X] `PromEx.Plugins.Application` Application related informational metrics
    - [X] `PromEx.Plugins.Beam` BEAM virtual machine metrics

  Library metrics:
    - [X] Phoenix (https://hexdocs.pm/phoenix/Phoenix.Logger.html)

  Upcoming Elixir library metrics:
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
  """

  require Logger

  alias PromEx.MetricTypes.{
    Event,
    Manual,
    Polling
  }

  alias Telemetry.Metrics.{Counter, Distribution, LastValue, Sum, Summary}

  alias PromEx.TelemetryMetricsPrometheus.Core

  @type telemetry_metrics() :: Counter.t() | Distribution.t() | LastValue.t() | Sum.t() | Summary.t()
  @type measurements_mfa() :: {module(), atom(), list()}

  @doc """
  A simple pass-through to fetch all of the currently configured metrics. This is
  primarily used by the exporter plug to fetch all of the metrics so that they
  can be scraped.
  """
  @spec get_metrics(prom_ex_module :: module()) :: String.t() | :prom_ex_down
  def get_metrics(prom_ex_module) do
    prom_ex_process_name = prom_ex_module.__metrics_collector_name__()

    if Process.whereis(prom_ex_process_name),
      do: Core.scrape(prom_ex_process_name),
      else: :prom_ex_down
  end

  @callback init_opts :: PromEx.Config.t()
  @callback plugins :: list()
  @callback dashboards :: list()

  defmacro __using__(opts) do
    # Get calling module name
    %Macro.Env{module: calling_module} = __CALLER__

    # Ensure that required otp_app option is provided
    otp_app =
      case Keyword.fetch(opts, :otp_app) do
        {:ok, otp_app} ->
          otp_app

        :error ->
          raise "Failed to initialize #{inspect(calling_module)} due to missing :otp_app option"
      end

    # Generate process names under calling module namespace
    manual_metrics_name = Module.concat([calling_module, ManualMetricsManager])
    metrics_collector_name = Module.concat([calling_module, Metrics])
    dashboard_uploader_name = Module.concat([calling_module, DashboardUploader])
    metrics_server_name = Module.concat([calling_module, MetricsServer])

    quote do
      @behaviour PromEx

      use Supervisor

      @doc false
      def start_link(_) do
        Supervisor.start_link(__MODULE__, [], name: __MODULE__)
      end

      @impl true
      def init(_) do
        # Get module init options from module callback
        %PromEx.Config{
          manual_metrics_start_delay: manual_metrics_start_delay,
          drop_metrics_groups: drop_metrics_groups,
          grafana_config: grafana_config,
          metrics_server_config: metrics_server_config
        } = __MODULE__.init_opts()

        # Configure each of the desired plugins
        plugins =
          __MODULE__.plugins()
          |> PromEx.init_plugins(drop_metrics_groups)

        # Extract the various metrics types from all of the plugins
        telemetry_metrics = Map.get(plugins, :telemetry_metrics, [])
        poll_metrics = Map.get(plugins, :poll_metrics, [])
        manual_metrics = Map.get(plugins, :manual_metrics, [])

        # Start the relevant child processes depending on configuration
        children =
          []
          |> PromEx.metrics_collector_child_spec(telemetry_metrics, unquote(metrics_collector_name))
          |> PromEx.manual_metrics_child_spec(manual_metrics, manual_metrics_start_delay, unquote(manual_metrics_name))
          |> PromEx.poller_child_specs(poll_metrics, __MODULE__)
          |> PromEx.dashboard_uploader_child_spec(
            grafana_config,
            __MODULE__,
            unquote(dashboard_uploader_name)
          )
          |> PromEx.metrics_server_child_spec(
            metrics_server_config,
            __MODULE__,
            unquote(metrics_server_name)
          )
          |> Enum.reverse()

        Supervisor.init(children, strategy: :one_for_one, name: __MODULE__)
      end

      @doc false
      @impl true
      def init_opts do
        unquote(otp_app)
        |> Application.get_env(__MODULE__, [])
        |> PromEx.Config.build()
      end

      @doc false
      @impl true
      def plugins, do: []

      @doc false
      @impl true
      def dashboards, do: []

      @doc false
      def __manual_metrics_name__ do
        unquote(manual_metrics_name)
      end

      @doc false
      def __metrics_collector_name__ do
        unquote(metrics_collector_name)
      end

      @doc false
      def __dashboard_uploader_name__ do
        unquote(dashboard_uploader_name)
      end

      @doc false
      def __metrics_server_name__ do
        unquote(metrics_server_name)
      end

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
  def metrics_collector_child_spec(acc, metrics, process_name) do
    spec = {
      Core,
      name: process_name, metrics: metrics, require_seconds: false, consistent_units: true, start_async: false
    }

    [spec | acc]
  end

  @doc false
  def manual_metrics_child_spec(acc, metrics, manual_metrics_start_delay, process_name) do
    spec = {
      PromEx.ManualMetricsManager,
      name: process_name, metrics: generate_mfa_call_list(metrics), delay_manual_start: manual_metrics_start_delay
    }

    [spec | acc]
  end

  @doc false
  def poller_child_specs(acc, metrics, prom_ex_module) do
    # Create child specs for each group of poll rates
    telemetry_poller_children = generate_telemetry_poller_child_spec(prom_ex_module, metrics)

    telemetry_poller_children ++ acc
  end

  @doc false
  def dashboard_uploader_child_spec(acc, %{upload_dashboards_on_start: true}, prom_ex_module, process_name) do
    spec = {
      PromEx.DashboardUploader,
      name: process_name, prom_ex_module: prom_ex_module
    }

    [spec | acc]
  end

  def dashboard_uploader_child_spec(acc, %{upload_dashboards_on_start: false}, _, _) do
    acc
  end

  def dashboard_uploader_child_spec(acc, :disabled, _, _) do
    acc
  end

  @doc false
  def metrics_server_child_spec(acc, config, prom_ex_module, process_name) when is_map(config) do
    transport_options = [num_acceptors: config.pool_size]
    cowboy_opts = Keyword.drop(config.cowboy_opts, [:port, :transport_options])

    port =
      case Map.fetch(config, :port) do
        {:ok, port} when is_integer(port) ->
          port

        {:ok, port} when is_binary(port) ->
          String.to_integer(port)

        :error ->
          raise "PromEx.MetricsServer requires a :port config value"
      end

    scheme =
      config
      |> Map.fetch(:protocol)
      |> case do
        {:ok, "http"} ->
          :http

        {:ok, "https"} ->
          :https

        {:ok, :http} ->
          :http

        {:ok, :https} ->
          :https

        :error ->
          raise "PromEx.MetricsServer requires a :protocol config value of :http or :https"

        _ ->
          raise "Invalid :protocol config value provided to PromEx.MetricsServer (valid values are :http and :https)"
      end

    plug_definition = {PromEx.MetricsServer.Plug, path: config.path, prom_ex_module: prom_ex_module}

    spec =
      Plug.Cowboy.child_spec(
        ref: process_name,
        scheme: scheme,
        plug: plug_definition,
        options: [{:port, port}, {:transport_options, transport_options} | cowboy_opts]
      )

    Logger.info(
      "PromEx is starting a standalone metrics server on port #{inspect(port)} over #{Atom.to_string(scheme)}"
    )

    [spec | acc]
  end

  def metrics_server_child_spec(acc, :disabled, _prom_ex_module, _process_name) do
    acc
  end

  defp generate_telemetry_poller_child_spec(prom_ex_module, pollable_metrics) do
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

      # Creating an atom of the time interval so that additional
      # metrics pollers don't have name collisions. While String.to_atom/1
      # is being used here, it is assumed that this is trusted input and not
      # infinitely bounded.
      uniqe_poll_value =
        poll_rate
        |> Integer.to_string()
        |> String.to_atom()

      {
        :telemetry_poller,
        name: Module.concat([prom_ex_module, Poller, uniqe_poll_value]),
        measurements: measurements,
        poll_rate: poll_rate
      }
    end)
  end

  defp generate_mfa_call_list(manual_metrics) do
    manual_metrics
    |> Enum.map(fn %Manual{measurements_mfa: mfa} ->
      mfa
    end)
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
