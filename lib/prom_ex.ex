defmodule PromEx do
  @moduledoc """
  PromEx is a plugin based library which can be used to capture
  telemetry events and report them out for consumption by Prometheus.
  The main purpose of this particular library is to provide the
  behaviour that all PromEx plugins leverage so that a consistent
  interface can be achieved and so that leveraging multiple plugins is
  effortless from the user's point of view.

  To use PromEx you need to define a module that uses the PromEx library. This module
  will also need to have some application config set for it similarly to how Ecto does.
  For example, for a PromEx module defined like so:

  ```elixir
  defmodule MyApp.PromEx do
    use PromEx,  otp_app: :web_app

    ...
  end
  ```

  You would have an application configuration set like so:

  ```elixir
  config :my_app, MyApp.PromEx,
    manual_metrics_start_delay: :no_delay,
    drop_metrics_groups: [],
    grafana: [
      host: System.get_env("GRAFANA_HOST", "http://grafana:3000"),
      auth_token: System.get_env("GRAFANA_TOKEN", ""),
      upload_dashboards_on_start: true,
      folder_name: "My App Dashboards",
      annotate_app_lifecycle: true
    ]
  ```

  The options that you can pass to PromEx macro are outlined in the following section. In order
  to tell PromEx what plugins you would like to use and what dashboards you would like PromEx
  to upload for you, implement the `plugins/0` and `dashboards/0` callbacks respectively. The
  `dashboard_assigns/0` callback will be used when your EEx template Grafana dashboards are
  rendered so that the dashboards that are created for your application coincide with the PromEx
  configuration for the application. If your dashboards are not EEx templates, then the dashboard
  assigns are not passed through. Each plugin also has an accompanying Grafana dashboard that you
  can leverage to plot all of the plugin captured data.

  In order to expose captured metrics, you can leverage the PromEx provided Plug `PromEx.Plug`.
  See the `PromEx.Plug` documentation modules for specifics on how to use it.

  ## Options

  * `:otp_app` - This is a REQUIRED field and is used by PromEx to fetch the application
    configuration values for the various PromEx capture modules. Make sure that this value
    matches the `:app` value in `project/0` from your `mix.exs` file. If you use the PromEx
    `mix prom_ex.create` mix task this will be done automatically for you.

  ## PromEx Plugins

  All metrics collection will be delegated to plugins which can be found here:

  Foundational metrics:
    - [X] `PromEx.Plugins.Application` Application related informational metrics
    - [X] `PromEx.Plugins.Beam` BEAM virtual machine metrics
    - [ ] Operating System (http://erlang.org/doc/man/os_mon_app.html)

  Library metrics:
    - [X] `PromEx.Plugins.Ecto` - [Telemetry docs](https://hexdocs.pm/ecto/Ecto.Repo.html#module-telemetry-events)
    - [X] `PromEx.Plugins.Oban` - [Telemetry docs](https://hexdocs.pm/oban/Oban.Telemetry.html)
    - [X] `PromEx.Plugins.Phoenix` - [Telemetry docs](https://hexdocs.pm/phoenix/Phoenix.Logger.html)
    - [X] `PromEx.Plugins.PhoenixLiveView` - [Telemetry docs](https://hexdocs.pm/phoenix_live_view/telemetry.html)
    - [X] `PromEx.Plugins.Absinthe` - [Telemetry docs](https://hexdocs.pm/absinthe/1.5.3/telemetry.html)
    - [X] `PromEx.Plugins.PlugCowboy` - [Telemetry docs](https://hexdocs.pm/plug_cowboy/2.4.0/Plug.Cowboy.html#module-instrumentation)
    - [X] `PromEx.Plugins.PlugRouter` - [Telemetry docs](https://hexdocs.pm/plug/1.12.1/Plug.Router.html#module-telemetry)
    - [X] `PromEx.Plugins.Broadway` - [Telemetry docs](https://hexdocs.pm/broadway/Broadway.html#module-telemetry)

  Backlog Elixir library metrics:
    - [ ] Finch - [Telemetry docs](https://hexdocs.pm/finch/Finch.Telemetry.html#content)
    - [ ] Swoosh - [Telemetry docs](https://hexdocs.pm/swoosh/1.5.0/Swoosh.html#module-telemetry)
    - [ ] ChromicPDF - [Telemetry docs](https://hexdocs.pm/chromic_pdf/ChromicPDF.html#module-telemetry-support)
    - [ ] Dataloader - [Telemetry docs](https://hexdocs.pm/dataloader/telemetry.html)
    - [ ] GenRMQ - [Telemetry docs](https://hexdocs.pm/gen_rmq/3.0.0/GenRMQ.Publisher.Telemetry.html and https://hexdocs.pm/gen_rmq/3.0.0/GenRMQ.Consumer.Telemetry.html)
    - [ ] Plug - [Telemetry docs](https://hexdocs.pm/plug/Plug.Telemetry.html)
    - [ ] Redix - [Telemetry docs](https://hexdocs.pm/redix/Redix.Telemetry.html)
    - [ ] Tesla - [Telemetry docs](https://hexdocs.pm/tesla/Tesla.Middleware.Telemetry.html)
    - [ ] Memcachex - [Telemetry docs](https://hexdocs.pm/memcachex/0.5.0/Memcache.html#module-telemetry)
    - [ ] Nebulex - [Telemetry docs](https://hexdocs.pm/nebulex/2.0.0-rc.0/telemetry.html)
    - [ ] Horde - [Telemetry docs](https://github.com/derekkraan/horde/blob/master/lib/horde/supervisor_telemetry_poller.ex)
    - [ ] Cachex - (Need to open up PR)
    - [ ] Quantum - [Telemetry docs](https://hexdocs.pm/quantum/3.3.0/telemetry.html#content)
    - [ ] ETS - [Erlang docs](https://www.erlang.org/doc/man/ets.html#info-1)

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

  alias TelemetryMetricsPrometheus.Core

  @type telemetry_metrics() :: Counter.t() | Distribution.t() | LastValue.t() | Sum.t() | Summary.t()
  @type measurements_mfa() :: {module(), atom(), list()}

  @type plugin_definition() :: module() | {module(), keyword()}
  @type dashboard_definition() :: {atom(), String.t()} | {atom(), String.t(), keyword(String.t())}

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
  @callback plugins :: [plugin_definition()]
  @callback dashboard_assigns :: keyword()
  @callback dashboards :: [dashboard_definition()]

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
    ets_cron_flusher_name = Module.concat([calling_module, ETSCronFlusher])
    manual_metrics_name = Module.concat([calling_module, ManualMetricsManager])
    metrics_collector_name = Module.concat([calling_module, Metrics])
    dashboard_uploader_name = Module.concat([calling_module, DashboardUploader])
    grafana_client_name = Module.concat([calling_module, GrafanaClient])
    grafana_agent_name = Module.concat([calling_module, GrafanaAgent])
    metrics_server_name = Module.concat([calling_module, MetricsServer])
    lifecycle_annotator_name = Module.concat([calling_module, LifecycleAnnotator])

    quote do
      @behaviour PromEx

      use Supervisor

      @doc false
      def start_link(_) do
        Supervisor.start_link(__MODULE__, [], name: __MODULE__)
      end

      @impl Supervisor
      def init(_) do
        # Get module init options from module callback
        %PromEx.Config{
          disabled: disabled,
          manual_metrics_start_delay: manual_metrics_start_delay,
          drop_metrics_groups: drop_metrics_groups,
          ets_flush_interval: ets_flush_interval,
          grafana_config: grafana_config,
          grafana_agent_config: grafana_agent_config,
          metrics_server_config: metrics_server_config
        } = __MODULE__.init_opts()

        # If the PromEx supervision tree is disabled, then skip it
        if disabled do
          :ignore
        else
          # Default plugin and dashboard opts
          default_plugin_opts = [otp_app: unquote(otp_app)]
          default_dashboard_opts = [otp_app: unquote(otp_app)]

          # Configure each of the desired plugins
          plugins =
            __MODULE__.plugins()
            |> PromEx.init_plugins(default_plugin_opts, drop_metrics_groups)

          # Extract the various metrics types from all of the plugins
          telemetry_metrics = Map.get(plugins, :telemetry_metrics, [])
          poll_metrics = Map.get(plugins, :poll_metrics, [])
          manual_metrics = Map.get(plugins, :manual_metrics, [])

          # Start the relevant child processes depending on configuration
          children =
            []
            |> PromEx.ets_cron_flusher_child_spec(__MODULE__, ets_flush_interval, unquote(ets_cron_flusher_name))
            |> PromEx.metrics_collector_child_spec(telemetry_metrics, unquote(metrics_collector_name))
            |> PromEx.manual_metrics_child_spec(
              manual_metrics,
              manual_metrics_start_delay,
              unquote(manual_metrics_name)
            )
            |> PromEx.poller_child_specs(poll_metrics, __MODULE__)
            |> PromEx.grafana_client_child_spec(
              grafana_config,
              __MODULE__,
              unquote(grafana_client_name)
            )
            |> PromEx.grafana_agent_child_spec(
              grafana_agent_config,
              __MODULE__,
              unquote(grafana_agent_name)
            )
            |> PromEx.dashboard_uploader_child_spec(
              grafana_config,
              __MODULE__,
              default_dashboard_opts,
              unquote(dashboard_uploader_name)
            )
            |> PromEx.metrics_server_child_spec(
              metrics_server_config,
              __MODULE__,
              unquote(metrics_server_name)
            )
            |> PromEx.lifecycle_annotator_child_spec(
              grafana_config,
              __MODULE__,
              unquote(otp_app),
              unquote(lifecycle_annotator_name)
            )
            |> Enum.reverse()

          # Start the PromEx supervision tree
          Supervisor.init(children, strategy: :one_for_one)
        end
      end

      @doc false
      @impl PromEx
      def init_opts do
        unquote(otp_app)
        |> Application.get_env(__MODULE__, [])
        |> PromEx.Config.build()
      end

      @doc false
      @impl PromEx
      def plugins, do: []

      @doc false
      @impl PromEx
      def dashboard_assigns, do: []

      @doc false
      @impl PromEx
      def dashboards, do: []

      @doc false
      def __otp_app__ do
        unquote(otp_app)
      end

      @doc false
      def __grafana_folder_uid__ do
        __MODULE__.init_opts()
        |> Map.get(:grafana_config)
        |> case do
          :disabled ->
            :default

          grafana_config ->
            Map.get(grafana_config, :folder_name, :default)
        end
        |> case do
          :default ->
            :default

          folder_name ->
            # Grafana limits us to 40 character UIDs...so taking the MD5 of
            # a complete unique identifier to use as the UID
            :md5
            |> :crypto.hash(folder_name)
            |> Base.encode16()
        end
      end

      @doc false
      def __grafana_dashboard_uid__(dashboard_otp_app, dashboard_path, dashboard_title) do
        otp_app_name =
          unquote(otp_app)
          |> Atom.to_string()

        module_name = Atom.to_string(__MODULE__)
        dashboard_otp_app_name = Atom.to_string(dashboard_otp_app)

        string_uid = "#{otp_app_name}:#{module_name}:#{dashboard_otp_app_name}:#{dashboard_path}:#{dashboard_title}"

        # Grafana limits us to 40 character UIDs...so taking the MD5 of
        # a complete unique identifier to use as the UID
        :md5
        |> :crypto.hash(string_uid)
        |> Base.encode16()
      end

      @doc false
      def __manual_metrics_name__, do: unquote(manual_metrics_name)

      @doc false
      def __metrics_collector_name__, do: unquote(metrics_collector_name)

      @doc false
      def __grafana_client_name__, do: unquote(grafana_client_name)

      @doc false
      def __grafana_agent_name__, do: unquote(grafana_agent_name)

      @doc false
      def __dashboard_uploader_name__, do: unquote(dashboard_uploader_name)

      @doc false
      def __metrics_server_name__, do: unquote(metrics_server_name)

      @doc false
      def __lifecycle_annotator_name__, do: unquote(lifecycle_annotator_name)

      @doc false
      def __ets_cron_flusher_name__, do: unquote(ets_cron_flusher_name)

      defoverridable PromEx
    end
  end

  @doc false
  def init_plugins(plugins, default_plugin_opts, drop_metrics_groups) do
    # Adding default PromEx plugin
    plugins = [PromEx.Plugins.PromEx | plugins]

    # Extract relevant metrics based on type
    event_metrics = extract_relevant_metrics(plugins, default_plugin_opts, :event_metrics, drop_metrics_groups)
    polling_metrics = extract_relevant_metrics(plugins, default_plugin_opts, :polling_metrics, drop_metrics_groups)
    manual_metrics = extract_relevant_metrics(plugins, default_plugin_opts, :manual_metrics, drop_metrics_groups)

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
  def ets_cron_flusher_child_spec(acc, prom_ex_module, ets_flush_interval, process_name) do
    spec =
      {PromEx.ETSCronFlusher,
       name: process_name, prom_ex_module: prom_ex_module, ets_flush_interval: ets_flush_interval}

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
  def grafana_client_child_spec(acc, :disabled, _, _) do
    acc
  end

  def grafana_client_child_spec(acc, _, _, process_name) do
    spec = {PromEx.GrafanaClient, name: process_name}

    [spec | acc]
  end

  @doc false
  def grafana_agent_child_spec(acc, :disabled, _, _) do
    acc
  end

  def grafana_agent_child_spec(acc, grafana_agent_config, prom_ex_module, process_name) do
    spec = {
      PromEx.GrafanaAgent,
      name: process_name, prom_ex_module: prom_ex_module, grafana_agent_config: grafana_agent_config
    }

    [spec | acc]
  end

  @doc false
  def dashboard_uploader_child_spec(
        acc,
        %{upload_dashboards_on_start: true},
        prom_ex_module,
        default_dashboard_opts,
        process_name
      ) do
    spec = {
      PromEx.DashboardUploader,
      name: process_name, prom_ex_module: prom_ex_module, default_dashboard_opts: default_dashboard_opts
    }

    [spec | acc]
  end

  def dashboard_uploader_child_spec(acc, %{upload_dashboards_on_start: false}, _, _, _) do
    acc
  end

  def dashboard_uploader_child_spec(acc, :disabled, _, _, _) do
    acc
  end

  @doc false
  def lifecycle_annotator_child_spec(acc, %{annotate_app_lifecycle: true}, prom_ex_module, otp_app, process_name) do
    spec = {
      PromEx.LifecycleAnnotator,
      name: process_name, prom_ex_module: prom_ex_module, otp_app: otp_app
    }

    [spec | acc]
  end

  def lifecycle_annotator_child_spec(acc, :disabled, _, _, _) do
    acc
  end

  def lifecycle_annotator_child_spec(acc, %{annotate_app_lifecycle: false}, _, _, _) do
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

    plug_opts = %{
      path: config.path,
      prom_ex_module: prom_ex_module,
      auth_strategy: Map.get(config, :auth_strategy),
      auth_token: Map.get(config, :auth_token),
      auth_user: Map.get(config, :auth_user),
      auth_password: Map.get(config, :auth_password)
    }

    plug_definition = {PromEx.MetricsServer.Plug, plug_opts}

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

  @doc false
  def metric_prefix(otp_app, plug_in) do
    [otp_app, :prom_ex, plug_in]
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
      unique_poll_value =
        poll_rate
        |> Integer.to_string()
        |> String.to_atom()

      {
        :telemetry_poller,
        name: Module.concat([prom_ex_module, Poller, unique_poll_value]), measurements: measurements, period: poll_rate
      }
    end)
  end

  defp generate_mfa_call_list(manual_metrics) do
    manual_metrics
    |> Enum.map(fn %Manual{measurements_mfa: mfa} ->
      mfa
    end)
  end

  defp extract_relevant_metrics(plugins, default_plugin_opts, type, drop_metrics_groups) do
    plugins
    |> Enum.map(fn plugin_definition ->
      init_plugin(plugin_definition, default_plugin_opts, type)
    end)
    |> List.flatten()
    |> Enum.reject(fn %_{group_name: group_name} ->
      MapSet.member?(drop_metrics_groups, group_name)
    end)
  end

  defp init_plugin({module, opts}, default_plugin_opts, function) when is_atom(module) do
    opts = Keyword.merge(default_plugin_opts, opts)

    # credo:disable-for-lines:3 Credo.Check.Refactor.Apply
    module
    |> apply(function, [opts])
    |> normalize_plugin()
  end

  defp init_plugin(module, default_plugin_opts, function) when is_atom(module) do
    # credo:disable-for-lines:3 Credo.Check.Refactor.Apply
    module
    |> apply(function, [default_plugin_opts])
    |> normalize_plugin()
  end

  defp normalize_plugin(metric_definitions) when is_list(metric_definitions) do
    metric_definitions
  end

  defp normalize_plugin(metric_definition) do
    [metric_definition]
  end
end
