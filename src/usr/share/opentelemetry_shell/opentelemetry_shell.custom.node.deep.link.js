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

const MY_ROOT_CONTEXT = new opentelemetry_sdk.core.W3CTraceContextPropagator().extract(opentelemetry_api.ROOT_CONTEXT, { traceparent: process.env.OTEL_TRACEPARENT }, opentelemetry_api.defaultTextMapGetter);
const context_manager = new CustomRootContextManager(semver.gte(process.version, '14.8.0') ? new context_async_hooks.AsyncLocalStorageContextManager() : new context_async_hooks.AsyncHooksContextManager(), MY_ROOT_CONTEXT);
opentelemetry_api.context.setGlobalContextManager(context_manager.enable());

//_setGlobalContextManager = opentelemetry_api.context.setGlobalContextManager;
//opentelemetry_api.context.setGlobalContextManager = function(context_manager) {
//  return __setGlobalContextManager(new CustomRootContextManager(context_manager, MY_ROOT_CONTEXT));
//}
