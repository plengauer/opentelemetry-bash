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
    
    def inject_env(env, args):
        if not env:
            env = os.environ.copy()
        env['OTEL_SHELL_AUTO_INSTRUMENTATION_HINT'] = ' '.join(args)
        carrier = {}
        tracecontext.TraceContextTextMapPropagator().inject(carrier, opentelemetry.trace.set_span_in_context(opentelemetry.trace.get_current_span(), None))
        if 'traceparent' in carrier:
            env["OTEL_TRACEPARENT"] = carrier["traceparent"]
        if 'tracestate' in carrier:
            env["OTEL_TRACESTATE"] = carrier["tracestate"]
        return env;
        
except ModuleNotFoundError:
    def inject_env(env, args):
        if not env:
            env = os.environ.copy()
        env['OTEL_SHELL_AUTO_INSTRUMENTATION_HINT'] = ' '.join(args)
        return env

import functools

def inject_file(file):
    return '/bin/sh'

def inject_arguments(file, args, is_file=True):
    try:
        file = file.decode()
    except (UnicodeDecodeError, AttributeError):
        pass
    arg_zero = None
    if is_file:
        if not '/' in file:
            file = './' + file
        if not os.path.exists(file) or not os.path.isfile(file) or not os.access(file, os.X_OK):
            raise FileNotFoundError(file) # python will just trial and error all possible paths if the 'p' variants of exec are used
        arg_zero = file;
        file = "_otel_inject '" + file + "'"
    else:
        arg_zero = 'python'
    return [ '-c', '. otel.sh\n' + file + ' "$@"', arg_zero ] + args

original_os_execve = os.execve
original_subprocess_Popen___init__ = subprocess.Popen.__init__

def observed_os_execv(file, args):
    if type(args) is tuple:
        args = list(args)
    args = [ args[0] ] + inject_arguments(file, args[1:])
    file = inject_file(file)
    env = inject_env(None, args)
    return original_os_execve(file, args, env)

def observed_os_execve(file, args, env):
    if type(args) is tuple:
        args = list(args)
    args = [ args[0] ] + inject_arguments(file, args[1:])
    file = inject_file(file)
    env = inject_env(env, args)
    return original_os_execve(file, args, env)

def observed_subprocess_Popen___init__(self, *args, **kwargs):
    args = list(args)
    if len(args) > 0 and type(args[0]) is list:
        args = args[0]
    if len(args) > 0 and type(args[0]) is tuple:
        args = list(args[0])
    print('subprocess.Popen([' + ','.join(args) + '],' + str(kwargs) + ')', file=sys.stderr)
    args = ([ inject_file(kwargs.get('executable', args[0])) ] + inject_arguments(kwargs.get('executable', args[0]), args[1:], not kwargs.get('shell', False)))
    if kwargs.get('executable'):
        kwargs['executable'] = inject_file(kwargs['executable'])
    kwargs['env'] = inject_env(kwargs.get('env', None), args)
    if kwargs.get('shell', False):
        kwargs['env']['OTEL_SHELL_COMMANDLINE_OVERRIDE'] = '/bin/sh -c ' + ' '.join(args)
        kwargs['env']['OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE'] = str(os.getpid())
        kwargs['env']['OTEL_SHELL_AUTO_INJECTED'] = 'FALSE'
        kwargs['shell'] = False
    print('subprocess.Popen([' + ','.join(args) + '],' + str(kwargs) + ')', file=sys.stderr)    
    kwargs['stderr'] = sys.stderr    
    return original_subprocess_Popen___init__(self, args, **kwargs);

os.execv = observed_os_execv
os.execve = observed_os_execve
subprocess.Popen.__init__ = observed_subprocess_Popen___init__
