const opentelemetry_api = require('@opentelemetry/api');

let span_context = opentelemetry_api.propagation.extract(opentelemetry_api.trace.ROOT_CONTEXT, { traceparent: process.env.OTEL_TRACEPARENT });
console.error('DEBUG DEBUG DEBUG span context: ' + span_context);
let context = opentelemetry_api.trace.setSpan(opentelemetry_api.trace.ROOT_CONTEXT, opentelemetry_api.trace.wrapSpanContext(span_context.span));
console.error('DEBUG DEBUG DEBUG context: ' + context);
opentelemetry_api.trace.context.setGlobalContextManager({
  active() {
    console.error('DEBUG DEBUG DEBUG context accessed');
    return context;
  },
});
