#!/bin/false

if \[ "$(_otel_command_self)" = '/bin/bash /usr/local/bin/renovate' ]; then # renovate looks at some very specific env vars to enable tracing
  if _otel_string_contains "$OTEL_TRACES_EXPORTER" console; then export RENOVATE_TRACING_CONSOLE_EXPORTER=true; fi
  if \[ -z "$OTEL_EXPORTER_OTLP_ENDPOINT" ] && ( _otel_string_contains "$OTEL_TRACES_EXPORTER" otlp || \[ -z "$OTEL_TRACES_EXPORTER" ] ); then
    if \[ -n "$OTEL_EXPORTER_OTLP_TRACES_ENDPOINT" ]; then
      if _otel_string_ends_with "$OTEL_EXPORTER_OTLP_TRACES_ENDPOINT" /v1/traces; then
        export OTEL_EXPORTER_OTLP_ENDPOINT="${OTEL_EXPORTER_OTLP_TRACES_ENDPOINT%/v1/traces}"
      fi
    else
      export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318
    fi
  fi
  set -x
fi
