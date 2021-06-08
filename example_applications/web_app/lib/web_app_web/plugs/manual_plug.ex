defmodule WebAppWeb.ManualPlug do
  @behaviour Plug

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, _opts) do
    cond do
      conn.request_path == "/really-cool-route" ->
        conn
        |> Phoenix.Controller.json(%{a: 10})
        |> Plug.Conn.halt()

      conn.request_path == "/another-cool-route" ->
        conn
        |> Phoenix.Controller.json(%{a: 5})
        |> Plug.Conn.halt()

      true ->
        conn
    end
  end
end
