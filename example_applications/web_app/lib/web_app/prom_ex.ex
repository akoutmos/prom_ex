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
     is started after your Repo module, you will miss Ecto's init events and the dashboards
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

  alias PromEx.Plugins

  @additional_routes [
    special_label: "/really-cool-route",
    another_label: ~r(\/another-cool-route)
  ]

  @impl true
  def plugins do
    [
      # PromEx built in plugins
      Plugins.Application,
      Plugins.Beam,
      {Plugins.Phoenix, endpoint: WebAppWeb.Endpoint, router: WebAppWeb.Router},
      # # OR
      # #      {
      # #        Plugins.Phoenix,
      # #        endpoints: [
      # #          {WebAppWeb.Endpoint,
      # #           routers: [WebAppWeb.Router], additional_routes: @additional_routes},
      # #          {WebAppWeb.InternalEndpoint,
      # #           routers: [WebAppWeb.InternalRouter], event_prefix: [:internal, :endpoint]}
      # #        ]
      # #      },
      {Plugins.Ecto, repos: [WebApp.Repo, WebApp.Repo2]},
      {Plugins.Oban, oban_supervisors: [Oban, Oban.SuperSecret]},
      Plugins.PhoenixLiveView,
      {Plugins.PlugRouter, routers: [WebAppWeb.Router], event_prefix: [:phoenix, :endpoint]},
      {Plugins.PlugCowboy,
       ignore_routes: ["/metrics"], routers: [WebAppWeb.Router, WebAppWeb.InternalRouter]},
      PromEx.Plugins.Broadway

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
      {:prom_ex, "absinthe.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"},
      {:prom_ex, "ecto.json"},
      {:prom_ex, "oban.json"},
      {:prom_ex, "phoenix_live_view.json"},
      {:prom_ex, "plug_cowboy.json"},
      {:prom_ex, "plug_router.json"},
      {:prom_ex, "broadway.json", apply_function: &__MODULE__.tweak_broadway_dashboard/1}

      # Add your dashboard definitions here with the format: {:otp_app, "path_in_priv"}
      # {:web_app, "/grafana_dashboards/user_metrics.json"}
    ]
  end

  @doc false
  def tweak_broadway_dashboard(dashboard) do
    %{dashboard | "title" => "My really cool custom title for BROADWAY"}
  end
end
