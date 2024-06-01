const opentelemetry_api = require('@opentelemetry/api');

let span_context = opentelemetry_api.propagation.extract(opentelemetry_api.trace.ROOT_CONTEXT, { traceparent: process.env.OTEL_TRACEPARENT });
let context = opentelemetry_api.trace.setSpan(opentelemetry_api.trace.ROOT_CONTEXT, opentelemetry_api.trace.wrapSpanContext(span_context.span));
opentelemetry_api.trace.context.setGlobalContextManager({
  active() {
    return context;
  },
});
