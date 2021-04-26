# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Added ETSCronFlusher GenServer to supervision tree to flush distribution metrics from ETS
  to address ETS memory leak when metrics are not scraped at a regular interval.

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
