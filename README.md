# PromEx

[![Hex.pm](https://img.shields.io/hexpm/v/prom_ex.svg)](http://hex.pm/packages/prom_ex) [![Build
Status](https://github.com/akoutmos/prom_ex/workflows/PromEx%20CI/badge.svg)](https://github.com/akoutmos/prom_ex/actions) [![Coverage
Status](https://coveralls.io/repos/github/akoutmos/prom_ex/badge.svg?branch=master)](https://coveralls.io/github/akoutmos/prom_ex?branch=master)

<img align="center" width="33%" src="guides/images/logo.svg" alt="PromEx" style="margin-left:33%">

An Elixir Prometheus metrics collection library built on top of Telemetry

---

## Installation

This library is still under active development with changing API contracts and forked dependencies...use at your own
risk for now :).

[Available in Hex](https://hex.pm/packages/prom_ex), the package can be installed by adding `prom_ex`
to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:prom_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/prom_ex](https://hexdocs.pm/prom_ex).

### Design Philosophy

With the widespread adoption of the Telemetry library and the other libraries in the [BEAM Telemetry GitHub
Org](https://github.com/beam-telemetry), we have reached a point where we have a consistent means of surfacing
application metrics. This allows us to have a great level of insight into our applications and dependencies given that
they all leverage the same fundamental tooling. The goal of this project is to provide a "Plug-in" style library where
you can easily add new plug-ins to surface metrics so that Prometheus can scrape them. Ideally, this project acts as the
"Metrics" pillar in your application (in reference to [The Three Pillars of
Observability](https://www.oreilly.com/library/view/distributed-systems-observability/9781492033431/ch04.html)).

PromEx provides a few utilities to you in order to accomplish this goal:

- A behaviour that defines the contract for PromEx plug-ins
- Mix tasks to upload the provided complimentary Grafana dashboards
- The `PromEx.MetricTypes.Event` struct to define event based metrics
- The `PromEx.MetricTypes.Polling` struct to define pollable metrics
- The `PromEx.MetricTypes.Manual` struct to define manually refreshed metrics
- The `PromEx.Plug` module that can be used in your Phoenix or Plug application to expose the collected metrics

### Available Plugins

| Plugin                       | Status      | Description                                            |
| ---------------------------- | ----------- | ------------------------------------------------------ |
| `PromEx.Plugins.Application` | Alpha       | Collect metrics on your application dependencies       |
| `PromEx.Plugins.Beam`        | Alpha       | Collect metrics regarding the BEAM virtual machine     |
| `PromEx.Plugins.Phoenix`     | Alpha       | Collect request metrics emitted by Phoenix             |
| `PromEx.Plugins.Ecto`        | Coming soon | Collect query metrics emitted by Ecto                  |
| `PromEx.Plugins.Broadway`    | Coming soon | Collect message processing metrics emitted by Broadway |
| `PromEx.Plugins.Finch`       | Coming soon | Collect HTTP request metrics emitted by Finch          |
| More coming soon...          |             |                                                        |

### Setting Up Metrics

The goal of PromEx is to have metrics set up be as simple and streamlined as possible. In that spirit, all
that you need to do to start leveraging PromEx along with the built-in plugins is the following in your
`application.ex` file:

```elixir
defmodule MyCoolApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      ...

      {
        PromEx,
        plugins: [
          {PromEx.Plugins.Phoenix, router: MyCoolAppWeb.Router},
          PromEx.Plugins.Beam,
          {PromEx.Plugins.Application, [otp_app: :my_cool_app]},
          # Any additional PromEx plugins you would like to enable
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: MyCoolApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

With that in place, all that you need to do is then add the PromEx plug somewhere in your
`endpoint.ex` file (I would suggest putting it before your `plug Plug.Telemetry` call so that
you do not pollute your logs with calls to `/metrics`):

```elixir
defmodule MyCoolAppWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :my_cool_app

  ...

  plug PromEx.Plug
  # Or plug PromEx.plug, path: "/some/other/non-standard/path"

  ...

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  ...

  plug MyCoolAppWeb.Router
end
```

With that in place, all you need to do is start your server and you should be able to hit your
metrics endpoint and see your application metrics:

```terminal
$ curl localhost:4000/metrics
# HELP my_cool_app_application_dependency_info Information regarding the application's dependencies.
# TYPE my_cool_app_application_dependency_info gauge
my_cool_app_application_dependency_info{modules="69",name="hex",version="0.20.5"} 1
my_cool_app_application_dependency_info{modules="1",name="connection",version="1.0.4"} 1
my_cool_app_application_dependency_info{modules="4",name="telemetry_poller",version="0.5.1"} 1
...
...
```

Be sure to check out the module docs for each plugin that you choose to use to ensure that you are familiar
with all of the options that they provide.

### Attribution

It wouldn't be right to not include somewhere in this project a "thanks" to the various projects that
helped make this possible:

- The various projects available in [BEAM Telemetry](https://github.com/beam-telemetry)
- All of the Prometheus libraries that Ilya Khaprov ([@deadtrickster](https://github.com/deadtrickster)) maintains
- The logo for the project is an edited version of an SVG image from the [unDraw project](https://undraw.co/)
