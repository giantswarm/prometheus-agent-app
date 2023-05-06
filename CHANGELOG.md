# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.1] - 2023-05-06

### Fixed

- Fix scrape interval configuration.

## [0.5.0] - 2023-05-03

### Changed

- Add more options to configure the agent (prometheus versions, retention, replicas, shards and so on).

## [0.4.1] - 2023-04-21

### Fixed

- Fix preStop with removing the entire wal directory.

## [0.4.0] - 2023-04-20

### Changed

- `preStop` hook added to clean the agent wal before the container be killed
- set scrapeInterval configurable via values
- change default scrapeInterval from 30s to 60s

## [0.3.0] - 2023-03-22

### Changed

- Upgrade prometheus from `2.40.5` to `2.41.0`
- Add support for global.image.registry.
- Move to `default` App Catalog (so China's configs are applied) and because it is now a default app

## [0.2.0] - 2023-02-06

### Added

- watchdog to reset agent if too much data is enqueued, to reduce stress on remote prometheus

## [0.1.7] - 2022-12-19

### Fixed

- Allow overridabiliby of the tls configuration.

## [0.1.6] - 2022-12-06

### Added

- Add namespaceSingleton restriction, so installed only once.

### Changed

- Use `app-build-suite`.
- Upgrade prometheus from `2.39.1` to `2.40.5`

## [0.1.5] - 2022-11-08

### Fixed

- Fix prometheus template `podMonitorNamespaceSelector`

## [0.1.4] - 2022-10-20

### Added

- Add support to relabel metrics from the service monitor.

## [0.1.3] - 2022-10-19

### Added

- Add external labels support.

## [0.1.2] - 2022-10-13

### Changed

- Change how we configure the remote write endpoint and secrets.

## [0.1.1] - 2022-09-08

### Changed

- Follow best practices and some clean up.

## [0.1.0] - 2022-09-05

- First app iteration.

[Unreleased]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.5.1...HEAD
[0.5.1]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.4.1...v0.5.0
[0.4.1]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.7...v0.2.0
[0.1.7]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.6...v0.1.7
[0.1.6]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/prometheus-agent-app/releases/tag/v0.1.0
