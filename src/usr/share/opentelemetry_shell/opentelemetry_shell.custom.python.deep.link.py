import os
from opentelemetry.context import attach
from opentelemetry.trace.propagation import tracecontext

traceparent = os.getenv("TRACEPARENT")
if traceparent:
    propagator = tracecontext.TraceContextTextMapPropagator()
    carrier = { "traceparent": traceparent }
    new_context = propagator.extract(carrier=carrier)
    attach(new_context)
