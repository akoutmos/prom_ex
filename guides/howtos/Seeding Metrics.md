# Seeding Metrics

In some applications, telemetry is only emitted periodically or in spurts. Capturing
these metrics via `c:PromEx.Plugin.event_metrics/1` can lead to gaps in Grafana graphs
after a service restart or deployment.

When an application starts, its Prometheus metrics are empty; its `metrics_server_path`
will only show metrics that have been emitted and captured by `PromEx` over the course
of the beam's lifespan. When a metric is not seen within a time period, Prometheus
returns no data for that metric, and in Grafana rather than data points with `0` values,
the graph will show `No Data`.

One mechanism to ensure that the graphs are populated is to seed the event metrics, i.e.
emit them at least once after `PromEx` has started. This can be done via a
`c:Application.start_phase/3`.


## Start Phases

Start phases are configured in a project's `application` callback in `mix.exs`:

```elixir
  def application do
    [
      extra_applications: [],
      mod: {MyApp.Application, []},
      start_phases: [seed_prom_ex_telemetry: []]
    ]
  end
```

This requires adding a callback to `MyApp.Application`:

```elixir
defmodule MyApp.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyApp.PromEx
      # ... Repo, Phoenix, etc
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def start_phase(:seed_prom_ex_telemetry, :normal, _) do
    MyApp.PromEx.seed_event_metrics()
    :ok
  end
end
```

The `seed_event_metrics/0` function can send any telemetry events desired, with any
variations in measurements and metadata to ensure that the `metrics_server_path` is
fully populated when it is first scraped.

```elixir
def seed_event_metrics do
  # :telemetry.execute([:my_app, :event], %{}, %{status: :ok})
  # :telemetry.execute([:my_app, :event], %{}, %{status: :error})
  # :telemetry.execute([:my_app, :event_span, :start], %{count: 1}, %{})
  # :telemetry.execute([:my_app, :event_span, :stop], %{count: 1}, %{})
  # :telemetry.execute([:my_app, :event_span, :exception], %{count: 1}, %{})

  :ok
end
```

One thing to note is that for counter metrics, seeding the events in this way will
result in the values being initialized to a count of `1`. In Grafana graphs showing
counters over time, the value resetting to *either* `0` or `1` will result in a negative
delta; one may want to combine `idelta` with `clamp_min`
(i.e. `clamp_min(idelta(<event_name>[$__rate_interval]), 0)`) to ensure that the
initial value after a restart appears in the graph as no change.
