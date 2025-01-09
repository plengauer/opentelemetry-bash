import sys
import os
import subprocess

try:
    import opentelemetry
    from opentelemetry.context import attach
    from opentelemetry.trace.propagation import tracecontext
    
    traceparent = os.getenv("TRACEPARENT")
    if traceparent:
        propagator = tracecontext.TraceContextTextMapPropagator()
        carrier = { "traceparent": traceparent }
        new_context = propagator.extract(carrier=carrier)
        attach(new_context)
    
    def inject_env(env):
        if not env:
            env = os.environ.copy()
        carrier = {}
        tracecontext.TraceContextTextMapPropagator().inject(carrier, opentelemetry.trace.set_span_in_context(opentelemetry.trace.get_current_span(), None))
        if 'traceparent' in carrier:
            env["OTEL_TRACEPARENT"] = carrier["traceparent"]
        if 'tracestate' in carrier:
            env["OTEL_TRACESTATE"] = carrier["tracestate"]
        return env;
        
except ModuleNotFoundError:
    def inject_env(env):
        if not env:
            env = os.environ.copy()
        return env

import functools

def inject_file(file):
    return '/bin/sh'

def inject_arguments(file, args):
    try:
        file = file.decode()
    except (UnicodeDecodeError, AttributeError):
        pass
    if not '/' in file:
        file = './' + file
    if not os.path.exists(file) or not os.path.isfile(file) or not os.access(file, os.X_OK):
        raise FileNotFoundError(file) # python will just trial and error all possible paths if the 'p' variants of exec are used
    if type(args) is tuple:
        args = list(args)
    return [ args[0], '-c', '. otel.sh\n_otel_inject "' + str(file) + '" "$@"', 'python' ] + args[1:]

def observed_os_execv(original_os_execve, file, args):
    return original_os_execve(inject_file(file), inject_arguments(file, args), inject_env(None))

def observed_os_execve(original_os_execve, file, args, env):
    return original_os_execve(inject_file(file), inject_arguments(file, args), inject_env(env))

def observed_subprocess_Popen___init__(original_subprocess_Popen___init__, self, **kwargs):
    print('subprocess.Popen(' + str(kwargs) + ')', file=sys.stderr)
    print('subprocess.Popen(' + str(args) + ', ' + str(kwargs) + ')', file=sys.stderr)
    args = list(args)
    # TODO handle shell
    print('subprocess.Popen([' + ','.join(args) + '], ' + str(kwargs) + ')', file=sys.stderr)
    kwargs['env'] = inject_env(kwargs.get('env', None))
    args = ([ inject_file(args[0]) ] + inject_arguments(args[0], args[1:]))
    print('subprocess.Popen([' + ','.join(args) + '], ' + str(kwargs) + ')', file=sys.stderr)
    return original_subprocess_Popen___init__(self, args, **kwargs);

def instrument(observed_function, original_function):
    return functools.partial(observed_function, original_function)

os.execv = instrument(observed_os_execv, os.execve)
os.execve = instrument(observed_os_execve, os.execve)
subprocess.Popen.__init__ = instrument(observed_subprocess_Popen___init__, subprocess.Popen.__init__);
