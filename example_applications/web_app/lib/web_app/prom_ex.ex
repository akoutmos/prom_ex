defmodule WebApp.PromEx do
  @moduledoc """
  Be sure to add the following to finish setting up PromEx:

  1. Update your configuration (config.exs, dev.exs, prod.exs, releases.exs, etc) to
     configure the necessary bit of PromEx. Be sure to check out `PromEx.Config` for
     more details regarding configuring PromEx:
     ```
       config :web_app, WebApp.PromEx,
         manual_metrics_start_delay: :no_delay,
         drop_metrics_groups: [],
         grafana: :disabled,
         metrics_server: :disabled
     ```

  2. Add this module to your application supervision tree. It should be one of the first
     things that is started so that no Telemetry events are missed. For example, if PromEx
     is started after your Repo module, you will miss Ecto's init events and the dashbaords
     will be missing some data points:
     ```
     def start(_type, _args) do
       children = [
         WebApp.PromEx,

         ...
       ]

       ...
     end
     ```

  3. Update your `endpoint.ex` file to expose your metrics (or configure a standalone
     server using the `:metrics_server` config options). Be sure to put this plug before
     your `Plug.Telemetry` entry so that you can avoid having calls to your `/metrics`
     endpoint create their own metrics and logs which can pollute your logs/metrics given
     that Prometheus will scrape at a regular interval and that can get noisy:
     ```
     defmodule WebAppWeb.Endpoint do
       use Phoenix.Endpoint, otp_app: :web_app

       ...

       plug PromEx.Plug, prom_ex_module: WebApp.PromEx

       ...
     end
     ```
  """

  use PromEx, otp_app: :web_app

  @impl true
  def plugins do
    [
      # PromEx built in plugins
      PromEx.Plugins.Application,
      PromEx.Plugins.Beam,
      {PromEx.Plugins.Phoenix, router: WebAppWeb.Router},
      {PromEx.Plugins.Ecto, repos: [WebApp.Repo, WebApp.Repo2]},
      {PromEx.Plugins.Oban, oban_supervisors: [Oban, Oban.SuperSecret]}

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
      {:prom_ex, "oban.json"}

      # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
      # {:web_app, "/grafana_dashboards/user_metrics.json"}
    ]
  end
end
