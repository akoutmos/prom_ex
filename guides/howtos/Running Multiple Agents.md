# Running Multiple Agents

Suppose you want to send your metrics to two separate Prometheus databases, and define two separate sets of dashboards - one for the ops team, and one for the business team.
You can do this by creating two PromEx configurations.

To generate distinct PromEx modules:

```sh
mix prom_ex.gen.config -d ops -m PromExOps
mix prom_ex.gen.config -d biz -m PromExBiz
```

Each PromEx config will run its own Grafana Agent. You need to configure `working_directory`, `agent_port` and `grpc_port` to make sure they don't collide:

```elixir
config :my_app, MyApp.PromExOps,
  grafana_agent: [
    working_directory: System.fetch_env!("RELEASE_TMP") <> "/grafana-ops",
    config_opts: [
      ...
      agent_port: 4040,
      grpc_port: 9040
    ]
  ]

config :my_app, MyApp.PromExBiz,
  grafana_agent: [
    working_directory: System.fetch_env!("RELEASE_TMP") <> "/grafana-biz",
    config_opts: [
      ...
      agent_port: 4041,
      grpc_port: 9041
    ]
  ]
```

Add each module to your application's supervisor per the directions in the generated PromEx file.

## Endpoints

You can configure each agent to scrape the same set of metrics:

```elixir
# endpoint.ex
plug PromEx.Plug, prom_ex_module: MyApp.PromExOps

# in mix config, set `metrics_server_path: "/metrics"`
```

or define separate endpoints:

```elixir
plug PromEx.Plug, prom_ex_module: MyApp.PromExOps, path: "/metrics/ops"
plug PromEx.Plug, prom_ex_module: MyApp.PromExBiz, path: "/metrics/biz"
```
