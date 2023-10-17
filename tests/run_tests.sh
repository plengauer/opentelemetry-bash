#!/bin/bash
set -e
export SHELL=$1
if [ "$SHELL" == "" ]; then
  echo "need to specify shell to test"
  exit 1
fi

(while sleep 15; do pstree -a -c -p; done) &
for file in $(find . -iname 'test_*.shell') $(find . -iname 'test_*.'$SHELL); do
  export OTEL_EXPORT_LOCATION=$(mktemp -u).sdk.out
  export OTEL_SHELL_SDK_OUTPUT_REDIRECT=$(mktemp -u).pipe
  export OTEL_SHELL_TRACES_ENABLE=TRUE
  export OTEL_SHELL_METRICS_ENABLE=TRUE
  export OTEL_SHELL_LOGS_ENABLE=TRUE
  export OTEL_TRACES_CONSOLE_EXPORTER=TRUE
  export OTEL_METRICS_CONSOLE_EXPORTER=TRUE
  export OTEL_LOGS_CONSOLE_EXPORTER=TRUE
  mkfifo $OTEL_SHELL_SDK_OUTPUT_REDIRECT
  cat $OTEL_SHELL_SDK_OUTPUT_REDIRECT > $OTEL_EXPORT_LOCATION &
  echo "running $file"
  timeout 60 $SHELL -x $file && echo "SUCCEEDED" || (echo "FAILED" && cat $OTEL_EXPORT_LOCATION && exit 1)
done
echo "ALL TESTS SUCCESSFUL"
