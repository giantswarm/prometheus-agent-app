[![CircleCI](https://circleci.com/gh/giantswarm/prometheus-agent-app.svg?style=shield)](https://circleci.com/gh/giantswarm/prometheus-agent-app)

[Read me after cloning this template (GS staff only)](https://intranet.giantswarm.io/docs/dev-and-releng/app-developer-processes/adding_app_to_appcatalog/)

# prometheus-agent chart

Giant Swarm offers a prometheus-agent App which can be installed in workload clusters.
Here we define the prometheus-agent chart with its templates and default configuration.

**What is this app?**

This app installs a Prometheus CR bundled with all required resources(RBAC, SA, NetworkPolicy...) in WC.

**Why did we add it?**

In order to scrape authenticated endpoints in WC, we implemented this prometheus-agent which can send metrics via remotewrite to the MC.

**Who can use it?**

Anyone.

## Installing

There are several ways to install this app onto a workload cluster.

- [Using our web interface](https://docs.giantswarm.io/ui-api/web/app-platform/#installing-an-app).
- By creating an [App resource](https://docs.giantswarm.io/ui-api/management-api/crd/apps.application.giantswarm.io/) in the management cluster as explained in [Getting started with App Platform](https://docs.giantswarm.io/app-platform/getting-started/).

## Configuring

### values.yaml

**This is an example of a values file you could upload using our web interface.**

```yaml
# values.yaml
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

### Sample App CR and ConfigMap for the management cluster

If you have access to the Kubernetes API on the management cluster, you could create
the App CR and ConfigMap directly.

Here is an example that would install the app to
workload cluster `abc12`:

```yaml
# appCR.yaml
apiVersion: application.giantswarm.io/v1alpha1
kind: App
metadata:
  labels:
    app-operator.giantswarm.io/version: 6.4.1
    application.giantswarm.io/team: atlas
    giantswarm.io/cluster: abc12
  name: prometheus-agent
  namespace: abc12
spec:
  catalog: giantswarm-playground
  config:
    configMap:
      name: ""
      namespace: ""
    secret:
      name: ""
      namespace: ""
  kubeConfig:
    context:
      name: abc12
    inCluster: false
    secret:
      name: abc12-kubeconfig
      namespace: abc12
  userConfig:
    configMap:
      name: "prometheus-agent-chart-values"
      namespace: "abc12"    
  name: prometheus-agent
  namespace: kube-system
  version: 0.1.4
```

```yaml
# user-values-configmap.yaml
apiVersion: v1
data:
  values: |
      global:
          remoteWrite:
           - name: "abc12" 
             url: "$BASEDOMAIN/abc12"
kind: ConfigMap
metadata:
  name: prometheus-agent-chart-values
  namespace: abc12
```

See our [full reference on how to configure apps](https://docs.giantswarm.io/app-platform/app-configuration/) for more details.

## Compatibility

This app has been tested to work with the following workload cluster release versions:

- _add release version_

## Limitations

Some apps have restrictions on how they can be deployed.
Not following these limitations will most likely result in a broken deployment.

- _add limitation_

## Credit

- {APP HELM REPOSITORY}
