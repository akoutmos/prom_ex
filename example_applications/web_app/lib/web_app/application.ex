defmodule WebApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Recorder Supervisor
      WebApp.RecorderSupervisor,

      # PromEx modules
      WebApp.PromEx,
      WebApp.Limited.PromEx,

      # Start the Ecto repository
      WebApp.Repo,
      WebApp.Repo2,

      # Work queue
      {Oban, oban_config()},
      {Oban, oban_super_secret_config()},

      # Start the Telemetry supervisor
      WebAppWeb.Telemetry,

      # Start the PubSub system
      {Phoenix.PubSub, name: WebApp.PubSub},

      # Start the Endpoint (http/https)
      WebAppWeb.Endpoint,
      WebAppWeb.InternalEndpoint,

      # Work generator for Oban
      # WebApp.RandomWorkGenerator

      # Work generator for Broadway
      WebApp.TempTracker,
      WebApp.CityProducer,
      WebApp.TempProcessor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    Application.get_env(:web_app, Oban)
  end

  defp oban_super_secret_config do
    Application.get_env(:web_app, Oban.SuperSecret)
  end
end
