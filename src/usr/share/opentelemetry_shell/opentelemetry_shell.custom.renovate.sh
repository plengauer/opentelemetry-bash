#!/bin/false

# renovate => OTEL_...=... renovate

_otel_configure_renovate() {
  # renovate looks at some very specific env vars to enable tracing
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
  if \[ "$1" = /bin/bash ] && \[ /bin/bash = "$(\which bash)" ]; then
    shift
    bash "$@"
  else
    _otel_call "$@"
  fi
}

_otel_alias_prepend renovate _otel_configure_renovate
