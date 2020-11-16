%{
  dashboards: [
    # PromEx built in dashboard definitions. Remove dashboards
    # that you do not need.
    {:prom_ex, "/grafana_dashboards/application.json"},
    {:prom_ex, "/grafana_dashboards/beam.json"},
    {:prom_ex, "/grafana_dashboards/phoenix.json"}

    # Add your dashboard definitions here
    # {:my_app, "/grafana_dashboards/business_related_metrics.json"}
  ]
}
