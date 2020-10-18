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

[Available in Hex](https://hex.pm/packages/prom_ex), the package can be installed
by adding `prom_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:prom_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/prom_ex](https://hexdocs.pm/prom_ex).

### Design Philosophy

With the widespread adoption of BEAM ecosystem projects like Telemetry and the other libraries in
the [BEAM Telemetry GitHub Org](https://github.com/beam-telemetry), we have reached a point where we
have a consistent means of surfacing application metrics. This allows us to have a great level of
insight into our applications and dependencies given that they all leverage the same fundamental
tools. The goal of this project is to provide a "Plug-in" style library where you can easily add new
plug-ins to surface metrics so that Prometheus can scrape them. Ideally, this project acts as the
"Metrics" pillar in your application (in reference to
[The Three Pillars of
Observability](https://www.oreilly.com/library/view/distributed-systems-observability/9781492033431/ch04.html)).

PromEx provides a few utilities to you in order to accomplish this goal:

-   A behaviour that defines the contract for a PromEx plug-in
-   Mix tasks to upload the provided Grafana dashboards that compliment the collected Prometheus metrics
-   The `PromEx.MetricTypes.Event` struct to define event based metrics
-   The `PromEx.MetricTypes.Poll` struct to define pollable metrics
-   The `PromEx.MetricTypes.Manual` struct to define manually refreshed metrics
-   The `PromEx.Plug` module that can be used in your Phoenix or Plug application to expose the collected metrics

### Available Plugins

### Setting Up Metrics

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/prom_ex](https://hexdocs.pm/prom_ex).

### Attribution

It wouldn't feel right to not include somewhere in this project a "thanks" to the various projects that
helped make this possible:

-
