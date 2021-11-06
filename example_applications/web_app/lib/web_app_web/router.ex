defmodule WebAppWeb.Router do
  use WebAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WebAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebAppWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/error", ErrorLive, :index
  end

  scope "/", WebAppWeb do
    pipe_through :api

    resources "/events", EventController, only: [:index]
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users/:id/action/level-up", UserController, :level_up
    post "/users", UserController, :create
    delete "/users/:id", UserController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: WebAppWeb.Telemetry
    end
  end
end
