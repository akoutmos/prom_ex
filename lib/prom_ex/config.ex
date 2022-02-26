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
    disabled: false,
    manual_metrics_start_delay: :no_delay,
    drop_metrics_groups: [],
    grafana: :disabled,
    metrics_server: :disabled
  ```

  In this configuration, the Grafana dashboards are not uploaded on application start, and a standalone HTTP metrics server is not
  started. In addition, the `PromEx.ManualMetricsManager` is started without any time delay, and all metrics groups from all the plugins
  are registered and set up.

  If you would like to set up PromEx to communicate with Grafana, your config would look something like:

  ```elixir
  config :web_app, WebApp.PromEx,
    grafana: [
      host: "http://localhost:3000",
      username: "<YOUR_USERNAME>",  # Or authenticate via Basic Auth
      password: "<YOUR_PASSWORD>"
      auth_token: "<YOUR_AUTH_TOKEN_HERE>", # Or authenticate via API Token
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

  * `:disabled` - This option will diable the PromEx supervision tree entirely and will not
    start any metris collectors. This is primarily used for disabling PromEx during testing. Default
    value: false

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
    `[:phoenix_channel_event_metrics]` as the value to `:drop_metrics_groups` and that set of
    metrics will not be captured. Default value: `[]`

  * `ets_flush_interval` - This value denotes how often the metrics ETS table is compacted. In order
    to keep things performant and as low-overhead as possible, Telemetry metrics are buffered up in
    ETS until a request is made to retrieve metrics from the PromEx process. If no requests come in
    to extract the metrics, the ETS table can grow infinitely. Luckily, PromEx bundles a GenServer
    that periodically compacts ETS. This config value determines how often ETS should be compacted.
    Default value: `7_500`

  * `:grafana` - This key contains the configuration information for connecting to Grafana. Its
    configuration options are:

    * `:host` - The host address of your Grafana instance. In order for PromEx to communicate with
      Grafana this value should be in the format `protocol://host:port` like `http://localhost:3000`
      for example.

    * `:username` - The username that was created in Grafana so that PromEx can upload dashboards
      via the API.

    * `:password` - The password that was created in Grafana so that PromEx can upload dashboards
      via the API.

    * `:auth_token` - The auth token that was created in Grafana so that PromEx can upload dashboards
      via the API.

    * `:upload_dashboards_on_start` - Using the config values that you set in your application config
      (`config.exs`, `dev.exs`, `prod.exs`, etc) PromEx will attempt to upload your Dashboards to
      Grafana using Grafana's HTTP API.

    * `:folder_name` - The name of the folder that PromEx will put all of the project dashboards in.
      PromEx will automatically generate a unique ID for the folder based on the project's otp_app
      value so that it can access the correct folder in Grafana. This also makes sure that different
      Elixir projects running in the same cluster and publishing dashboards to Grafana do not collide
      with one another. If no name is provided, then the dashboards will all be uploaded to the default
      Grafana folder.

    * `:annotate_app_lifecycle` - By enabling this setting, PromEx will leverage the Grafana API to annotate
      when the application was started, and when it was shut down. By default this is disabled but if you
      do enable it, no action is required from you in order to display these events on the dashboards. The
      annotations will automatically contain the necessary tags to only display on the PromEx dashboards.
      The annotation will include information including:
        - Hostname
        - OTP app name
        - App version
        - Git SHA of the last commit (if the GIT_SHA environment variable is present)
        - Git author of the last commit (if the GIT_AUTHOR environment variable is present)

  * `:grafana_agent` - This key contains the configuration information for running GrafanaAgent via a
    port in order to push metrics to a Prometheus instance via `remote_write` functionality:

    > ### Environment dependencies {: .warning}
    >
    > If your application is running inside of an Alpine Linux container (or any environment that
    > is based on [musl](https://www.musl-libc.org/) as opposed to
    > [glibc](https://www.gnu.org/software/libc/), be sure to add `libc6-compat` to to your list
    > of packages. In addition, you'll also need bash running, as this port is wrapped by a
    > [bash script](https://hexdocs.pm/elixir/1.12/Port.html#module-zombie-operating-system-processes).
    > For example, in a Dockerfile you would add:
    > `RUN apk add --no-cache bash libc6-compat`

    * `:version` - The version of GrafanaAgent that you want to run. This is a string denoting the
      GrafanaAgent release version. Below are the supported versions (the downloaded artifacts
      are validated against their known SHA256 values so that you can be sure you are not downloading
      any malicious binaries and running them). By default, PromEx will use the result of
      `PromEx.GrafanaAgent.Downloader.latest_version()` if no value is provided.

      * Supported versions are `["0.23.0", "0.22.0", "0.21.2", "0.20.1"]`

    * `:working_directory` - In order to leverage the GrafanaAgent functionality, PromEx needs to have
      read/write access to a directory in order to download and copy the GrafanaAgent binary. This is the
      full path to that directory.

    * `:config_opts` - The configuration file that GrafanaAgent is started with. This option
      can either accept an MFA that will return a string of the full path where the YAML configuration
      file is, or a keyword list with options so that PromEx can generate a config file for you. If you
      take the route where PromEx generates a config file for you, you must provide the following
      otions:

      * `:metrics_server_path` - The path where the Prometheus metrics are exposed.

      * `:metrics_server_port` - The port that the metrics server is running on.

      * `:metrics_server_scheme` - Whether the app reachable via HTTPS or HTTP.

      * `:metrics_server_host` - The host to scrape for metrics.

      * `:instance` - This value denotes what instance the metrics are associated with. This value
        is a string and defaults to the hostname.

      * `:job` - This value denotes what job the metrics are associated with. This value
        is a string and defaults to the otp_app.

      * `:agent_port` - What port should GrafanaAgent run on.

      * `:scrape_interval` - How often should GrafanaAgent scrape the application. The default is `15s`.

      * `:bearer_token` - The bearer token that GrafanaAgent should attach to the request to your app.

      * `:log_level` - The logging level for GrafanaAgent.

      * `:prometheus_url` - The url to your Prometheus instance.

      * `:prometheus_username` - The username to the hosted Prometheus instance

      * `:prometheus_password` - The password to the hosted Prometheus instance

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
  - `disabled`: Whether PromEx will start up the metric collection supervision tree.
  - `manual_metrics_start_delay`: How the ManualMetricsManager worker process should be started (instantly or with a millisecond delay).
  - `drop_metrics_groups`: A list of metrics groups that should be omitted from the metrics collection process.
  - `ets_flush_interval`: How often should the ETS buffer table be compacted.
  - `grafana_config`: A map containing all the relevant settings to connect to Grafana.
  - `grafana_agent_config`: A map containing all the relevant settings to connect to GrafanaAgent.
  - `metrics_server_config`: A map containing all the relevant settings to start a standalone HTTP Cowboy server for metrics.
  """

  alias PromEx.GrafanaAgent.Downloader

  @type t :: %__MODULE__{
          disabled: boolean(),
          manual_metrics_start_delay: :no_delay | pos_integer(),
          drop_metrics_groups: MapSet.t(),
          ets_flush_interval: :integer,
          grafana_config: map(),
          grafana_agent_config: map(),
          metrics_server_config: map()
        }

  defstruct [
    :disabled,
    :manual_metrics_start_delay,
    :drop_metrics_groups,
    :ets_flush_interval,
    :grafana_config,
    :grafana_agent_config,
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

    grafana_agent_config =
      opts
      |> Keyword.get(:grafana_agent, :disabled)
      |> generate_grafana_agent_config()

    metrics_server_config =
      opts
      |> Keyword.get(:metrics_server, :disabled)
      |> generate_metrics_server_config()

    %__MODULE__{
      disabled: Keyword.get(opts, :disabled, false),
      manual_metrics_start_delay: Keyword.get(opts, :manual_metrics_start_delay, :no_delay),
      drop_metrics_groups: opts |> Keyword.get(:drop_metrics_groups, []) |> MapSet.new(),
      ets_flush_interval: Keyword.get(opts, :ets_flush_interval, 7_500),
      grafana_config: grafana_config,
      grafana_agent_config: grafana_agent_config,
      metrics_server_config: metrics_server_config
    }
  end

  defp generate_grafana_config(:disabled), do: :disabled

  defp generate_grafana_config(grafana_opts) do
    %{
      host: grafana_opts |> get_grafana_config(:host) |> normalize_host(),
      username: Keyword.get(grafana_opts, :username),
      password: Keyword.get(grafana_opts, :password),
      auth_token: Keyword.get(grafana_opts, :auth_token),
      upload_dashboards_on_start: Keyword.get(grafana_opts, :upload_dashboards_on_start, true),
      folder_name: Keyword.get(grafana_opts, :folder_name, :default),
      annotate_app_lifecycle: Keyword.get(grafana_opts, :annotate_app_lifecycle, false)
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

  defp generate_grafana_agent_config(:disabled), do: :disabled

  defp generate_grafana_agent_config(grafana_agent_opts) do
    %{
      version: Keyword.get(grafana_agent_opts, :version, Downloader.latest_version()),
      working_directory: Keyword.get(grafana_agent_opts, :working_directory),
      config_opts: grafana_agent_opts |> get_grafana_agent_config(:config_opts) |> extract_opts_for_config()
    }
  end

  defp extract_opts_for_config(opts) do
    %{
      scrape_interval: Keyword.get(opts, :scrape_interval, "15s"),
      bearer_token: Keyword.get(opts, :bearer_token, "blank"),
      log_level: Keyword.get(opts, :log_level, "error"),
      agent_port: Keyword.get(opts, :agent_port, "4040"),
      job: Keyword.get(opts, :job, nil),
      instance: Keyword.get(opts, :instance, nil),
      prometheus_url: get_grafana_agent_config(opts, :prometheus_url),
      prometheus_username: get_grafana_agent_config(opts, :prometheus_username),
      prometheus_password: get_grafana_agent_config(opts, :prometheus_password),
      metrics_server_path: Keyword.get(opts, :metrics_server_path, "/metrics"),
      metrics_server_port: Keyword.get(opts, :metrics_server_port, 4000),
      metrics_server_host: Keyword.get(opts, :metrics_server_host, "localhost"),
      metrics_server_scheme: Keyword.get(opts, :metrics_server_scheme, :https)
    }
  end

  defp get_grafana_agent_config(grafana_agent_opts, config_key) do
    case Keyword.fetch(grafana_agent_opts, config_key) do
      {:ok, value} ->
        value

      :error ->
        raise "When configuring the GrafanaAgent client for PromEx, the #{inspect(config_key)} key is required."
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
