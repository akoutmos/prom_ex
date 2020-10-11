unless Code.ensure_loaded?(Plug) do
  raise "Attempting to use PromEx.Plug when Plug has not been installed"
end

defmodule PromEx.Plug do
  @moduledoc """
  Use this plug in your Endpoint file to expose your metrics
  """

  alias Plug.Conn

  @behaviour Plug

  @impl true
  def init(opts) do
    %{
      metrics_path: Keyword.get(opts, :path, "/metrics")
    }
  end

  @impl true
  def call(%Conn{request_path: metrics_path} = conn, %{metrics_path: metrics_path}) do
    metrics = PromEx.get_metrics()

    conn
    |> Conn.put_resp_content_type("text/plain")
    |> Conn.send_resp(200, metrics)
    |> Conn.halt()
  end

  def call(conn, _opts) do
    conn
  end
end
