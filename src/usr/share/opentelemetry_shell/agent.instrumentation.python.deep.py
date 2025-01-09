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

def inject_arguments(file, args, is_file=True):
    try:
        file = file.decode()
    except (UnicodeDecodeError, AttributeError):
        pass
    if is_file:
        if not '/' in file:
            file = './' + file
        if not os.path.exists(file) or not os.path.isfile(file) or not os.access(file, os.X_OK):
            raise FileNotFoundError(file) # python will just trial and error all possible paths if the 'p' variants of exec are used
        file = '_otel_inject "' + file + "'"
    return [ '-c', '. otel.sh\n' + file + ' "$@"', 'python' ] + args

original_os_execve = os.execve
original_subprocess_Popen___init__ = subprocess.Popen.__init__

def observed_os_execv(file, args):
    if type(args) is tuple:
        args = list(args)
    return original_os_execve(inject_file(file), [ args[0] ] + inject_arguments(file, args[1:]), inject_env(None))

def observed_os_execve(file, args, env):
    if type(args) is tuple:
        args = list(args)
    return original_os_execve(inject_file(file), [ args[0] ] + inject_arguments(file, args[1:]), inject_env(env))

def observed_subprocess_Popen___init__(self, *args, **kwargs):
    args = list(args)
    if len(args) > 0 and type(args[0]) is list:
        args = args[0]
    print('subprocess.Popen([' + ','.join(args) + '], ' + str(kwargs) + ')', file=sys.stderr)
    args = ([ inject_file(args[0]) ] + inject_arguments(args[0], args[1:], kwargs.get('shell', False)))
    kwargs['env'] = inject_env(kwargs.get('env', None))
    kwargs['shell'] = False # TODO commandline override and no auto injection like node
    print('subprocess.Popen([' + ','.join(args) + '], ' + str(kwargs) + ')', file=sys.stderr)
    return original_subprocess_Popen___init__(self, args, **kwargs);

os.execv = observed_os_execv
os.execve = observed_os_execve
subprocess.Popen.__init__ = observed_subprocess_Popen___init__
