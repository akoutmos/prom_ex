defmodule TestApp.UserController do
  use Phoenix.Controller, namespace: TestApp

  def index(conn, _params) do
    json(conn, %{some: "data"})
  end
end

defmodule TestApp.Router do
  use Phoenix.Router

  get("/users", TestApp.UserController, :index)
end
