# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.7.0] - 2024-09-05

### Added

- Support for extraArgs for prometheus-agent

### Changed

- Upgrade prometheus version to 2.51.1.

## [0.6.9] - 2024-03-01

### Changed

- Allow overridability of the watchdog probe timeout.

## [0.6.8] - 2024-02-19

### Added

- Possibility to set `enableHTTP2` for remoteWrites

### Changed

- remoteWrites have HTTP2 disabled by default

## [0.6.7] - 2024-01-09

### Changed

- Configure `gsoci.azurecr.io` as the default container image registry.

## [0.6.6] - 2023-10-30

### Added

- Add `affinity` in prometheus CR to avoid spot instances.

## [0.6.5] - 2023-10-11

### Added

- Add possibility to configure `keep_dropped_targets` on the agent.

### Changed

- Upgrade Prometheus to 2.47.1.

## [0.6.4] - 2023-10-04

### Fixed

- Change watchdog output

### Changed

- Raise WATCHDOG_OVERLOAD_TOLERANCE from 2 to 5 to be more tolerant on desired shards.

## [0.6.3] - 2023-09-21

### Changed

- Add anti-affinity in the Prometheus CR to avoid prometheus-agent shards from being scheduled on the same node if possible.

## [0.6.2] - 2023-09-12

### Changed

- Upgrade Prometheus to 2.47.0.

## [0.6.1] - 2023-09-11

### Fixed

- Really upgrade Prometheus to 2.46.0.

## [0.6.0] - 2023-09-04

### Changed

- Upgrade prometheus to 2.46.0 and update default configuration.
- Set priority-class to giantswarm-critical.

## [0.5.4] - 2023-07-31

### Fixed

- Remove prometheus and prometheus_replica external label to avoid exponential growth in metrics in big clusters.

## [0.5.3] - 2023-05-17

### Fixed

- Configure remote write integration name.

## [0.5.2] - 2023-05-10

### Changed

- Make the prometheus agent evictable by the cluster-autoscaler.

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

[Unreleased]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.7.0...HEAD
[0.7.0]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.9...v0.7.0
[0.6.9]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.8...v0.6.9
[0.6.8]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.7...v0.6.8
[0.6.7]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.6...v0.6.7
[0.6.6]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.5...v0.6.6
[0.6.5]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.4...v0.6.5
[0.6.4]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.3...v0.6.4
[0.6.3]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.2...v0.6.3
[0.6.2]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.5.4...v0.6.0
[0.5.4]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.5.3...v0.5.4
[0.5.3]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.5.2...v0.5.3
[0.5.2]: https://github.com/giantswarm/prometheus-agent-app/compare/v0.5.1...v0.5.2
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
