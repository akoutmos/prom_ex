# PromEx

[![Hex.pm](https://img.shields.io/hexpm/v/prom_ex.svg)](http://hex.pm/packages/prom_ex) [![Build
Status](https://github.com/akoutmos/prom_ex/workflows/PromEx%20CI/badge.svg)](https://github.com/akoutmos/prom_ex/actions) [![Coverage
Status](https://coveralls.io/repos/github/akoutmos/prom_ex/badge.svg?branch=master)](https://coveralls.io/github/akoutmos/prom_ex?branch=master)

<img align="center" width="33%" src="guides/images/logo.svg" alt="PromEx" style="margin-left:33%">

An Elixir Prometheus metrics collection library built on top of Telemetry

<br>

# Contents

- [Installation](#installation)
- [Design Philosophy](#design-philosophy)
- [Available Plugins](#available-plugins)
- [Grafana Dashboards](#grafana-dashboards)
- [Setting Up Metrics](#setting-up-metrics)
- [Performance Concerns](#performance-concerns)
- [Attribution](#attribution)

## Installation

This library is still under active development with changing API contracts and forked dependencies...use at your own
risk for now :).

[Available in Hex](https://hex.pm/packages/prom_ex), the package can be installed by adding `prom_ex`
to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:prom_ex, "~> 0.1.6-alpha"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/prom_ex](https://hexdocs.pm/prom_ex).

### Design Philosophy

With the widespread adoption of the Telemetry library and the other libraries in the [BEAM Telemetry GitHub
Org](https://github.com/beam-telemetry), we have reached a point where we have a consistent means of surfacing
application and library metrics. This allows us to have a great level of insight into our applications and dependencies
given that they all leverage the same fundamental tooling. The goal of this project is to provide a "Plug-in" style
library where you can easily add new plug-ins to surface metrics so that Prometheus can scrape them. Ideally, this
project acts as the "Metrics" pillar in your application (in reference to [The Three Pillars of
Observability](https://www.oreilly.com/library/view/distributed-systems-observability/9781492033431/ch04.html)).

To this end, while PromEx does provide a certain level of configurability (like the polling rate, starting behaviour for
manual metrics and all the options that the plugins receive), the goal is not to make an infinitely configurable tool.
For example, you are not able to edit the names/descriptions of Prometheus metrics via plugin options or even the tags
that are attached to the data points.

Instead, if there things that you don't agree with or that are incompatible with your usage of a certain 1st party
plugin and want to edit how the PromEx plugins react to Telemetry events, it is recommended that you fork the plugin in
question and edit it to your specific use case. If you think that the community can benefit for your changes, do not
hesitate to make a PR and I'll be sure to review it. This is not to say that event configurability will never come to
PromEx, but I want to make sure that the public facing API is clean and straightforward and not bogged down with
configuration. That and the Grafana dashboards would then have to become templatized to accommodate all this
configurability.

PromEx provides a few utilities to you in order to accomplish this goal:

- The `PromEx.Plug` module that can be used in your Phoenix or Plug application to expose the collected metrics
- A Mix task to upload the provided complimentary Grafana dashboards
- A Mix task to create a PromEx metrics capture module
- A behaviour that defines the contract for PromEx plug-ins
- A behaviour that defines the functionality of a PromEx metrics capture module
- Grafana dashboards tailored to each specific Plugin so that metrics work out of the box with dashboards

### Available Plugins

| Plugin                           | Status       | Description                                            |
| -------------------------------- | ------------ | ------------------------------------------------------ |
| `PromEx.Plugins.Application`     | Beta         | Collect metrics on your application dependencies       |
| `PromEx.Plugins.Beam`            | Beta         | Collect metrics regarding the BEAM virtual machine     |
| `PromEx.Plugins.Phoenix`         | Beta         | Collect request metrics emitted by Phoenix             |
| `PromEx.Plugins.Ecto`            | Next release | Collect query metrics emitted by Ecto                  |
| `PromEx.Plugins.PhoenixLiveView` | Next release | Collect metrics emitted by Phoenix LiveView            |
| `PromEx.Plugins.Absinthe`        | Next release | Collect GraphQL metrics emitted by Absinthe            |
| `PromEx.Plugins.Broadway`        | Coming soon  | Collect message processing metrics emitted by Broadway |
| `PromEx.Plugins.Oban`            | Coming soon  | Collect queue processing metrics emitted by Oban       |
| `PromEx.Plugins.Finch`           | Coming soon  | Collect HTTP request metrics emitted by Finch          |
| `PromEx.Plugins.Redix`           | Coming soon  | Collect Redis request metrics emitted by Redix         |
| More coming soon...              |              |                                                        |

### Grafana Dashboards

<img align="center" width="100%" src="guides/images/dashboards_preview.png" alt="PromEx">

PromEx comes with a custom tailored Grafana Dashboard per Plugin. [Click here](https://hexdocs.pm/prom_ex/grafana-dashboards.html)
to check out sample screenshots of each Plugin specific Grafana Dashbaord.

### Setting Up Metrics

The goal of PromEx is to have metrics set up be as simple and streamlined as possible. In that spirit, all
that you need to do to start leveraging PromEx along with the built-in plugins is to run the following mix
task:

```
$ mix prom_ex.create
```

Then add the generated module to your `application.ex` file supervision tree:

```elixir
defmodule MyCoolApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      ...

      MyCoolApp.PromEx
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

  plug PromEx.Plug, prom_ex_module: MyCoolApp.PromEx
  # Or plug PromEx.plug, path: "/some/other/non-standard/path", prom_ex_module: MyCoolApp.PromEx

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

### Performance Concerns

You may think to yourself that with all these metrics being collected and scraped, that the performance of your
application my be negatively impacted. Luckily PromEx is built upon the solid foundation established by the `Telemetry`,
`TelemetryMetrics`, and the `TelemetryMetricsPrometheus` projects. These libraries were designed to be as lightweight
and performant as possible. From some basic stress tests that I have run, I have been unable to observe any meaningful
or measurable performance reduction (thank you OTP and particularly ETS ;)). Here are six sample stress tests using
[wrk2](https://github.com/giltene/wrk2) with PromEx enabled and disabled with the following initialization
configuration:

```elixir
{
  PromEx,
  delay_manual_start: :no_delay,
  drop_metrics_groups: [:phoenix_channel_event_metrics],
  plugins: [
    {PromEx.Plugins.Phoenix, router: WebAppWeb.Router},
    PromEx.Plugins.Beam,
    {PromEx.Plugins.Application, [otp_app: :web_app]}
  ]
}
```

With out PromEx metrics collection:

```terminal
$ wrk2 -t5 -c50 -R 1000 -d10s 'http://localhost:4000/'
Running 10s test @ http://localhost:4000/
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.25ms    1.02ms  22.00ms   71.90%
    Req/Sec       -nan      -nan   0.00      0.00%
  10003 requests in 10.01s, 38.60MB read
Requests/sec:    999.78
Transfer/sec:      3.86MB

$ wrk2 -t5 -c50 -R 1000 -d10s 'http://localhost:4000/'
Running 10s test @ http://localhost:4000/
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.15ms    0.92ms  15.06ms   67.75%
    Req/Sec       -nan      -nan   0.00      0.00%
  10002 requests in 10.00s, 38.59MB read
Requests/sec:    999.73
Transfer/sec:      3.86MB

$ wrk2 -t5 -c50 -R 1000 -d10s 'http://localhost:4000/'
Running 10s test @ http://localhost:4000/
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.23ms    1.31ms  29.82ms   84.14%
    Req/Sec       -nan      -nan   0.00      0.00%
  10001 requests in 10.00s, 38.59MB read
Requests/sec:    999.82
Transfer/sec:      3.86MB
```

With PromEx metrics collection:

```terminal
$ wrk2 -t5 -c50 -R 1000 -d10s 'http://localhost:4000/'
Running 10s test @ http://localhost:4000/
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.55ms    1.69ms  36.86ms   94.40%
    Req/Sec       -nan      -nan   0.00      0.00%
  9999 requests in 10.00s, 38.58MB read
Requests/sec:   1000.11
Transfer/sec:      3.86MB

$ wrk2 -t5 -c50 -R 1000 -d10s 'http://localhost:4000/'
Running 10s test @ http://localhost:4000/
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.42ms    1.56ms  31.58ms   90.48%
    Req/Sec       -nan      -nan   0.00      0.00%
  10004 requests in 10.00s, 38.60MB read
Requests/sec:    999.93
Transfer/sec:      3.86MB

$ wrk2 -t5 -c50 -R 1000 -d10s 'http://localhost:4000/'
Running 10s test @ http://localhost:4000/
  5 threads and 50 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.39ms    1.09ms  18.56ms   72.96%
    Req/Sec       -nan      -nan   0.00      0.00%
  10001 requests in 10.00s, 38.59MB read
Requests/sec:    999.81
Transfer/sec:      3.86MB
```

### Attribution

It wouldn't be right to not include somewhere in this project a "thanks" to the various projects that
helped make this possible:

- The various projects available in [BEAM Telemetry](https://github.com/beam-telemetry)
- All of the Prometheus libraries that Ilya Khaprov ([@deadtrickster](https://github.com/deadtrickster)) maintains
- The logo for the project is an edited version of an SVG image from the [unDraw project](https://undraw.co/)
