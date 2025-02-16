#/bin/sh -e
set -e
[ "${OTEL_LOGS_EXPORTER:-otlp}" = otlp ] && [ "${OTEL_METRICS_EXPORTER:-otlp}" = otlp ] && [ "${OTEL_TRCES_EXPORTER:-otlp}" = otlp ] || (echo "::error ::OpenTelemetry for GitHub actions only supports otlp exporters. For other exporters, pipe the data through a collector outside of GitHub to translate the data to a different protocol." && false)
[ -n "${OTEL_EXPORTER_OTLP_LOGS_ENDPOINT:-$OTEL_EXPORTER_OTLP_ENDPOINT}" ] && [ -n "${OTEL_EXPORTER_OTLP_METRICS_ENDPOINT:-$OTEL_EXPORTER_OTLP_ENDPOINT}" ] && [ -n "${OTEL_EXPORTER_OTLP_TRACES_ENDPOINT:-$OTEL_EXPORTER_OTLP_ENDPOINT}" ] || (echo "::error ::OpenTelemetry for GitHub actions need a configured endpoint to send data to." && false)
