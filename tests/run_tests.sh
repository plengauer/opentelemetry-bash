#!/bin/bash -e
set -e
export SHELL="$1"
if [ "$SHELL" = "" ]; then
  echo "need to specify shell to test"
  exit 1
fi
if [ "$SHELL" = busybox ]; then
  export SHELL="busybox sh";
fi

for dir in unit sdk auto integration; do
  for file in $(find $dir -iname 'test_*.shell') $(find $dir -iname 'test_*.'"$SHELL"); do
    rm /tmp/opentelemetry_shell_*_instrumentation_cache_*.aliases 2> /dev/null || true
    export OTEL_EXPORT_LOCATION=$(mktemp -u).sdk.out
    export OTEL_SHELL_SDK_OUTPUT_REDIRECT=$(mktemp -u -p "$(mktemp -d)").pipe
    export OTEL_TRACES_EXPORTER=console
    export OTEL_LOGS_EXPORTER=console
    mkfifo --mode=666 $OTEL_SHELL_SDK_OUTPUT_REDIRECT
    while true; do cat $OTEL_SHELL_SDK_OUTPUT_REDIRECT >> $OTEL_EXPORT_LOCATION; done &
    pipe_pid="$!"
    echo "running $file"
    options='-u -f'
    if [ "$SHELL" = bash ]; then
      options="$options -p -o pipefail"
    fi
    timeout $((60 * 60 * 3)) $SHELL $options $file && echo "SUCCEEDED" || (echo "FAILED" && cat $OTEL_EXPORT_LOCATION && exit 1)
    kill -9 "$pipe_pid"
  done
done
echo "ALL TESTS SUCCESSFUL"
