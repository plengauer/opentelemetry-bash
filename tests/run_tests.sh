#!/bin/bash
set -e
export SHELL=$1
if [ "$SHELL" == "" ]; then
  echo "need to specify shell to test"
  exit 1
fi

(while sleep 15; do pstree -a -c -p; done) &
for file in $(find . -iname 'test_*.shell') $(find . -iname 'test_*.'$SHELL); do
  export OTEL_TRACES_LOCATION=$(mktemp -u)
  export OTEL_SHELL_SDK_OUTPUT_REDIRECT=$OTEL_TRACES_LOCATION
  export OTEL_TRACES_CONSOLE_EXPORTER=TRUE
  touch $OTEL_TRACES_LOCATION
  echo "running $file"
  timeout 60 $SHELL -x $file && echo "SUCCEEDED" || (echo "FAILED" && cat $OTEL_TRACES_LOCATION  && exit 1)
done
echo "ALL TESTS SUCCESSFUL"
