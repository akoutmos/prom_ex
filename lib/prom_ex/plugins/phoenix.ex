unless Code.ensure_loaded?(Phoenix) do
  raise "Attempting to use PromEx Phoenix plugin when Phoenix has not been installed"
end

unless Code.ensure_loaded?(Plug) do
  raise "Attempting to use PromEx Phoenix plugin when Plug has not been installed"
end

defmodule PromEx.Plugins.Phoenix do
  @moduledoc """
  This plugin captures metrics emitted by Phoenix. Specifically, it captures HTTP request metrics and
  Phoenix channel metrics.

  This plugin supports the following options:
  - `router`: This is a REQUIRED option and is the full module name of your Phoenix Router (e.g MyAppWeb.Router).

  - `event_prefix`: This option is OPTIONAL and allows you to set the event prefix for the Telemetry events. This
    value should align with what you pass to `Plug.Telemetry` in your `endpoint.ex` file (see the plug docs
    for more information https://hexdocs.pm/plug/Plug.Telemetry.html)

  This plugin exposes the following metric groups:
  - `:phoenix_http_event_metrics`
  - `:phoenix_channel_event_metrics`

  To use plugin in your application, add the following to your application supervision tree:
  ```
  def start(_type, _args) do
    children = [
      ...
      {
        PromEx,
        plugins: [
          {PromEx.Plugins.Phoenix, router: MyAppWeb.Router},
          ...
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
  ```
  """

  use PromEx.Plugin

  require Logger

  alias Phoenix.Socket
  alias Plug.Conn

  @impl true
  def event_metrics(opts) do
    # Event metrics definitions
    [
      http_events(opts),
      channel_events()
    ]
  end

  defp http_events(opts) do
    # Fetch user options
    phoenix_router = Keyword.fetch!(opts, :router)
    event_prefix = Keyword.get(opts, :event_prefix, [:phoenix, :endpoint])

    # Shared configuration
    phoenix_stop_event = event_prefix ++ [:stop]
    http_metrics_tags = [:status, :method, :path, :controller, :action]

    Event.build(
      :phoenix_http_event_metrics,
      [
        # Capture request duration information
        distribution(
          [:phoenix, :http, :request, :duration, :milliseconds],
          event_name: phoenix_stop_event,
          measurement: :duration,
          description: "The time it takes for the application to respond to HTTP requests.",
          reporter_options: [
            buckets: exponential!(1, 2, 12)
          ],
          tag_values: get_conn_tags(phoenix_router),
          tags: http_metrics_tags,
          unit: {:native, :millisecond}
        ),

        # Capture response payload size information
        distribution(
          [:phoenix, :http, :response, :size, :bytes],
          event_name: phoenix_stop_event,
          description: "The size of the HTTP response payload.",
          reporter_options: [
            buckets: exponential!(1, 4, 12)
          ],
          measurement: fn _measurements, metadata ->
            :erlang.iolist_size(metadata.conn.resp_body)
          end,
          tag_values: get_conn_tags(phoenix_router),
          tags: http_metrics_tags,
          unit: :byte
        ),

        # Capture the number of requests that have been serviced
        counter(
          [:phoenix, :http, :requests, :total],
          event_name: phoenix_stop_event,
          description: "The number of requests have been serviced.",
          tag_values: get_conn_tags(phoenix_router),
          tags: http_metrics_tags
        )
      ]
    )
  end

  defp channel_events do
    Event.build(
      :phoenix_channel_event_metrics,
      [
        # Capture the number of channel joins that have occured
        counter(
          [:phoenix, :channel, :joined, :total],
          event_name: [:phoenix, :channel_joined],
          description: "The number of channel joins that have occured.",
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
          [:phoenix, :channel, :handled_in, :duration, :milliseconds],
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

  defp get_conn_tags(router) do
    fn
      %{conn: %Conn{} = conn} ->
        router
        |> Phoenix.Router.route_info(conn.method, conn.request_path, "")
        |> case do
          %{route: path, plug: controller, plug_opts: action} ->
            %{
              path: path,
              controller: controller,
              action: action
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
end
