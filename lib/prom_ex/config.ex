defmodule PromEx.Config do
  @moduledoc """
  This module defines a struct that contains all of the fields necessary to configure
  an instance of PromEx.

  While this module does not directly access your Application config, PromEx will call the
  `PromEx.Config.build/1` function directly with the contents of `Application.get_env(:your_otp_app, YourPromEx.Module)`. As
  such, this is an appropriate place to talk about how you go about configuring PromEx via your Application config.

  By default, you can run PromEx without any additional configuration and PromEx will fall back on some sane defaults. Specifically,
  if you were to not add any configuration to your config.exs, dev.exs, prod.exs, etc files it would be the same as setting the
  following config:

  ```elixir
  config :web_app, WebApp.PromEx,
    manual_metrics_start_delay: :no_delay,
    drop_metrics_groups: [],
    grafana: :disabled,
    metrics_server: :disabled
  ```

  In this configuration, the Grafana dashboards are not uploaded on application start, and a standalone HTTP metrics server is not
  started. In addition, the ManualMetricsManager is started without any time delay, and all metrics groups from all the plugins
  are regestered and set up.

  If you would like to set up PromEx to communicate with Grafana, your config would look something like:

  ```elixir
  config :web_app, WebApp.PromEx,
    grafana: [
      host: "http://localhost:3000",
      auth_token: "<YOUR_AUTH_TOKEN_HERE>",
      datasource_id: "<YOUR_DATASOURCE_ID_HERE>",
      upload_dashboards_on_start: true # This is an optional setting and will default to `true`
    ]
    ```

  If you would like PromEx to start a standalone HTTP server to serve your aggregated metrics, you can leverage the `:metrics_server`
  config:

  ```elixir
  config :web_app, WebApp.PromEx,
    metrics_server: [
      port: 4021,
      path: "/metrics", # This is an optional setting and will default to `"/metrics"`
      protocol: :http, # This is an optional setting and will default to `:http`
      pool_size: 5, # This is an optional setting and will default to `5`
      cowboy_opts: [], # This is an optional setting and will default to `[]`
      auth_strategy: :none # This is an optional and will default to `:none`
    ]
  ```

  If you would like the metrics server to be protected behind some sort of authentication, you can configure your `:metrics_server`
  like so:

  ```elixir
  config :web_app, WebApp.PromEx,
    metrics_server: [
      port: 4021,
      auth_strategy: :bearer,
      auth_token: "VGhpcyBpcyBzdXBlciBzZWNyZXQuLi5kb24ndCBkZWNvZGUgbWU="
    ]
  ```

  ## Option Details

  * `:manual_metrics_start_delay` - Manual metrics are gathered once on start up and then only when
    you call `PromEx.ManualMetricsManager.refresh_metrics/1`. Sometimes, you may have metrics
    that require your entire supervision tree to be started in order to fetch accurate data.
    This option will allow you to delays the initial metrics capture of the
    `ManualMetricsManager` by a certain number of milliseconds or the `:no_delay` atom if you
    want the metrics to be captured as soon as the `ManualMetricsManager` starts up. Default
    value: `:no_delay`

  * `:drop_metrics_groups` - A list of all the metrics groups that you are not interested in
    tracking. For example, if your application does not leverage Phoenix channels at all but
    you still would like to use the `PromEx.Plugins.Phoenix` plugin, you can pass
    [`:phoenix_channel_event_metrics`] as the value to `:drop_metrics_groups` and that set of
    metrics will not be caputred. Default value: `[]`

  * `:grafana` - This key contains the configuration information for connecting to Grafana. Its
    configuration options are:

    * `:host` - The host address of your Grafana instance. In order for PromEx to communicate with
      Grafana this valueshould be in the format `protocol://host:port` like `http://localhost:3000`
      for example.

    * `:auth_token` - The auth token that was created in Grafana so that PromEx can upload dashboards
      via the API.

    * `:datasource_id` - When configuring a datasource in Grafana, you allocate an ID to each datasource.
      This datasource is required by the queries that populate the graphs so that Grafana knows what backing
      time-series data store to communicate with. Given that PromEx works with Prometheus, you'll need
      to tell PromEx what the ID of the Prometheus datasource is in Grafana. This value is required so that
      the PromQL queries can be directed to the correct Prometheus instance.

    * `:upload_dashboards_on_start` - Using the config values that you set in your application config
      (`config.exs`, `dev.exs`, `prod.exs`, etc) PromEx will attempt to upload your Dashboards to
      Grafana using Grafana's HTTP API.

  * `:metrics_server` - This key contains the configuration information needed to run a standalone
    HTTP server powered by Cowboy. This server provides a lightweight solution to serving up PromEx
    metrics. Its configuration options are:

    * `:port` - The port that the Cowboy HTTP server should run on.

    * `:path` - The path that the metrics should be accessible at.

    * `:protocol` - The protocol that the metrics should be accessible over (`:http` or `:https`).

    * `:pool_size` - How many Cowboy processes should be in the pool to handle metrics related requests.

    * `:auth_strategy` - What authentication strategy should be used to authorize requests to your metrics. The
      Supported strategies are `:none`, `:bearer`, and `:basic`. Depending on what strategy is selected, you
      will need to also add additional config values. For `:none` (which is the default), no additional
      information needs to be provided. When using a `:bearer` strategy, you'll need to provide a `:auth_token`
      config value. When using `:basic` strategy you'll need to provide `:auth_user` and `:auth_password` values.

    * `:auth_token` - When using a `:bearer` authentication strategy, this field is required to validate the
      incoming request against a valid auth token.

    * `:auth_user` - When using a `:basic` authentication strategy, this field is required to validate the
      incoming request against a valid user.

    * `:auth_password` - When using a `:bearer` authentication strategy, this field is required to validate the
      incoming request against a valid password.

    * `:cowboy_opts` - A keyword list of any additional options that should be passed to `Plug.Cowboy` (see
      docs for more information https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html). The `:port` and
      `:transport_options` options are handled by PromEx via the aforementioned config settings and so
      adding them again here has no effect.
  """

  @typedoc """
  - `manual_metrics_start_delay`: How the ManualMetricsManager worker process should be started (instantly or with a millisecond delay).
  - `drop_metrics_groups`: A list of metrics groups that should be omitted from the metrics collection process.
  - `grafana_config`: A map containing all the relevant settings to connect to Grafana.
  - `metrics_server_config`: A map containing all the relevant settings to start a standalone HTTP Cowboy server for metrics.
  """

  @type t :: %__MODULE__{
          manual_metrics_start_delay: :no_delay | pos_integer(),
          drop_metrics_groups: MapSet.t(),
          grafana_config: map(),
          metrics_server_config: map()
        }

  defstruct [
    :manual_metrics_start_delay,
    :drop_metrics_groups,
    :grafana_config,
    :metrics_server_config
  ]

  @doc """
  Create a struct that encapsulates all of the configuration needed to start a PromEx supervisor instance as well as all
  of the worker processes.
  """
  @spec build(keyword()) :: __MODULE__.t()
  def build(opts) do
    grafana_config =
      opts
      |> Keyword.get(:grafana, :disabled)
      |> generate_grafana_config()

    metrics_server_config =
      opts
      |> Keyword.get(:metrics_server, :disabled)
      |> generate_metrics_server_config()

    %__MODULE__{
      manual_metrics_start_delay: Keyword.get(opts, :manual_metrics_start_delay, :no_delay),
      drop_metrics_groups: opts |> Keyword.get(:drop_metrics_groups, []) |> MapSet.new(),
      grafana_config: grafana_config,
      metrics_server_config: metrics_server_config
    }
  end

  defp generate_grafana_config(:disabled), do: :disabled

  defp generate_grafana_config(grafana_opts) do
    %{
      host: grafana_opts |> get_grafana_config(:host) |> normalize_host(),
      auth_token: get_grafana_config(grafana_opts, :auth_token),
      datasource_id: get_grafana_config(grafana_opts, :datasource_id),
      upload_dashboards_on_start: Keyword.get(grafana_opts, :upload_dashboards_on_start, true)
    }
  end

  defp get_grafana_config(grafana_opts, config_key) do
    case Keyword.fetch(grafana_opts, config_key) do
      {:ok, value} ->
        value

      :error ->
        raise "When configuring the Grafana client for PromEx, the #{inspect(config_key)} key is required."
    end
  end

  defp normalize_host(host_string) do
    host_string
    |> URI.parse()
    |> Map.put(:path, nil)
    |> Map.put(:query, nil)
    |> URI.to_string()
  end

  defp generate_metrics_server_config(:disabled), do: :disabled

  defp generate_metrics_server_config(metrics_server_opts) do
    base_config = %{
      port: get_metrics_server_config(metrics_server_opts, :port),
      path: Keyword.get(metrics_server_opts, :path, "/metrics"),
      protocol: Keyword.get(metrics_server_opts, :protocol, :http),
      pool_size: Keyword.get(metrics_server_opts, :pool_size, 5),
      cowboy_opts: Keyword.get(metrics_server_opts, :cowboy_opts, []),
      auth_strategy: Keyword.get(metrics_server_opts, :auth_strategy, :none)
    }

    add_auth_config(base_config, metrics_server_opts)
  end

  defp add_auth_config(%{auth_strategy: :none} = base_config, _add_auth_config) do
    base_config
  end

  defp add_auth_config(%{auth_strategy: :bearer} = base_config, add_auth_config) do
    Map.put(base_config, :auth_token, get_metrics_server_config(add_auth_config, :auth_token))
  end

  defp add_auth_config(%{auth_strategy: :basic} = base_config, add_auth_config) do
    base_config
    |> Map.put(:auth_user, get_metrics_server_config(add_auth_config, :auth_user))
    |> Map.put(:auth_password, get_metrics_server_config(add_auth_config, :auth_password))
  end

  defp add_auth_config(_base_config, _add_auth_config) do
    raise "Unknown auth strategy provided to PromEx metrics server. Supported strategies include :none, :bearer, or :basic."
  end

  defp get_metrics_server_config(metrics_server_opts, config_key) do
    case Keyword.fetch(metrics_server_opts, config_key) do
      {:ok, value} ->
        value

      :error ->
        raise "When configuring the PromEx metrics server, the #{inspect(config_key)} key is required."
    end
  end
end
