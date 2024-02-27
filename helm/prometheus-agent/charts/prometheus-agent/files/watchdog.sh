#!/bin/sh

### Config

metrics_url="localhost:9090/metrics"
overload_tolerance="${WATCHDOG_OVERLOAD_TOLERANCE:-5}" # allow up to x times max shards
probe_timeout="${WATCHDOG_PROBE_TIMEOUT:-3}" # set the probe timeout to x seconds
probe_retries=3 # set the number of retries for the liveness probe to x


exit_error() {
    echo "$(basename "$0"): $*"
    exit 1
}

### Default liveness probe:
#    livenessProbe:
#      httpGet:
#        path: /-/healthy
#        port: http-web
#        scheme: HTTP
default_liveness() {
  wget --timeout "$probe_timeout" --tries "$probe_retries" -q -O /dev/null http://localhost:9090/-/healthy
  return $?
}


main() {

    default_liveness \
        || exit_error "failed to request /-/healthy endpoint"

    shards_desired="$(wget -O- --timeout "$probe_timeout" --tries "$probe_retries" -q "$metrics_url" \
                     | sed -n 's/^prometheus_remote_storage_shards_desired.* \([0-9]*\)\.[0-9]*/\1/p')"
    [ -z "$shards_desired" ] \
        && exit_error "could not determine desired shards"

    shards_max="$(wget -O- --timeout "$probe_timeout" --tries "$probe_retries" -q "$metrics_url" \
                  | sed -n 's/^prometheus_remote_storage_shards_max.* \(.*\)/\1/p')"
    [ -z "$shards_max" ] \
        && exit_error "could not determine max shards"

    [ "$shards_desired" -gt "$((shards_max * overload_tolerance))" ] \
        && exit_error "Overloaded - desired shards: $shards_desired / max $shards_max"

    exit 0
}

main "$@"
