if Code.ensure_loaded?(Plug.Cowboy) do
  defmodule PromEx.Plugins.PlugCowboy do
    @moduledoc """
    This plugin captures HTTP request metrics emitted by Plug.Cowboy.

    This plugin exposes the following metric group:
    - `:plug_cowboy_http_event_metrics`

    ## Plugin options

    - `routers`: **Required** This is a list with the full module names of your Routers (e.g MyAppWeb.Router).
      Phoenix and Plug routers are supported. When the Phoenix dependency is present in your project, a list of Phoenix Routers is expected. Otherwise a list of Plug.Router modules must be provided
    - `event_prefix`: **Optional**, allows you to set the event prefix for the Telemetry events.
    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
    `[otp_app, :prom_ex, :plug_cowboy]`. If this changes you will also want to set `plug_cowboy_metric_prefix`
    in your `dashboard_assigns` to the snakecase version of your prefix, the default
    `plug_cowboy_metric_prefix` is `{otp_app}_prom_ex_plug_cowboy`.



    To use plugin in your application, add the following to your PromEx module:

    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.PlugCowboy, routers: [MyApp.Router]}
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "plug_cowboy.json"}
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
          {PromEx.Plugins.PlugCowboy, routers: [MyApp.Router], ignore_routes: ["/metrics"]}
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "plug_cowboy.json"}
        ]
      end
    end
    ```


    """

    use PromEx.Plugin

    require Logger

    # alias Plug.Cowboy.Conn

    @default_route "Unknown"

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :plug_cowboy))

      [
        http_events(metric_prefix, opts)
      ]
    end

    defp http_events(metric_prefix, opts) do
      # Shared configuration
      cowboy_stop_event = [:cowboy, :request, :stop]
      http_metrics_tags = [:status, :method, :path]

      ignore_routes =
        opts
        |> Keyword.get(:ignore_routes, [])
        |> MapSet.new()

      routers =
        opts
        |> Keyword.fetch!(:routers)
        |> MapSet.new()

      Event.build(
        :plug_cowboy_http_event_metrics,
        [
          # Capture request duration information
          distribution(
            metric_prefix ++ [:http, :request, :duration, :milliseconds],
            event_name: cowboy_stop_event,
            measurement: :duration,
            description: "The time it takes for the application to process HTTP requests.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            drop: drop_ignored(ignore_routes),
            tag_values: &get_tags(&1, routers),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:http, :response, :duration, :milliseconds],
            event_name: cowboy_stop_event,
            measurement: :resp_duration,
            description: "The time it takes for the application to send the HTTP response.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            drop: drop_ignored(ignore_routes),
            tag_values: &get_tags(&1, routers),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:http, :request_body, :duration, :milliseconds],
            event_name: cowboy_stop_event,
            measurement: :req_body_duration,
            description: "The time it takes for the application to receive the HTTP request body.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            drop: drop_ignored(ignore_routes),
            tag_values: &get_tags(&1, routers),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),

          # Capture response payload size information
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: cowboy_stop_event,
            measurement: :resp_body_length,
            description: "The size of the HTTP response payload.",
            reporter_options: [
              buckets: [64, 512, 4_096, 65_536, 262_144, 1_048_576, 4_194_304, 16_777_216]
            ],
            drop: drop_ignored(ignore_routes),
            tag_values: &get_tags(&1, routers),
            tags: http_metrics_tags,
            unit: :byte
          ),

          # Capture the number of requests that have been serviced
          counter(
            metric_prefix ++ [:http, :requests, :total],
            event_name: cowboy_stop_event,
            description: "The number of requests that have been serviced.",
            drop: drop_ignored(ignore_routes),
            tag_values: &get_tags(&1, routers),
            tags: http_metrics_tags
          )
        ]
      )
    end

    defp get_tags(%{resp_status: resp_status, req: %{method: method} = req}, routers) do
      case get_http_status(resp_status) do
        status when is_binary(status) ->
          %{
            status: status,
            method: method,
            path: maybe_get_parametrized_path(req, routers)
          }

        :undefined ->
          %{
            status: :undefined,
            method: method,
            path: maybe_get_parametrized_path(req, routers)
          }

        nil ->
          Logger.warn("Cowboy failed to provide valid response status #{inspect(resp_status)}")
          %{}
      end
    end

    defp maybe_get_parametrized_path(req, routers) do
      # credo:disable-for-next-line
      cond do
        Code.ensure_loaded?(Phoenix) ->
          find_phoenix_route(routers, req)

        # TODO: This needs to be further investigated to see how the normalized route can be extracted
        # Code.ensure_loaded?(Plug.Router) ->
        #  find_plug_route(routers, req)

        true ->
          @default_route
      end
    end

    defp find_phoenix_route(routers, %{method: method, path: path}) do
      routers
      |> Enum.find_value(@default_route, fn router ->
        case Phoenix.Router.route_info(router, method, path, "") do
          :error ->
            false

          %{route: route} ->
            route
        end
      end)
    end

    # defp find_plug_route(routers, req) do
    #   conn = Conn.conn(req)
    #
    #   routers
    #   |> Enum.find_value(@default_route, fn router ->
    #     case router.call(conn, []) do
    #       %{private: %{plug_route: {route, _fn}}} -> route
    #       _ -> false
    #     end
    #   end)
    # end

    defp get_http_status(resp_status) when is_integer(resp_status) do
      to_string(resp_status)
    end

    defp get_http_status(resp_status) when is_bitstring(resp_status) do
      [code | _rest] = String.split(resp_status)
      code
    end

    defp get_http_status(nil) do
      nil
    end

    defp get_http_status(_resp_status) do
      :undefined
    end

    defp drop_ignored(ignored_routes) do
      fn
        %{req: %{path: path}} ->
          ignored_routes
          |> MapSet.member?(path)

        _meta ->
          false
      end
    end
  end
else
  defmodule PromEx.Plugins.PlugCowboy do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Plug.Cowboy")
    end
  end
end
