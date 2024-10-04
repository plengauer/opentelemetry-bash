import os
from opentelemetry.context import attach
from opentelemetry.trace.propagation import tracecontext

traceparent = os.getenv("TRACEPARENT")
if traceparent:
    propagator = tracecontext.TraceContextTextMapPropagator()
    carrier = { "traceparent": traceparent }
    new_context = propagator.extract(carrier=carrier)
    attach(new_context)

import subprocess
import functools

def inject_arguments(*args):
    return [ '/bin/sh', '-c', '. otel.sh\n' + args[0] + ' "$@"', 'python' ] + args[1:]

# TODO get current span and set traceparent and tracestate as env var
# TODO set additional env var like auto injection, ...

# def observed_subprocess_run(original_subprocess_run, *args, **kwargs):
#     if len(args) > 0:
#         args = inject_arguments(args)
#     return original_subprocess_run(*args, **kwargs)
# 
# def observed_subprocess_call(original_subprocess_call, *args, **kwargs):
#     if len(args) > 0:
#         args = inject_arguments(args)
#     return original_subprocess_call(*args, **kwargs)
# 
# def observed_subprocess_Popen___init__(original_subprocess_call, *args, **kwargs):
#     if len(args) > 0:
#         args = inject_arguments(args)
#     return observed_subprocess_Popen___init__(*args, **kwargs)
# 
# def instrument(observed_function, original_function):
#    # functools.update_wrapper(observed_function, original_function) # TODO why do we need this?
#    return functools.partial(observed_function, original_function)
# 
# subprocess.run = instrument(observed_subprocess_run, subprocess.run)
# subprocess.call = instrument(observed_subprocess_call, subprocess.call)
# subprocess.Popen.__init__ = instrument(observed_subprocess_Popen___init__, subprocess.Popen.__init__)
