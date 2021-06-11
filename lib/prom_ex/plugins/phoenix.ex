if Code.ensure_loaded?(Phoenix) do
  defmodule PromEx.Plugins.Phoenix do
    @moduledoc """
    This plugin captures metrics emitted by Phoenix. Specifically, it captures HTTP request metrics and
    Phoenix channel metrics.

    This plugin supports the following options:
    - `router`: This is a REQUIRED option and is the full module name of your Phoenix Router (e.g MyAppWeb.Router).

    - `endpoint`: This is a REQUIRED option and is the full module name of your Phoenix Endpoint (e.g MyAppWeb.Endpoint).

    - `event_prefix`: This option is OPTIONAL and allows you to set the event prefix for the Telemetry events. This
      value should align with what you pass to `Plug.Telemetry` in your `endpoint.ex` file (see the plug docs
      for more information https://hexdocs.pm/plug/Plug.Telemetry.html)

    - `additional_routes`: This option is OPTIONAL and allows you to specify route path labels for applications routes
      not defined in your Router module. For example, if you want to track telemetry events for a plug in your
      `endpoint.ex` file, you can provide a keyword list with the structure `[some-route: ~r(\/some-path)]` and any
      time that the route is called and the plug handles the call, the path label for this particular Prometheus metric
      will be set to `some-route`. You can pass in either a regular expression or a string to match the incoming
      request.

    This plugin exposes the following metric groups:
    - `:phoenix_http_event_metrics`
    - `:phoenix_channel_event_metrics`
    - `:phoenix_socket_event_metrics`
    - `:phoenix_endpoint_manual_metrics`

    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.Phoenix, router: WebAppWeb.Router, endpoint: WebAppWeb.Endpoint}
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

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :phoenix)

      # Event metrics definitions
      [
        http_events(metric_prefix, opts),
        channel_events(metric_prefix),
        socket_events(metric_prefix)
      ]
    end

    @impl true
    def manual_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :phoenix)

      [
        endpoint_info(metric_prefix, opts)
      ]
    end

    defp endpoint_info(metric_prefix, opts) do
      # Fetch user options
      phoenix_endpoint = Keyword.fetch!(opts, :endpoint)

      Manual.build(
        :phoenix_endpoint_manual_metrics,
        {__MODULE__, :execute_phoenix_endpoint_info, [phoenix_endpoint]},
        [
          last_value(
            metric_prefix ++ [:endpoint, :url, :info],
            event_name: [:prom_ex, :plugin, :phoenix, :endpoint_url],
            description: "The configured URL of the Endpoint module.",
            measurement: :status,
            tags: [:url]
          ),
          last_value(
            metric_prefix ++ [:endpoint, :port, :info],
            event_name: [:prom_ex, :plugin, :phoenix, :endpoint_port],
            description: "The configured port of the Endpoint module.",
            measurement: :status,
            tags: [:port]
          )
        ]
      )
    end

    @doc false
    def execute_phoenix_endpoint_info(endpoint_module) do
      # TODO: This is a bit of a hack until Phoenix supports an init telemetry event to
      # reliably get the configuration.
      endpoint_init_checker = fn
        count, endpoint_init_checker_function when count < 10 ->
          case Process.whereis(endpoint_module) do
            pid when is_pid(pid) ->
              measurements = %{status: 1}
              url_metadata = %{url: endpoint_module.url()}
              :telemetry.execute([:prom_ex, :plugin, :phoenix, :endpoint_url], measurements, url_metadata)

              %URI{port: port} = endpoint_module.struct_url()
              port_metadata = %{port: port}
              :telemetry.execute([:prom_ex, :plugin, :phoenix, :endpoint_port], measurements, port_metadata)

            _ ->
              Process.sleep(1_000)
              endpoint_init_checker_function.(count + 1, endpoint_init_checker_function)
          end

        _, _ ->
          :noop
      end

      Task.start(fn ->
        endpoint_init_checker.(0, endpoint_init_checker)
      end)
    end

    defp http_events(metric_prefix, opts) do
      # Fetch user options
      phoenix_router = Keyword.fetch!(opts, :router)
      event_prefix = Keyword.get(opts, :event_prefix, [:phoenix, :endpoint])
      additional_routes = Keyword.get(opts, :additional_routes, [])

      # Shared configuration
      phoenix_stop_event = event_prefix ++ [:stop]
      http_metrics_tags = [:status, :method, :path, :controller, :action]

      Event.build(
        :phoenix_http_event_metrics,
        [
          # Capture request duration information
          distribution(
            metric_prefix ++ [:http, :request, :duration, :milliseconds],
            event_name: phoenix_stop_event,
            measurement: :duration,
            description: "The time it takes for the application to respond to HTTP requests.",
            reporter_options: [
              buckets: exponential!(1, 2, 12)
            ],
            tag_values: get_conn_tags(phoenix_router, additional_routes),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),

          # Capture response payload size information
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: phoenix_stop_event,
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
            tag_values: get_conn_tags(phoenix_router, additional_routes),
            tags: http_metrics_tags,
            unit: :byte
          ),

          # Capture the number of requests that have been serviced
          counter(
            metric_prefix ++ [:http, :requests, :total],
            event_name: phoenix_stop_event,
            description: "The number of requests have been serviced.",
            tag_values: get_conn_tags(phoenix_router, additional_routes),
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

    defp socket_events(metric_prefix) do
      Event.build(
        :phoenix_socket_event_metrics,
        [
          # Capture socket connection duration
          distribution(
            metric_prefix ++ [:socket, :connected, :duration, :milliseconds],
            event_name: [:phoenix, :socket_connected],
            measurement: :duration,
            description: "The time it takes for the application to establish a socket connection.",
            reporter_options: [
              buckets: exponential!(1, 2, 12)
            ],
            tags: [:result, :transport],
            unit: {:native, :millisecond}
          )
        ]
      )
    end

    defp get_conn_tags(router, []) do
      fn
        %{conn: %Conn{} = conn} ->
          router
          |> Phoenix.Router.route_info(conn.method, conn.request_path, "")
          |> case do
            %{route: path, plug: controller, plug_opts: action} ->
              %{
                path: path,
                controller: normalize_module_name(controller),
                action: normalize_action(action)
              }

            _ ->
              %{
                path: "Unknown",
                controller: "Unknown",
                action: "Unknown"
              }
          end
          |> Map.merge(%{
            status: conn.status,
            method: conn.method
          })

        _ ->
          # TODO: Change this to warning as warn is deprecated as of Elixir 1.11
          Logger.warn("Could not resolve path for request")
      end
    end

    defp get_conn_tags(router, additional_routes) do
      fn
        %{conn: %Conn{} = conn} ->
          router
          |> Phoenix.Router.route_info(conn.method, conn.request_path, "")
          |> case do
            %{route: path, plug: controller, plug_opts: action} ->
              %{
                path: path,
                controller: normalize_module_name(controller),
                action: normalize_action(action)
              }

            _ ->
              handle_additional_routes_check(conn, additional_routes)
          end
          |> Map.merge(%{
            status: conn.status,
            method: conn.method
          })

        _ ->
          # TODO: Change this to warning as warn is deprecated as of Elixir 1.11
          Logger.warn("Could not resolve path for request")
      end
    end

    defp normalize_action(action) when is_atom(action), do: action
    defp normalize_action(_action), do: "Unknown"

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

    defp normalize_module_name(name) when is_atom(name) do
      name
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name(name), do: name
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
