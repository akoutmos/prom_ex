defmodule TestApp.UserController do
  use Phoenix.Controller, namespace: TestApp

  def index(conn, _params) do
    json(conn, %{some: "data"})
  end
end

defmodule TestApp.Router do
  use Phoenix.Router

  scope "/", TestApp do
    get("/users", UserController, :index)
    get("/users/:id", UserController, :show)
    post("/users/:id/action/level-up", UserController, :level_up)
    post("/users", UserController, :create)
    delete("/users/:id", UserController, :delete)
  end
end
