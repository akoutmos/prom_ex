if Code.ensure_loaded?(Plug.Router) do
  defmodule PromEx.Plugins.PlugRouter do
    @moduledoc """
    This plugin captures HTTP request metrics emitted by Plug.Cowboy.

    This plugin exposes the following metric group:
    - `:plug_router_http_event_metrics`

    ## Plugin options

    - `routers`: **Required** This is a list with the full module names of your Routers (e.g MyAppWeb.Router).
    Metrics produced by routers not in this list will be discarded.
    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
    `[otp_app, :prom_ex, :plug_router]`. If this changes you will also want to set `plug_router_metric_prefix`
    in your `dashboard_assigns` to the snakecase version of your prefix, the default
    `plug_router_metric_prefix` is `{otp_app}_prom_ex_plug_router`.
    - `ignore_routes`: This option is OPTIONAL and is used to ignore certain paths.

    To use plugin in your application, add the following to your PromEx module:

    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.PlugRouter, metric_prefix: [:prom_ex, :router], routers: [MyApp.Router]},
          {Plugins.PromEx, metric_prefix: [:prom_ex, :prom_ex]}
        ]
      end

      @impl true
      def dashboard_assigns do
        [
          datasource_id: "...",
          plug_router_metric_prefix: "prom_ex_router",
          prom_ex_metric_prefix: "prom_ex_prom_ex"
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
            metric_prefix: [:prom_ex, :router], routers: [MyApp.Router], ignore_routes: ["/metrics"]}
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

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :plug_router))
      set_up_telemetry_proxy()

      [
        http_events(metric_prefix, opts)
      ]
    end

    defp set_up_telemetry_proxy do
      :telemetry.attach(
        {__MODULE__, :stop},
        [:plug, :router_dispatch, :stop],
        &__MODULE__.handle_proxy_router_event/4,
        %{}
      )

      :telemetry.attach(
        {__MODULE__, :exception},
        [:plug, :router_dispatch, :exception],
        &__MODULE__.handle_proxy_router_event/4,
        %{}
      )
    end

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
              buckets: exponential!(1, 2, 12)
            ],
            drop: drop_ignored(ignore_routes, routers),
            tag_values: &get_tags(&1),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
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

    defp path(conn) do
      {path, _} = conn.private.plug_route
      path
    end

    defp get_tags(%{conn: conn = %Conn{}}) do
      %{
        status: conn.status || 500,
        method: conn.method,
        path: path(conn)
      }
    end

    defp drop_ignored(ignored_routes, routers) do
      fn
        %{conn: conn = %Conn{}, router: router} ->
          path = path(conn)

          !Enum.member?(routers, router) || MapSet.member?(ignored_routes, path)

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
