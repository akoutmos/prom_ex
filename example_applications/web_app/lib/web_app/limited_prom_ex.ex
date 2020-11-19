defmodule WebApp.Limited.PromEx do
  @moduledoc """
  config :web_app, WebApp.PromEx,
    grafana_host: "",
    grafana_auth_token: "",
    grafana_datasource_id: ""
  """

  use PromEx,
    otp_app: :web_app,
    delay_manual_start: :no_delay,
    drop_metrics_groups: [],
    upload_dashboards_on_start: false

  @impl true
  def plugins do
    [
      {PromEx.Plugins.Application, otp_app: :web_app}
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
      # {:my_app, "/grafana_dashboards/business_related_metrics.json"}
    ]
  end
end
