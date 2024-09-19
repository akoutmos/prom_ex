if Code.ensure_loaded?(Phoenix) do
  defmodule PromEx.Plugins.Phoenix do
    @moduledoc """
    This plugin captures metrics emitted by Phoenix. Specifically, it captures HTTP request metrics and
    Phoenix channel metrics.

    ## Plugin options

    This plugin supports the following options:
    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :phoenix]`. If this changes you will also want to set `phoenix_metric_prefix`
      in your `dashboard_assigns` to the snakecase version of your prefix, the default
      `phoenix_metric_prefix` is `{otp_app}_prom_ex_phoenix`.

    - `duration_unit`: This is an OPTIONAL option and is a `Telemetry.Metrics.time_unit()`. It can be one of:
      `:second | :millisecond | :microsecond | :nanosecond`. It is `:millisecond` by default.

    ### Single Endpoint/Router
    - `router`: This option is REQUIRED and is the full module name of your Phoenix Router (e.g MyAppWeb.Router).

    - `endpoint`: This is a REQUIRED option and is the full module name of your Phoenix Endpoint (e.g MyAppWeb.Endpoint).

    - `event_prefix`: This option is OPTIONAL and allows you to set the event prefix for the Telemetry events. This
      value should align with what you pass to `Plug.Telemetry` in your `endpoint.ex` file (see the plug docs
      for more information https://hexdocs.pm/plug/Plug.Telemetry.html) This value should align with what you pass
      to `Plug.Telemetry` in your `endpoint.ex` file (see the plug docs for more
      information https://hexdocs.pm/plug/Plug.Telemetry.html)

    - `additional_routes`: This option is OPTIONAL and allows you to specify route path labels for applications routes
      not defined in your Router module.

      For example, if you want to track telemetry events for a plug in your
      `endpoint.ex` file, you can provide a keyword list with the structure `[some-route: ~r(\/some-path)]` and any
      time that the route is called and the plug handles the call, the path label for this particular Prometheus metric
      will be set to `some-route`. You can pass in either a regular expression or a string to match the incoming
      request.

    - `normalize_event_name`: This option is OPTIONAL and allows you to remap the channel event names to a different
      name. This is useful if you want to limit the number or size of event names that are emitted.

      For example, if you have a channel and only want to emit unique metrics for the 'join' and 'leave' events, you can
      map those events to themselves and map all other events to an 'unknown' event.

      ```elixir
        fn
          "join" -> "join"
          "leave" -> "leave"
          _ -> "unknown"
        end
      ```

    #### Example plugin configuration

    ```elixir
    {
      PromEx.Plugins.Phoenix,
      endpoint: MyApp.Endpoint,
      router: MyAppWeb.Public.Router,
      event_prefix: [:admin, :endpoint],
      normalize_event_name: fn event -> event end)
    }
    ```

    ### Multiple Endpoints/Router

    - `endpoints`: This accepts a list of per Phoenix Endpoint options `{endpoint_name, endpoint_opts}`
      - `endpoint_name`: This option is REQUIRED and is the full module name of your Phoenix Endpoint (e.g MyAppWeb.Endpoint).

      - `endpoint_opts`: Per endpoint plugin options:
        - `:routers`: This option is REQUIRED and lists all of routers modules for the endpoint, the HTTP metrics will
          be augmented with controller/action/path information from the routers.

        - `:event_prefix`: This option is OPTIONAL and allows you to set the event prefix for the Telemetry events. This
        value should align with what you pass to `Plug.Telemetry` in the  corresponding endpoint module (see the plug docs
        for more information https://hexdocs.pm/plug/Plug.Telemetry.html)

        - `:additional_routes`: This option is OPTIONAL and allows you to specify route path labels for applications routes
        not defined in your Router modules for the corresponding endpoint.

    #### Example plugin configuration

    ```elixir
    {
      PromEx.Plugins.Phoenix,
      endpoints: [
        {MyApp.Endpoint, routers: [MyAppWeb.Public.Router]},
        {MyApp.Endpoint2, routers: [MyAppWeb.Admin.Router], event_prefix: [:admin, :endpoint]}
      ]
    }
    ```

    ## Metric Groups

    This plugin exposes the following metric groups:
    - `:phoenix_http_event_metrics`
    - `:phoenix_channel_event_metrics`
    - `:phoenix_socket_event_metrics`
    - `:phoenix_endpoint_metrics`

    ## Usage

    To use plugin in your application, add the following to your PromEx module:

    ```elixir
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {
            PromEx.Plugins.Phoenix,
            endpoint: MyApp.Endpoint,
            router: MyAppWeb.Public.Router
          }
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "phoenix.json"}
        ]
      end
    end
    ```

    When working with multiple Phoenix routers use the `endpoints` option instead:

    ```elixir
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {
            PromEx.Plugins.Phoenix,
            endpoints: [
              {MyApp.Endpoint, routers: [MyAppWeb.Public.Router]},
              {MyApp.Endpoint2, routers: [MyAppWeb.Admin.Router], event_prefix: [:admin, :endpoint]}
            ]
          }
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "phoenix.json"}
        ]
      end
    end
    ```
    """

    use PromEx.Plugin

    require Logger

    alias Phoenix.Socket
    alias Plug.Conn
    alias PromEx.Utils

    @stop_event [:prom_ex, :plugin, :phoenix, :stop]
    @init_event [:phoenix, :endpoint, :init]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :phoenix))
      phoenix_event_prefixes = fetch_event_prefixes!(opts)
      duration_unit = Keyword.get(opts, :duration_unit, :millisecond)
      normalize_event_name = Keyword.get(opts, :normalize_event_name, fn event -> event end)

      set_up_telemetry_proxy(phoenix_event_prefixes)

      # Event metrics definitions
      [
        endpoint_info(metric_prefix, opts),
        http_events(metric_prefix, opts),
        channel_events(metric_prefix, duration_unit, normalize_event_name),
        socket_events(metric_prefix, duration_unit)
      ]
    end

    defp endpoint_info(metric_prefix, opts) do
      phoenix_endpoints = normalize_endpoint(opts)

      keep_function_filter = keep_endpoint_metrics(phoenix_endpoints)

      Event.build(
        :phoenix_endpoint_metrics,
        [
          last_value(
            metric_prefix ++ [:endpoint, :url, :info],
            event_name: @init_event,
            description: "The configured URL of the Endpoint module.",
            measurement: fn _measurements -> 1 end,
            tag_values: &phoenix_init_tag_values/1,
            tags: [:url, :endpoint],
            keep: keep_function_filter
          ),
          last_value(
            metric_prefix ++ [:endpoint, :port, :info],
            event_name: @init_event,
            description: "The configured port of the Endpoint module.",
            measurement: fn _measurements -> 1 end,
            tag_values: &phoenix_init_tag_values/1,
            tags: [:port, :endpoint],
            keep: keep_function_filter
          )
        ]
      )
    end

    defp normalize_endpoint(opts) do
      cond do
        endpoint = Keyword.get(opts, :endpoint) ->
          [endpoint]

        endpoints = Keyword.get(opts, :endpoints) ->
          Enum.map(endpoints, fn e -> elem(e, 0) end)

        true ->
          []
      end
    end

    defp keep_endpoint_metrics(phoenix_endpoints) do
      fn %{module: module} ->
        module in phoenix_endpoints
      end
    end

    defp phoenix_init_tag_values(%{config: config, module: module}) do
      port =
        cond do
          Keyword.has_key?(config, :http) and config[:http][:port] ->
            config[:http][:port]

          Keyword.has_key?(config, :https) and config[:https][:port] ->
            config[:https][:port]

          true ->
            "Unknown"
        end

      %{
        endpoint: normalize_module_name(module),
        url: module.url(),
        port: port
      }
    end

    defp http_events(metric_prefix, opts) do
      routers = fetch_routers!(opts)
      additional_routes = fetch_additional_routes!(opts)
      http_metrics_tags = [:status, :method, :path, :controller, :action, :host]
      duration_unit = Keyword.get(opts, :duration_unit, :millisecond)
      duration_unit_plural = Utils.make_plural_atom(duration_unit)

      Event.build(
        :phoenix_http_event_metrics,
        [
          # Capture request duration information
          distribution(
            metric_prefix ++ [:http, :request, :duration, duration_unit_plural],
            event_name: @stop_event,
            measurement: :duration,
            description: "The time it takes for the application to respond to HTTP requests.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            tag_values: get_conn_tags(routers, additional_routes),
            tags: http_metrics_tags,
            unit: {:native, duration_unit}
          ),

          # Capture response payload size information
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: @stop_event,
            description: "The size of the HTTP response payload.",
            reporter_options: [
              buckets: [64, 512, 4_096, 65_536, 262_144, 1_048_576, 4_194_304, 16_777_216]
            ],
            measurement: fn _measurements, metadata ->
              case metadata.conn.resp_body do
                nil -> 0
                _ -> :erlang.iolist_size(metadata.conn.resp_body)
              end
            end,
            tag_values: get_conn_tags(routers, additional_routes),
            tags: http_metrics_tags,
            unit: :byte
          ),

          # Capture the number of requests that have been serviced
          counter(
            metric_prefix ++ [:http, :requests, :total],
            event_name: @stop_event,
            description: "The number of requests have been serviced.",
            tag_values: get_conn_tags(routers, additional_routes),
            tags: http_metrics_tags
          )
        ]
      )
    end

    defp channel_events(metric_prefix, duration_unit, normalize_event_name) do
      duration_unit_plural = Utils.make_plural_atom(duration_unit)

      Event.build(
        :phoenix_channel_event_metrics,
        [
          # Capture the number of channel joins that have occurred
          counter(
            metric_prefix ++ [:channel, :joined, :total],
            event_name: [:phoenix, :channel_joined],
            description: "The number of channel joins that have occurred.",
            tag_values: fn %{result: result, socket: %Socket{transport: transport, endpoint: endpoint}} ->
              %{
                transport: transport,
                result: result,
                endpoint: normalize_module_name(endpoint)
              }
            end,
            tags: [:result, :transport, :endpoint]
          ),

          # Capture channel handle_in duration
          distribution(
            metric_prefix ++ [:channel, :handled_in, :duration, duration_unit_plural],
            event_name: [:phoenix, :channel_handled_in],
            measurement: :duration,
            description: "The time it takes for the application to respond to channel messages.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000]
            ],
            tag_values: fn %{socket: %Socket{endpoint: endpoint, handler: handler}, event: event} ->
              %{
                endpoint: normalize_module_name(endpoint),
                event: normalize_event_name.(event),
                handler: normalize_module_name(handler)
              }
            end,
            tags: [:endpoint, :handler, :event],
            unit: {:native, duration_unit}
          )
        ]
      )
    end

    defp socket_events(metric_prefix, duration_unit) do
      duration_unit_plural = Utils.make_plural_atom(duration_unit)

      Event.build(
        :phoenix_socket_event_metrics,
        [
          # Capture socket connection duration
          distribution(
            metric_prefix ++ [:socket, :connected, :duration, duration_unit_plural],
            event_name: [:phoenix, :socket_connected],
            measurement: :duration,
            description: "The time it takes for the application to establish a socket connection.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000]
            ],
            tag_values: fn %{result: result, endpoint: endpoint, transport: transport} ->
              %{
                transport: transport,
                result: result,
                endpoint: normalize_module_name(endpoint)
              }
            end,
            tags: [:result, :transport, :endpoint],
            unit: {:native, duration_unit}
          )
        ]
      )
    end

    defp get_conn_tags(routers, []) do
      fn
        %{conn: %Conn{} = conn} ->
          default_route_tags = %{
            path: "Unknown",
            controller: "Unknown",
            action: "Unknown"
          }

          conn
          |> do_get_router_info(routers, default_route_tags)
          |> Map.merge(%{
            status: conn.status,
            method: conn.method,
            host: conn.host
          })

        _ ->
          Logger.warning("Could not resolve path for request")
      end
    end

    defp get_conn_tags(routers, additional_routes) do
      fn
        %{conn: %Conn{} = conn} ->
          default_route_tags = handle_additional_routes_check(conn, additional_routes)

          conn
          |> do_get_router_info(routers, default_route_tags)
          |> Map.merge(%{
            status: conn.status,
            method: conn.method,
            host: conn.host
          })

        _ ->
          Logger.warning("Could not resolve path for request")
      end
    end

    defp do_get_router_info(conn, routers, default_route_tags) do
      routers
      |> Enum.find_value(default_route_tags, fn router ->
        case Phoenix.Router.route_info(router, conn.method, conn.request_path, conn.host) do
          :error ->
            false

          %{route: path, plug: controller, plug_opts: action} ->
            %{
              path: path,
              controller: normalize_module_name(controller),
              action: normalize_action(action)
            }
        end
      end)
    end

    defp handle_additional_routes_check(%Conn{request_path: request_path}, additional_routes) do
      default_tags = %{
        path: "Unknown",
        controller: "Unknown",
        action: "Unknown"
      }

      additional_routes
      |> Enum.find_value(default_tags, fn {path_label, route_check} ->
        cond do
          is_binary(route_check) and route_check == request_path ->
            %{
              path: path_label,
              controller: "NA",
              action: "NA"
            }

          match?(%Regex{}, route_check) and Regex.match?(route_check, request_path) ->
            %{
              path: path_label,
              controller: "NA",
              action: "NA"
            }

          true ->
            false
        end
      end)
    end

    defp set_up_telemetry_proxy(phoenix_event_prefixes) do
      phoenix_event_prefixes
      |> Enum.each(fn telemetry_prefix ->
        stop_event = telemetry_prefix ++ [:stop]

        :telemetry.attach(
          [:prom_ex, :phoenix, :proxy] ++ telemetry_prefix,
          stop_event,
          &__MODULE__.handle_proxy_phoenix_event/4,
          %{}
        )
      end)
    end

    @doc false
    def handle_proxy_phoenix_event(_event_name, event_measurement, event_metadata, _config) do
      :telemetry.execute(@stop_event, event_measurement, event_metadata)
    end

    defp normalize_module_name(name) when is_atom(name) do
      name
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name(name), do: name

    defp normalize_action(action) when is_atom(action), do: action
    defp normalize_action(_action), do: "Unknown"

    defp fetch_additional_routes!(opts) do
      opts
      |> fetch_either!(:router, :endpoints)
      |> case do
        endpoints when is_list(endpoints) ->
          endpoints
          |> Enum.flat_map(fn
            {_endpoint, endpoint_opts} ->
              Keyword.get(endpoint_opts, :additional_routes, [])
          end)
          |> MapSet.new()
          |> MapSet.to_list()

        _router ->
          Keyword.get(opts, :additional_routes, [])
      end
    end

    defp fetch_event_prefixes!(opts) do
      opts
      |> fetch_either!(:router, :endpoints)
      |> case do
        endpoints when is_list(endpoints) ->
          endpoints
          |> Enum.map(fn
            {_endpoint, endpoint_opts} ->
              Keyword.get(endpoint_opts, :event_prefix, [:phoenix, :endpoint])
          end)

        _router ->
          [Keyword.get(opts, :event_prefix, [:phoenix, :endpoint])]
      end
      |> MapSet.new()
      |> MapSet.to_list()
    end

    defp fetch_routers!(opts) do
      opts
      |> fetch_either!(:router, :endpoints)
      |> case do
        endpoints when is_list(endpoints) ->
          endpoints
          |> Enum.flat_map(fn
            {_endpoint, endpoint_opts} ->
              endpoint_opts
              |> Keyword.fetch!(:routers)
          end)
          |> MapSet.new()
          |> MapSet.to_list()

        router ->
          [router]
      end
    end

    defp fetch_either!(keywordlist, key1, key2) do
      case {Keyword.has_key?(keywordlist, key1), Keyword.has_key?(keywordlist, key2)} do
        {true, _} ->
          keywordlist[key1]

        {false, true} ->
          keywordlist[key2]

        {false, false} ->
          raise KeyError, "Neither #{inspect(key1)} nor #{inspect(key2)} found in #{inspect(keywordlist)}"
      end
    end
  end
else
  defmodule PromEx.Plugins.Phoenix do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Phoenix")
    end
  end
end
