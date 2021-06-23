if Code.ensure_loaded?(Phoenix) do
  defmodule PromEx.Plugins.Phoenix do
    @moduledoc """
    This plugin captures metrics emitted by Phoenix. Specifically, it captures HTTP request metrics and
    Phoenix channel metrics.

    ## Plugin options

    ### REQUIRED

    One of the following:

    - `router`: This is the full module name of your Phoenix Router (e.g MyAppWeb.Router).
    - `routers`: This accepts a list of Phoenix Router module names (e.g [MyAppWeb.Public.Router, MyAppWeb.Admin.Router])

      Aditionally, instead of just the Router module name, one can pass `{module_name, event_prefix: [:some, :prefix]}` tuples. This allows you to set the event prefix for the Telemetry events. This
      value should align with what you pass to `Plug.Telemetry` in the `endpoint.ex` file **for each router** (see the plug docs
      for more information https://hexdocs.pm/plug/Plug.Telemetry.html)

    ### OPTIONAL

    - `event_prefix`: **When defining only one router**, allows you to set the event prefix for the Telemetry events.

      This value should align with what you pass to `Plug.Telemetry` in your `endpoint.ex` file (see the plug docs for more information https://hexdocs.pm/plug/Plug.Telemetry.html)
    - `additional_routes`: This option allows you to specify route path labels for applications routes
      not defined in your Router module.

      For example, if you want to track telemetry events for a plug in your
      `endpoint.ex` file, you can provide a keyword list with the structure `[some-route: ~r(\/some-path)]` and any
      time that the route is called and the plug handles the call, the path label for this particular Prometheus metric
      will be set to `some-route`. You can pass in either a regular expression or a string to match the incoming
      request.

    ## Metric Groups

    This plugin exposes the following metric groups:
    - `:phoenix_http_event_metrics`
    - `:phoenix_channel_event_metrics`

    ## Usage

    To use plugin in your application, add the following to your PromEx module:

    ```elixir
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.Phoenix, router: WebAppWeb.Router}
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

    When working with multiple Phoenix routers use the `routers` option instead:

    ```elixir
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {
            PromEx.Plugins.Phoenix,
            routers: [WebAppWeb.Public.Router, WebAppWeb.Admin.Router]
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

    @stop_event [:prom_ex, :plugin, :phoenix, :stop]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :phoenix)
      phoenix_event_prefixes = fetch_event_prefixes!(opts)

      set_up_telemetry_proxy(phoenix_event_prefixes)

      # Event metrics definitions
      [
        http_events(metric_prefix, opts),
        channel_events(metric_prefix)
      ]
    end

    defp http_events(metric_prefix, opts) do
      routers = fetch_routers!(opts)
      additional_routes = Keyword.get(opts, :additional_routes, [])
      http_metrics_tags = [:status, :method, :path, :controller, :action]

      Event.build(
        :phoenix_http_event_metrics,
        [
          # Capture request duration information
          distribution(
            metric_prefix ++ [:http, :request, :duration, :milliseconds],
            event_name: @stop_event,
            measurement: :duration,
            description: "The time it takes for the application to respond to HTTP requests.",
            reporter_options: [
              buckets: exponential!(1, 2, 12)
            ],
            tag_values: get_conn_tags(routers, additional_routes),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),

          # Capture response payload size information
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: @stop_event,
            description: "The size of the HTTP response payload.",
            reporter_options: [
              buckets: exponential!(1, 4, 12)
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

    defp channel_events(metric_prefix) do
      Event.build(
        :phoenix_channel_event_metrics,
        [
          # Capture the number of channel joins that have occurred
          counter(
            metric_prefix ++ [:channel, :joined, :total],
            event_name: [:phoenix, :channel_joined],
            description: "The number of channel joins that have occurred.",
            tag_values: fn %{result: result, socket: %Socket{transport: transport}} ->
              %{
                transport: transport,
                result: result
              }
            end,
            tags: [:result, :transport]
          ),

          # Capture channel handle_in duration
          distribution(
            metric_prefix ++ [:channel, :handled_in, :duration, :milliseconds],
            event_name: [:phoenix, :channel_handled_in],
            measurement: :duration,
            description: "The time it takes for the application to respond to channel messages.",
            reporter_options: [
              buckets: exponential!(1, 2, 12)
            ],
            unit: {:native, :millisecond}
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
            method: conn.method
          })

        _ ->
          # TODO: Change this to warning as warn is deprecated as of Elixir 1.11
          Logger.warn("Could not resolve path for request")
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
            method: conn.method
          })

        _ ->
          # TODO: Change this to warning as warn is deprecated as of Elixir 1.11
          Logger.warn("Could not resolve path for request")
      end
    end

    defp do_get_router_info(conn, routers, default_route_tags) do
      routers
      |> Enum.find_value(default_route_tags, fn router ->
        case Phoenix.Router.route_info(router, conn.method, conn.request_path, "") do
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
    defp normalize_action(_plug_opts), do: "NA"

    defp fetch_event_prefixes!(opts) do
      opts
      |> fetch_either!(:router, :routers)
      |> case do
        routers when is_list(routers) ->
          routers
          |> Enum.map(fn
            {_router, router_opts} ->
              Keyword.get(router_opts, :event_prefix, [:phoenix, :endpoint])

            _router ->
              [:phoenix, :endpoint]
          end)

        _router ->
          [Keyword.get(opts, :event_prefix, [:phoenix, :endpoint])]
      end
      |> MapSet.new()
    end

    defp fetch_routers!(opts) do
      opts
      |> fetch_either!(:router, :routers)
      |> case do
        routers when is_list(routers) ->
          routers
          |> Enum.map(fn
            {router, _opts} -> router
            router -> router
          end)

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
