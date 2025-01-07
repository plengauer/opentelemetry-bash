import opentelemetry
from opentelemetry.context import attach
from opentelemetry.trace.propagation import tracecontext

traceparent = os.getenv("TRACEPARENT")
if traceparent:
    propagator = tracecontext.TraceContextTextMapPropagator()
    carrier = { "traceparent": traceparent }
    new_context = propagator.extract(carrier=carrier)
    attach(new_context)

import os
import functools

def inject_file(file):
  return '/bin/sh'

def inject_arguments(file, args):
  return [ args[0], '-c', '. otel.sh\n' + file + ' "$@"', 'python' ] + args[1:]

def inject_env(env):
    if not env:
        env = os.environ.copy()
    carrier = {}
    tracecontext.TraceContextTextMapPropagator().inject(carrier, opentelemetry.trace.set_span_in_context(opentelemetry.trace.get_current_span(), None))
    if 'traceparent' in carrier:
      env["OTEL_TRACEPARENT"] = carrier['traceparent']
    if 'tracestate' in carrier:
      env["OTEL_TRACESTATE"] = carrier['tracestate']
    return env;

def observed_os_execvp(original_os_execvpe, file, args):
    print('EXECVP: ' + file + ' ' + ','.join(args), file=sys.stderr);
    return original_os_execvpe(inject_file(file), inject_arguments(file, args), inject_env(None))

def observed_os_execvpe(original_os_execvpe, file, args, env):
    print('EXECVPE: ' + file + ' ' + ','.join(args), file=sys.stderr);
    return original_os_execvpe(inject_file(file), inject_arguments(file, args), inject_env(env))

def instrument(observed_function, original_function):
   return functools.partial(observed_function, original_function)

os.execvp = instrument(observed_os_execvp, os.execvpe)
os.execvpe = instrument(observed_os_execvpe, os.execvpe)
