defmodule WebApp.PromEx do
  @moduledoc """
  Be sure to add the following to finish setting up PromEx:

  1. Update your configuration (config.exs, dev.exs, prod.exs, releases.exs, etc):
  ```
    config :web_app, WebApp.PromEx,
      grafana_host: "<YOUR GRAFANA HOST HERE>",
      grafana_auth_token: "<YOUR GRAFANA AUTH TOKEN HERE>",
      grafana_datasource_id: "<THE NAME OF YOUR PROMETHEUS DATA SOURCE HERE>"
  ```

  2. Add this module to your application supervision tree:
  ```
  def start(_type, _args) do
    children = [
      ...

      WebApp.PromEx
    ]

    ...
  end
  ```

  3. Update your `endpoint.ex` file to expose your metrics:
  ```
  defmodule WebAppWeb.Endpoint do
    use Phoenix.Endpoint, otp_app: :web_app

    ...

    plug PromEx.Plug, prom_ex_module: WebApp.PromEx

    ...
  end
  ```
  """

  use PromEx,
    otp_app: :web_app,
    delay_manual_start: :no_delay,
    drop_metrics_groups: [],
    upload_dashboards_on_start: true

  @impl true
  def plugins do
    [
      # PromEx built in plugins
      {PromEx.Plugins.Application, otp_app: :web_app},
      PromEx.Plugins.Beam,
      {PromEx.Plugins.Phoenix, router: WebAppWeb.Router}

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
