defmodule TestApp.UserController do
  use Phoenix.Controller, namespace: TestApp

  def index(conn, _params) do
    json(conn, %{some: "data"})
  end
end

defmodule TestApp.Router do
  use Phoenix.Router

  import Phoenix.LiveView.Router

  scope "/", TestApp do
    live "/", PageLive, :index
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users/:id/action/level-up", UserController, :level_up
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
  end
end

defmodule TestApp.ExternalRouter do
  use Phoenix.Router

  import Phoenix.LiveView.Router

  scope "/external", TestApp do
    live "/", PageLive, :index
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users/:id/action/level-up", UserController, :level_up
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
  end
end

defmodule TestApp.InternalRouter do
  use Phoenix.Router

  import Phoenix.LiveView.Router

  scope "/internal", TestApp do
    live "/", PageLive, :index
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users/:id/action/level-up", UserController, :level_up
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
  end
end

defmodule TestApp.PlugRouter do
  use Plug.Router

  plug PromEx.Plug, prom_ex_module: TestApp.PromEx, path: "/metrics"
  plug Plug.Telemetry, event_prefix: [:testapp, :plug, :router]
  plug Plug.Parsers, parsers: [:json], json_decoder: PromEx.JSON
  plug :match
  plug :dispatch

  get "/users/:id" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, PromEx.JSON.encode!(%{"id" => conn.params["id"]}))
    |> halt()
  end

  match _ do
    send_resp(conn, 404, "Not found.")
  end
end
