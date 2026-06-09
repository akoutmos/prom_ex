# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- PromEx now uses Elixir 1.18 default JSON module and falls back to Jason if it is not available.

## [1.11.0] - 2024-10-24

### Fixed

- Phoenix plugin was not properly handling multiple endpoints [#254](https://github.com/akoutmos/prom_ex/pull/254).
- Oban plugin now sets queue state to zero [#245](https://github.com/akoutmos/prom_ex/pull/245) and [Oban Pro support](https://github.com/benonymus/prom_ex/commit/d5a56d0d4cc15bded4326dee0ac35e2f8c9b5d15).

## [1.10.0] - 2024-08-10

### Added

- Option to not detach polling metrics MFA calls when they encounter an error
  (see [#236](https://github.com/akoutmos/prom_ex/issues/236) for am example).
- Support for Peep as a metrics storage engine [#240](https://github.com/akoutmos/prom_ex/pull/240) &
  [#241](https://github.com/akoutmos/prom_ex/pull/241). Read the PromEx module docs for how this works as the
  implementation changed after this merge.
- Configuration for dashboard title [#226](https://github.com/akoutmos/prom_ex/pull/226).

### Fixed

- Pool size and timeout duration panels in Ecto dashboard [#223](https://github.com/akoutmos/prom_ex/pull/223).
- MFA invocation for GrafanaAgent configuration file creation.

### Changed

- Dropped support for old versions of Grafana Agent and now the only available version is the 0.42.0 release of Grafana
  Agent. Eventually PromEx will migrate to Grafana Alloy as that is the
  [successor for Grafana agent](https://grafana.com/blog/2024/04/09/grafana-alloy-opentelemetry-collector-with-prometheus-pipelines/).
- Updated package requirements as providing support for older versions of libraries is becoming difficult.
- Removed deprecated `Logger.warn` calls [#207](https://github.com/akoutmos/prom_ex/pull/207).
- The Phoenix plugin now leans on the `[:phoenix, :endpoint, :init]` telemetry event for `Endpoint` metrics as
  opposed to polling [c358232](https://github.com/akoutmos/prom_ex/commit/c35823256042da4047237b8420b498d69ae54b27).

## [1.9.0] - 2023-10-12

### Added

- Added host tag to phoenix plugin to handle paths depended on a subdomain [#183](https://github.com/akoutmos/prom_ex/pull/183)

### Changed

- Removed deprecated `Logger.warn` calls [#207](https://github.com/akoutmos/prom_ex/pull/207)

### Fixed

- Addressed binary memory leak in flusher GenServer [#200](https://github.com/akoutmos/prom_ex/pull/200)

## [1.8.0] - 2023-04-01

### Added

- Support for Phoenix 1.7 [#192](https://github.com/akoutmos/prom_ex/pull/192)
- Ability to customize time units via `:duration_unit` in plugins [#140](https://github.com/akoutmos/prom_ex/pull/140)
- Download Grafana Agent on FreeBSD [#156](https://github.com/akoutmos/prom_ex/pull/156)
- Ability to configure configure Grafana HTTP client Finch pools [#169](https://github.com/akoutmos/prom_ex/pull/169)
- Ability to pass additional params to GrafanaAgent config templates [161](https://github.com/akoutmos/prom_ex/pull/161)
- Ability to run multiple GrafanaAgent instances [#157](https://github.com/akoutmos/prom_ex/pull/157)
- Support for GrafanaAgent 29 [#184](https://github.com/akoutmos/prom_ex/pull/184)
- Support for Telemetry >= 1.0.0 [#193](https://github.com/akoutmos/prom_ex/pull/193)
- Ability to normalize channel event name in Phoenix plugin [#187](https://github.com/akoutmos/prom_ex/pull/187)

### Fixed

- Application crashing on startup from being unable to upload dashboards due to folder UID changing [#177](https://github.com/akoutmos/prom_ex/pull/177)
- Use topology name for message and exception tags in Broadway plugin [#134](https://github.com/akoutmos/prom_ex/pull/134)
- Ecto plugin issue when missing repo config [#144](https://github.com/akoutmos/prom_ex/pull/144)
- `prom_ex.dashboard.publish` Finch pool error [#127](https://github.com/akoutmos/prom_ex/pull/127) and
  [#152](https://github.com/akoutmos/prom_ex/pull/152)

## [1.7.1] - 2022-03-02

### Fixed

- Added missing priv dir to release.

## [1.7.0] - 2022-03-01

### Added

- Added ability to execute arbitrary function on resulting dashboard for user customization.
- The GrafanaClient is now considered part of the public API, and users can interact with Grafana directly. For example,
  users can publish their own Grafana annotations in addition to the annotations provided by PromEx.
- Added the ability to start GrafanaAgent via a port so that metrics can be published via `remote_write` to an other
  Prometheus instance. For example, if you are using GrafanaCloud, you can use PromEx to push metrics right to
  GrafanaCloud using the appropriate configuration. This feature is currently only available for Linux and OS X.
- The `ETSCronFlusher` GenServer can now be configured to flush the ETS buffer at whatever time interval you desire. The
  default is still every 7.5s.

### Fixed

- Broadway metrics prefix.
- Broadway dashboard panel descriptions and titles.
- Fixed the `:default_selected_interval` option in all dashboards.
- Phoenix plugin manual metrics were ignoring the metric prefix option.

### Changed

- Application plugin no longer logs warnings for missing GIT env vars.
- LifecycleAnnotator no longer logs warnings for missing GIT env vars.
- All plugin distribution buckets have been redefined. The reason for this being that prior to PromEx 1.7, some of the
  distribution buckets were a bit wasteful and were not adding value in terms of metrics data points. With this change,
  users should notice a decline in data point cardinality without compromising resolution.
- Application plugin has changed how it fetches dependency information. It is now using `Application.spec/1` to get the
  list of applications that are started with your application. This should reduce noise in the Grafana dashboard as all
  the default OTP and Elixir applications will not show up.
- All Grafana dashboard now have a default panel sort order where the largest timeseries plot is first in the list when
  hovering over the visuals.
- All Grafana dashboards now filter the instance filter based on the selected job filter.
- The Oban plugin no longer collects metrics related to `:circuit` events as those have been removed from Oban starting
  with version 2.11 (https://github.com/sorentwo/oban/pull/606). The Oban dashboard will be updated in the next release
  to remove the unused panels.

## [1.6.0] - 2021-12-22

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
