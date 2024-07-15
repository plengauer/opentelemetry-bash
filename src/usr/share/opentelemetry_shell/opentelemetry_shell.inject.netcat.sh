#!/bin/sh -e
set -x # TODO remove
if [ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ]; then
  exec "$@"
else
  export OTEL_SHELL_AUTO_INJECTED=TRUE
  . otel.sh
  \unalias -a
  _otel_inject_netcat "$@"
fi
