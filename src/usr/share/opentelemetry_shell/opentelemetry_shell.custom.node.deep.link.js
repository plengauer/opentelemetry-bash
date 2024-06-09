const opentelemetry_api = require('@opentelemetry/api');
const opentelemetry_sdk = require('@opentelemetry/sdk-node');
const context_async_hooks = require("@opentelemetry/context-async-hooks");
const semver = require("semver");

class CustomRootContextManager {
  inner;
  custom_context;

  constructor(inner, custom_context) {
    this.inner = inner;
    this.custom_context = custom_context;
  }

  enable() { this.inner.enable(); return this; }
  disable() { this.inner.disable(); return this; }
  bind(...args) { return this.inner.bind(...args); }
  with(...args) { return this.inner.with(...args); }

  active() {
    let context = this.inner.active();
    if (opentelemetry_api.ROOT_CONTEXT == context || !opentelemetry_api.trace.getSpan(context)) {
      context = this.custom_context;
    }
    return context;
  }
}

const _setGlobalContextManager = opentelemetry_api.context.setGlobalContextManager;
opentelemetry_api.context.setGlobalContextManager = function(context_manager) {
  const MY_ROOT_CONTEXT = new opentelemetry_sdk.core.W3CTraceContextPropagator().extract(opentelemetry_api.ROOT_CONTEXT, { traceparent: process.env.TRACEPARENT, tracestate: process.env.TRACESTATE }, opentelemetry_api.defaultTextMapGetter);
  return _setGlobalContextManager(new CustomRootContextManager(context_manager, MY_ROOT_CONTEXT));
}
