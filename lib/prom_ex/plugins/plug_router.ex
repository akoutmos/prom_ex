if Code.ensure_loaded?(Plug.Router) do
  defmodule PromEx.Plugins.PlugRouter do
    @moduledoc """
    This plugin captures HTTP request metrics emitted by `Plug.Router` and `Plug.Telemetry`.

    This plugin is heavily inspired on plugin `Plug.Cowboy`, and exposes the following metric group:
     - `:plug_router_http_event_metrics`

    ## Plugin options

    - `routers`: **Required** This is a list with the full module names of your Routers (e.g MyAppWeb.Router).
     Metrics produced by routers not in this list will be discarded.

    - `event_prefix`: **Required**, allows you to set the event prefix defined in your `Plug.Telemetry` configuration:

    ```
    defmodule WebApp.Router do
      use Plug.Router

      plug PromEx.Plug, prom_ex_module: WebApp.PromEx, path: "/metrics"
      plug Plug.Telemetry, event_prefix: [:webapp, :router]
      ...
    end
    ```

    With the above configuration, this plugin will subscribe to `[:webapp, :router, :stop]` telemetry events
    produced by `Plug.Telemetry`. These events will be fired **before** the response is actually sent, therefore this
    plugin will be able to export response body size metrics, since the `Plug.Conn` struct in the metadata of the
    telemetry measurement still contains the response body.

    However, `Plug.Telemetry` does not use `:telemetry.span/3`, which means the `:stop` event might not always be fired
    (eg. if the process handling the request crashes). For this reason, this PromEx plugin also subscribes to
    `[:plug, :router_dispatch, :exception]` telemetry events fired by `Plug.Router`, which are fired within a
    `:telemetry.span/3` call.

    Unfortunately, we cannot safely rely on `[:plug, :router_dispatch, :stop]` events produced by `Plug.Router` since
    these are fired **after** the response is sent (as opposed to `Plug.Telemetry` `:stop` events). As a consequence,
    the response body is no longer available in the `Plug.Conn` struct attached to the telemetry measurement metadata.

    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
     `[otp_app, :prom_ex, :plug_router]`. If this changes you will also want to set `plug_router_metric_prefix`
     in your `dashboard_assigns` to the snakecase version of your prefix, the default
     `plug_router_metric_prefix` is `{otp_app}_prom_ex_plug_router`.
    - `ignore_routes`: This option is OPTIONAL and is used to ignore certain paths.

    To use plugin in your application, add the following to your PromEx module:

    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      alias PromEx.Plugins

      @impl true
      def plugins do
        [
          ...
          {Plugins.PlugRouter,
            event_prefix: [:webapp, :router], metric_prefix: [:prom_ex, :router], routers: [WebApp.Router]}
        ]
      end

      @impl true
      def dashboard_assigns do
        [
          datasource_id: "...",
          plug_router_metric_prefix: "prom_ex_router"
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "plug_router.json"}
        ]
      end
    end
    ```

    To ignore certain paths, pass a list of routes using the `:ignore_routes` option

    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.PlugRouter,
            event_prefix: [:webapp, :router], metric_prefix: [:prom_ex, :router], routers: [WebApp.Router],
            ignore_routes: ["/metrics"]}
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "plug_router.json"}
        ]
      end
    end
    ```
    """

    use PromEx.Plugin
    require Logger
    alias Plug.Conn

    @stop_event [:prom_ex, :router, :stop]
    @default_event_prefix [:plug, :router_dispatch]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)

      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :plug_router))

      event_prefix = Keyword.fetch!(opts, :event_prefix)
      set_up_telemetry_proxy(event_prefix)

      [
        http_events(metric_prefix, opts)
      ]
    end

    defp set_up_telemetry_proxy(event_prefix) do
      :telemetry.attach(
        {__MODULE__, :stop},
        event_prefix ++ [:stop],
        &__MODULE__.handle_proxy_router_event/4,
        %{}
      )

      :telemetry.attach(
        {__MODULE__, :exception},
        @default_event_prefix ++ [:exception],
        &__MODULE__.handle_proxy_router_event/4,
        %{}
      )
    end

    @doc false
    def handle_proxy_router_event(_, measurements, meta, _) do
      :telemetry.execute(@stop_event, measurements, meta)
    end

    defp http_events(metric_prefix, opts) do
      http_metrics_tags = [:status, :method, :path]

      routers =
        opts
        |> Keyword.fetch!(:routers)
        |> MapSet.new()

      ignore_routes =
        opts
        |> Keyword.get(:ignore_routes, [])
        |> MapSet.new()

      Event.build(
        :plug_router_http_event_metrics,
        [
          # Capture request duration information
          distribution(
            metric_prefix ++ [:http, :request, :duration, :milliseconds],
            event_name: @stop_event,
            measurement: :duration,
            description: "The time it takes for the application to process HTTP requests.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            drop: drop_ignored(ignore_routes, routers),
            tag_values: &get_tags(&1),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: @stop_event,
            description: "The size of the HTTP response payload.",
            reporter_options: [
              buckets: [64, 512, 4_096, 65_536, 262_144, 1_048_576, 4_194_304, 16_777_216]
            ],
            measurement: &resp_body_size/2,
            drop: drop_ignored(ignore_routes, routers),
            tag_values: &get_tags(&1),
            tags: http_metrics_tags,
            unit: :byte
          ),
          counter(
            metric_prefix ++ [:http, :requests, :total],
            event_name: @stop_event,
            description: "The number of requests that have been serviced.",
            drop: drop_ignored(ignore_routes, routers),
            tag_values: &get_tags(&1),
            tags: http_metrics_tags
          )
        ]
      )
    end

    defp resp_body_size(_, metadata) do
      case metadata.conn.resp_body do
        nil -> 0
        _ -> :erlang.iolist_size(metadata.conn.resp_body)
      end
    end

    defp route(%Plug.Conn{private: %{plug_route: {route, _}}}) do
      route
    end

    defp route(_conn) do
      "Unknown"
    end

    defp route_or_path(conn) do
      case Map.get(conn.private, :plug_route) do
        {route, _} ->
          route

        nil ->
          conn.request_path
      end
    end

    defp get_tags(%{conn: conn = %Conn{}}) do
      %{
        status: conn.status || 500,
        method: conn.method,
        path: route(conn)
      }
    end

    defp drop_ignored(ignored_routes, routers) do
      fn
        %{conn: conn = %Conn{}, router: router} ->
          value = route_or_path(conn)

          disallowed_router? = !Enum.member?(routers, router)
          ignored_route? = MapSet.member?(ignored_routes, value)
          disallowed_router? || ignored_route?

        %{conn: conn = %Conn{}} ->
          value = route_or_path(conn)

          ignored_route? = MapSet.member?(ignored_routes, value)
          ignored_route?

        _meta ->
          false
      end
    end
  end
else
  defmodule PromEx.Plugins.PlugRouter do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Plug.Router")
    end
  end
end
