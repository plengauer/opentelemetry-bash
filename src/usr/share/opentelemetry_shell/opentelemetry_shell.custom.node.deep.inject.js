const opentelemetry_api = require('@opentelemetry/api');
opentelemetry_api.trace.setSpanContext(opentelemetry_api.context.active(), opentelemetry_api.propagation.extract(opentelemetry_api.context.active(), { traceparent: process.env.OTEL_TRACEPARENT }));
