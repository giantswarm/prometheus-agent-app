#!/bin/sh

### Config

metrics_url="localhost:9090/metrics"
overload_tolerance=2 # allow up to x times max shards


exit_error() {
    echo "ERROR: $*"
    exit 1
}

kill_overload() {
    echo "kill kill!"
    exit 1
}

### Default liveness probe:
#    livenessProbe:
#      failureThreshold: 6
#      httpGet:
#        path: /-/healthy
#        port: http-web
#        scheme: HTTP
#      periodSeconds: 5
#      successThreshold: 1
#      timeoutSeconds: 3
default_liveness() {
  wget --timeout 3 --tries 3 -q -O /dev/null http://localhost:9090/-/ready
  return $?
}


main() {

    default_liveness \
        || exit_error "liveness probe failed"

    shards_desire="$(wget -O- --timeout 2 --tries 3 -q "$metrics_url" \
                     | sed -n 's/^prometheus_remote_storage_shards_desire.* \([0-9]*\)\.[0-9]*/\1/p')"
    [ -z "$shards_desire" ] \
        && exit_error "could not determine desired shards"

    shards_max="$(wget -O- --timeout 2 --tries 3 -q "$metrics_url" \
                  | sed -n 's/^prometheus_remote_storage_shards_max.* \(.*\)/\1/p')"
    [ -z "$shards_max" ] \
        && exit_error "could not determine max shards"

    echo "Desired shards: $shards_desire / max $shards_max"

    [ "$shards_desire" -gt "$((shards_max * overload_tolerance))" ] \
        && exit_error "Overloaded - $shards_desire desired chards for max $shards_max shards"

    exit 0
}

main "$@"
