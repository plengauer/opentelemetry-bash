#!/bin/bash
set -e
export SHELL=$1
if [ "$SHELL" == "" ]; then
  echo "need to specify shell to test"
  exit 1
fi

export OTEL_TRACES_CONSOLE_EXPORTER=TRUE
for file in $(find . -iname 'test_*.shell') $(find . -iname 'test_*.'$SHELL); do
  echo "running $file"
  $SHELL $file || (echo "FAILED" && exit 1)
done
echo "ALL TESTS SUCCESSFUL"
