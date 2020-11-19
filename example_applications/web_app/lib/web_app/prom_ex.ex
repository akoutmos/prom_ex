defmodule WebApp.PromEx do
  @moduledoc """
  PromEx metrics and dashboards for the application
  """

  use PromEx,
    otp_app: :web_app,
    delay_manual_start: :no_delay,
    drop_metrics_groups: [],
    upload_dashboards_on_start: true

  @impl true
  def plugins do
    [
      {PromEx.Plugins.Application, otp_app: :web_app},
      PromEx.Plugins.Beam,
      {PromEx.Plugins.Phoenix, router: WebAppWeb.Router}
    ]
  end

  @impl true
  def dashboards do
    [
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"}
    ]
  end
end
