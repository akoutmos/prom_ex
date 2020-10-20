# PromEx

[![Hex.pm](https://img.shields.io/hexpm/v/prom_ex.svg)](http://hex.pm/packages/prom_ex) [![Build
Status](https://travis-ci.org/akoutmos/prom_ex.svg?branch=master)](https://travis-ci.org/akoutmos/prom_ex) [![Coverage
Status](https://coveralls.io/repos/github/akoutmos/prom_ex/badge.svg?branch=master)](https://coveralls.io/github/akoutmos/prom_ex?branch=master)

<img align="center" width="33%" src="/guides/images/logo.svg" alt="PromEx" style="margin-left:33%">

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

-   A behaviour that defines the contract for PromEx plug-ins
-   Mix tasks to upload the provided complimentary Grafana dashboards
-   The `PromEx.MetricTypes.Event` struct to define event based metrics
-   The `PromEx.MetricTypes.Polling` struct to define pollable metrics
-   The `PromEx.MetricTypes.Manual` struct to define manually refreshed metrics
-   The `PromEx.Plug` module that can be used in your Phoenix or Plug application to expose the collected metrics

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

### Attribution

It wouldn't feel right to not include somewhere in this project a "thanks" to the various projects that
helped make this possible:

-   The logo for the project is an edited version of an SVG image from the [unDraw project](https://undraw.co/)
-   The various projects available in [BEAM Telemetry](https://github.com/beam-telemetry)
-   All of the Prometheus libraries that Ilya Khaprov ([@deadtrickster](https://github.com/deadtrickster)) maintains
