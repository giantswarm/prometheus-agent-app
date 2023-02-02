#!/bin/sh

### Config

metrics_url="localhost:9090/metrics"
overload_tolerance="${WATCHDOG_OVERLOAD_TOLERANCE:-2}" # allow up to x times max shards


exit_error() {
    echo "ERROR: $*"
    exit 1
}

### Default liveness probe:
#    livenessProbe:
#      httpGet:
#        path: /-/healthy
#        port: http-web
#        scheme: HTTP
default_liveness() {
  wget --timeout 3 --tries 3 -q -O /dev/null http://localhost:9090/-/healthy
  return $?
}


main() {

    default_liveness \
        || exit_error "liveness probe failed"

    shards_desired="$(wget -O- --timeout 2 --tries 3 -q "$metrics_url" \
                     | sed -n 's/^prometheus_remote_storage_shards_desired.* \([0-9]*\)\.[0-9]*/\1/p')"
    [ -z "$shards_desired" ] \
        && exit_error "could not determine desired shards"

    shards_max="$(wget -O- --timeout 2 --tries 3 -q "$metrics_url" \
                  | sed -n 's/^prometheus_remote_storage_shards_max.* \(.*\)/\1/p')"
    [ -z "$shards_max" ] \
        && exit_error "could not determine max shards"

    echo "Desired shards: $shards_desired / max $shards_max"

    [ "$shards_desired" -gt "$((shards_max * overload_tolerance))" ] \
        && exit_error "Overloaded - $shards_desired desired chards for max $shards_max shards"

    exit 0
}

main "$@"
