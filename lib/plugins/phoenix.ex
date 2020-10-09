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

  alias Plug.Conn

  def metrics(opts) do
    phoenix_router = Keyword.fetch!(opts, :router)

    #    :telemetry.attach(
    #      "promex-test",
    #      [:phoenix, :endpoint, :stop],
    #      fn arg1, arg2, arg3, arg4 ->
    #        IO.inspect(arg1)
    #        IO.inspect(arg2)
    #        IO.inspect(arg3)
    #        IO.inspect(arg4)
    #      end,
    #      nil
    #    )

    StandardMetrics.build([
      distribution(
        [:phoenix, :endpoint, :stop, :duration],
        description: "Dispatched by Plug.Telemetry in your endpoint whenever the response is sent",
        reporter_options: [
          buckets: exponential(1, 2, 12)
        ],
        tag_values: get_conn_tags(phoenix_router),
        tags: [:status, :method, :path, :controller, :action],
        unit: {:native, :millisecond}
      ),
      distribution(
        [:phoenix, :router_dispatch, :stop, :duration],
        description: "Dispatched by Phoenix.Router after successfully dispatching a matched route",
        reporter_options: [
          buckets: exponential(1, 2, 12)
        ],
        tag_values: get_conn_tags(phoenix_router),
        tags: [:status, :method, :path, :controller, :action],
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
