#!/bin/sh -e
if [ "$OTEL_SHELL_AUTO_INJECTED" = TRUE ]; then
  exec "$@"
else
  . otelapi.sh
  . /usr/share/opentelemetry_shell/opentelemetry_shell.custom.netcat.sh
  _otel_inject_netcat "$@"
fi
