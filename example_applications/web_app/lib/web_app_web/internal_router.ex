defmodule WebAppWeb.InternalRouter do
  use WebAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/internal", WebAppWeb do
    pipe_through :api

    resources "/events", EventController, only: [:index]
  end
end
