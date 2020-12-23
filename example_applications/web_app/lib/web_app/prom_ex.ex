defmodule WebApp.PromEx do
  @moduledoc """
  Full metrics
  """

  use PromEx, otp_app: :web_app

  @impl true
  def plugins do
    [
      # PromEx built in plugins
      PromEx.Plugins.Application,
      PromEx.Plugins.Beam,
      {PromEx.Plugins.Phoenix, router: WebAppWeb.Router},
      {PromEx.Plugins.Ecto, repos: [WebApp.Repo, WebApp.Repo2]}

      # Add your own PromEx metrics plugins
      # WebApp.Users.PromEx
    ]
  end

  @impl true
  def dashboard_assigns do
    [
      datasource_id: "prometheus"
    ]
  end

  @impl true
  def dashboards do
    [
      # PromEx built in dashboard definitions. Remove dashboards that you do not need
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"},
      {:prom_ex, "ecto.json"}

      # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
      # {:web_app, "/grafana_dashboards/user_metrics.json"}
    ]
  end
end
