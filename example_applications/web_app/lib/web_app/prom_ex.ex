defmodule WebApp.PromEx do
  @moduledoc """
  Full metrics
  """

  use PromEx, otp_app: :web_app

  @impl true
  def plugins do
    [
      # PromEx built in plugins
      {PromEx.Plugins.Application, otp_app: :web_app},
      PromEx.Plugins.Beam,
      {PromEx.Plugins.Phoenix, router: WebAppWeb.Router},
      {PromEx.Plugins.Ecto, otp_app: :web_app, repo: WebApp.Repo}

      # Add your own PromEx metrics plugins
      # WebApp.Users.PromEx
    ]
  end

  @impl true
  def dashboards do
    [
      # PromEx built in dashboard definitions. Remove dashboards that you do not need
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"}

      # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
      # {:web_app, "/grafana_dashboards/user_metrics.json"}
    ]
  end
end
