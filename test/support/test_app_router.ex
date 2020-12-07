defmodule TestApp.Router do
  use Phoenix.Router

  get("/users", UserController, :index)
end
