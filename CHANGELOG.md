# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Updated BEAM plugin to surface JIT support
- Broadway metrics plugin
- Broadway Grafana dashboard

### Fixed

- LiveView plugin would detach exception handles when certain errors were encountered

## [1.5.0] - 2021-11-04

### Added

- Links to HexDocs from Grafana dashboards
- Links to GitHub sponsorship from Grafana dashboards
- Endpoint label to channel metrics
- Ecto Grafana dashboard panels for total time metrics
- Phoenix Grafana dashboard panels for socket connections

### Fixed

- PhoenixLiveView plugin error label is now normalized
- Documentation for Phoenix plugin was cleaned up

## [1.4.1] - 2021-09-06

### Added

- Added a configuration to the dashboard assigns so that the default time interval can be specified
  by the user as opposed to being hard coded to 30s.

### Fixed

- Fixed Plug.Router plugin to handle requests without conn.private.plug_route info

## [1.4.0] - 2021-09-01

### Changed

- The Phoenix plugin now requires an `:endpoint` configuration option to be passed to it containing the module
  for which metrics will be captured.

### Added

- Plug.Router plugin and dashboard.
- PlugCowboy plugin and dashboard.
- Phoenix plugin now supports multiple routers and multiple endpoints.
- Phoenix plugin and dashboards now contains endpoint configuration data.
- Phoenix plugin now captures socket metrics (dashboard not yet updated though).
- Ecto plugin captures total_time metrics (dashboard not yet updated though).
- Add an optional configuration to dashboard renderer and each plugin so that the `metrics_prefix` can be altered.

### Fixed

- Oban dashboard overview stat panels.

## [1.3.0] - 2021-07-02

### Added

- Absinthe plugin and dashboard.
- Erlang persistent_term metrics to BEAM dashboard.

## [1.2.1] - 2021-06-18

### Fixed

- Addressed bug in later version of LiveView when extracting the LiveView module from a Telemetry event.

## [1.2.2] - 2021-06-24

### Added

- Added the ability to disable the entire PromEx supervision tree. Useful for when you
  are running tests and you don't want telemetry events attached or polling events
  running.

## [1.2.1] - 2021-06-18

### Fixed

- Addressed bug when Phoenix metric labels fails to serialize due to `forward` macro
  plug options list.

## [1.2.0] - 2021-06-15

### Fixed

- GrafanaClient module error case statement. Relaxed the pattern matching so that unaccounted
  for responses from Grafana don't crash the GenServer.

### Added

- Added the `additional_routes` option to the Phoenix plugin so that routes not defined in
  the router module can still be labeled correctly.

## [1.1.1] - 2021-05-27

### Fixed

- Phoenix plugin encountered an error when the response body was empty.
- Fix for multiple applications attempting to use the same Grafana folder
- Documentation fixes and grafana dashboard typos

### Changed

- Switch back to a released version of `telemetry_metrics_prometheus_core` now that a new
  release have been cut to include necessary functionality for PromEx.

## [1.1.0] - 2021-04-28

### Added

- Added ETSCronFlusher GenServer to supervision tree to flush distribution metrics from ETS
  to address ETS memory leak when metrics are not scraped at a regular interval.
- Added ability to authenticate with Grafana via Basic auth (username and password).

### Fixed

- Fixed a bug in the polling metrics period interval configuration.
- Fixed typespec for dashboard definitions.
- Fixed dashboard assigns when exporting an existing dashboard.

## [1.0.1] - 2021-03-14

### Changed

- Updated documentation

### Fixed

- Issue with Oban plugins that also have options

## [1.0.0] - 2021-02-19

- First stable release. Public facing API is now considered stable

## [0.1.15-beta] - 2021-02-12

### Changed

- Updated mix gen config task to comment out plugins that require dependencies
- Updated documentation

### Added

- Screenshots of all dashboards
- Tests for mix gen config task

### Changed

- Updated documentation

## [0.1.14-beta] - 2021-02-09

### Added

- LiveView metrics plugin and dashboard

### Changed

- The `mix prom_ex.create` mix task has been renamed to `mix prom_ex.gen_config` to align to ecosystem tooling
- The `mix prom_ex.export_dashboard` mix task has been renamed to `mix prom_ex.dashboard.export`
- The `mix prom_ex.publish` mix task has been renamed to `mix prom_ex.dashboard.publish`
- The `mix prom_ex.lint` mix task has been renamed to `mix prom_ex.dashboard.lint`
- Fixed dialyzer supervisor error
- Added error messaging when attempting to publish dashboards to Grafana but Grafana configuration is disabled

## [0.1.13-beta] - 2021-02-04

### Added

- Mix Task to export rendered Grafana dashboards to file or STDOUT
- Added Oban PromEx plugin
- Added Oban Grafana dashboard
- Error logging to Grafana dashboard uploader and life-cycle annotator

### Fixed

- Fixed Phoenix Grafana dashboard errors
