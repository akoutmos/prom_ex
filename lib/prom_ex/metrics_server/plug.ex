defmodule PromEx.MetricsServer.Plug do
  @moduledoc """
  This plug is used to serve metrics when PromEx is run in a
  standalone server configuration. This plug supports the
  following options:

  * `:path` - The route that should expose the metrics (default is "/metrics")
  * `:prom_ex_module` - The PromEx module that this plug will expose
  """

  @behaviour Plug

  require Logger

  import Plug.Conn

  alias Plug.Conn

  @impl true
  def init(opts) do
    # Get supported options and set defaults
    # TODO: Set up authorization header checks
    opts
    |> Keyword.take([:path, :prom_ex_module])
    |> Map.new()
    |> Map.put_new(:path, "/metrics")
  end

  @impl true
  def call(%Conn{request_path: path} = conn, %{path: path, prom_ex_module: prom_ex_module}) do
    case PromEx.get_metrics(prom_ex_module) do
      :prom_ex_down ->
        Logger.warn("Attempted to fetch metrics from #{prom_ex_module}, but the module has not been initialized")
        conn

      metrics ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(200, metrics)
    end
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "Not found")
  end
end
