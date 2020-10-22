defmodule WebApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # WebApp.Repo,
      # Start the Telemetry supervisor
      WebAppWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WebApp.PubSub},
      # Start the Endpoint (http/https)
      WebAppWeb.Endpoint,
      # Start a worker by calling: WebApp.Worker.start_link(arg)
      # {WebApp.Worker, arg}
      {
        PromEx,
        delay_manual_start: :no_delay,
        drop_metrics_groups: [:phoenix_channel_event_metrics],
        plugins: [
          {PromEx.Plugins.Phoenix, router: WebAppWeb.Router},
          PromEx.Plugins.Beam,
          {PromEx.Plugins.Application, [otp_app: :web_app]}
        ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WebAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
