[![CircleCI](https://circleci.com/gh/giantswarm/prometheus-agent-app.svg?style=shield)](https://circleci.com/gh/giantswarm/prometheus-agent-app)

[Read me after cloning this template (GS staff only)](https://intranet.giantswarm.io/docs/dev-and-releng/app-developer-processes/adding_app_to_appcatalog/)

# prometheus-agent chart

Giant Swarm offers a prometheus-agent App which can be installed in workload clusters.
Here we define the prometheus-agent chart with its templates and default configuration.

**What is this app?**

Prometheus-agent is a lightweight prometheus instance, that forwards metrics to a prometheus via remotewrites and does not manage storage of data.
See https://prometheus.io/blog/2021/11/16/agent/ for more context.

**Why did we add it?**

We use it to gather metrics on WCs, and remoteWrite them to prometheus on the MC.
This way we support features of Prometheus (like serviceMonitors) on the WCs, without actually hosting it there.

**Who can use it?**

GiantSwarm deploys prometheus-agent to all workload clusters, in the `kube-system` namespace.

## Prerequisites

- Prometheus operator CRDs: https://github.com/giantswarm/prometheus-operator-crd
- prometheus operator deployed: https://github.com/giantswarm/prometheus-operator-app

## Installing

There are several ways to install this app onto a workload cluster.

- [Using our web interface](https://docs.giantswarm.io/ui-api/web/app-platform/#installing-an-app).
- By creating an [App resource](https://docs.giantswarm.io/ui-api/management-api/crd/apps.application.giantswarm.io/) in the management cluster as explained in [Getting started with App Platform](https://docs.giantswarm.io/app-platform/getting-started/).

## Configuring

### values.yaml

**This is an example of a values file you could upload using our web interface.**

```yaml
# values.yaml
global:
  remoteWrite:
  - name: "remotewrite" 
    url: "http://$BASEDOMAIN/write"

prometheus-agent:
  serviceMonitor:
    enabled: true
    relabelings:
    # Add app label.
    - sourceLabels:
      - __meta_kubernetes_pod_label_app_kubernetes_io_name
      targetLabel: app
    # Add instance label.
    - sourceLabels:
      - __meta_kubernetes_pod_label_app_kubernetes_io_instance
      targetLabel: instance
    # Add node label.
    - sourceLabels:
      - __meta_kubernetes_pod_node_name
      targetLabel: node
    # Add team label.
    - sourceLabels:
      - __meta_kubernetes_pod_label_application_giantswarm_io_team
      targetLabel: team
```

### Conflicts 

To avoid conflicts with other prometheuses deployed to same cluster,
you can use selectors for `ServiceMonitors` and `PodMonitors`:

```yaml
prometheus-agent:
  serviceMonitorSelector:
    cluster: "c8dfg"
  podMonitorSelector:
    cluster: "c8dfg"
```
