unless Code.ensure_loaded?(Phoenix) do
  raise "Attempting to use PromEx Phoenix plugin when Phoenix has not been installed"
end

unless Code.ensure_loaded?(Plug) do
  raise "Attempting to use PromEx Phoenix plugin when Plug has not been installed"
end

defmodule PromEx.Plugins.Phoenix do
  @moduledoc """
  Telemetry events for: https://hexdocs.pm/phoenix/Phoenix.Logger.html
  """

  use PromEx

  require Logger

  alias Phoenix.Socket
  alias Plug.Conn

  def metrics(opts) do
    phoenix_router = Keyword.fetch!(opts, :router)

    StandardMetrics.build([
      # Capture request duration information
      distribution(
        [:phoenix, :http, :request, :duration, :milliseconds],
        event_name: [:phoenix, :endpoint, :stop],
        measurement: :duration,
        description: "The time it takes for the application to respond to HTTP requests",
        reporter_options: [
          buckets: exponential(1, 2, 12)
        ],
        tag_values: get_conn_tags(phoenix_router),
        tags: [:status, :method, :path, :controller, :action],
        unit: {:native, :millisecond}
      ),

      # Capture response payload size information
      distribution(
        [:phoenix, :http, :response, :size, :kilobytes],
        event_name: [:phoenix, :endpoint, :stop],
        description: "The size of the HTTP response payload",
        reporter_options: [
          buckets: exponential(1, 2, 16)
        ],
        measurement: fn _measurements, metadata ->
          :erlang.iolist_size(metadata.conn.resp_body)
        end,
        tag_values: get_conn_tags(phoenix_router),
        tags: [:status, :method, :path, :controller, :action],
        unit: :kilobyte
      ),

      # Capture the number of requests that have been serviced
      counter(
        [:phoenix, :http, :requests, :total],
        event_name: [:phoenix, :endpoint, :stop],
        description: "The number of requests have been serviced",
        tag_values: get_conn_tags(phoenix_router),
        tags: [:status, :method, :path, :controller, :action]
      ),

      # Capture the number of channel joins that have occured
      counter(
        [:phoenix, :channel, :joined, :total],
        event_name: [:phoenix, :channel_joined],
        description: "The number of channel joins that have occured",
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
        description: "The time it takes for the application to respond to channel messages",
        reporter_options: [
          buckets: exponential(1, 2, 12)
        ],
        unit: {:native, :millisecond}
      )
    ])
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
        Logger.warning("Could not resolve path for request")
    end
  end
end
