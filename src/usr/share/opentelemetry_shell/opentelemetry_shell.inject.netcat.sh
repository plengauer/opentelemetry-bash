#!/bin/sh -e
if [ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ]; then
  exec "$@"
else
  export OTEL_SHELL_AUTO_INJECTED=TRUE
  . otel.sh
  \unalias -a
  _otel_inject_netcat "$@"
fi
