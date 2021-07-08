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
    live("/", PageLive, :index)
    get("/users", UserController, :index)
    get("/users/:id", UserController, :show)
    post("/users/:id/action/level-up", UserController, :level_up)
    post("/users", UserController, :create)
    delete("/users/:id", UserController, :delete)
  end
end

defmodule TestApp.ExternalRouter do
  use Phoenix.Router

  import Phoenix.LiveView.Router

  scope "/external", TestApp do
    live("/", PageLive, :index)
    get("/users", UserController, :index)
    get("/users/:id", UserController, :show)
    post("/users/:id/action/level-up", UserController, :level_up)
    post("/users", UserController, :create)
    delete("/users/:id", UserController, :delete)
  end
end

defmodule TestApp.InternalRouter do
  use Phoenix.Router

  import Phoenix.LiveView.Router

  scope "/internal", TestApp do
    live("/", PageLive, :index)
    get("/users", UserController, :index)
    get("/users/:id", UserController, :show)
    post("/users/:id/action/level-up", UserController, :level_up)
    post("/users", UserController, :create)
    delete("/users/:id", UserController, :delete)
  end
end
