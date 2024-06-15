const process = require('node:process');
const child_process = require('node:child_process');
const _spawn = child_process.spawn;
const _spawnSync = child_process.spawnSync;
const _exec = child_process.exec;
const _execSync = child_process.execSync;
const _execFile = child_process.execFile;
const _execFileSync = child_process.execFileSync;

if (process.platform != 'linux') return;

child_process.spawn = function(command, args, options) {
  return otel_spawn(command, args, options, _spawn);
}

child_process.spawnSync = function(command, args, options) {
  return otel_spawn(command, args, options, _spawnSync);
}

function otel_spawn(command, args, options, original) {
  if (args && !options && !Array.isArray(args)) {
    options = args;
    args = [];
  }
  if (options && options.stdio && Array.isArray(options.stdio) && options.stdio.length > 3) return _spawn(command, args, options);
  options = options ?? {};
  options.env = options.env ?? { ... process.env };
  if (command.includes('/')) {
    if (_execSync("which " + command) == command, options.shell && typeof options.shell == 'string' ? { shell: options.shell } : {}) {
      command = command.substring(command.lastIndexOf('/') + 1);
    } else {
      command = 'otel_observe ' + command;
    }
  }
  shell_propagator_inject(options.env);
  if (options.shell) {
    if (typeof options.shell == 'boolean') options.shell = '/bin/sh';
    options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE'] = options.shell + ' -c ' + command + ' ' + args.join(' ');
    options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE'] = process.pid;
    options.env['OTEL_SHELL_AUTO_INJECTED'] = 'FALSE'
    return original(options.shell, [ '-c', '. otel.sh\n' + command + ' "$@"', options.shell ].concat(args ?? []), { ... options, shell: false });
  } else {
    return original('/bin/sh', [ '-c', '. otel.sh\n' + command + ' "$@"', 'node' ].concat(args ?? []), options);
  }
}

child_process.exec = function(command, options, callback) {
  return otel_exec(command, options, callback, _exec);
}

child_process.execSync = function(command, options) {
  return otel_exec(command, options, undefined, _execSync);
}

function otel_exec(command, options, callback, original) {
  if (options && !callback && typeof options == 'function') {
    callback = options;
    options = {};
  }
  if (options && options.stdio && Array.isArray(options.stdio) && options.stdio.length > 3) return _exec(command, options, callback);
  if (command.trim().startsWith('/') || command.trim().startsWith('.')) {
    if (_execSync(options.shell ?? '/bin/sh' + " -c 'which \"$1\"' sh " + command) == command) {
      command = command.substring(command.lastIndexOf('/') + 1);
    } else {
      command = 'otel_observe ' + command;
    }
  }
  options = options ?? {};
  options.env = options.env ?? { ... process.env };
  shell_propagator_inject(options.env);
  options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE'] = (options.shell ?? '/bin/sh') + ' -c ' + command;
  options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE'] = process.pid;
  options.env['OTEL_SHELL_AUTO_INJECTED'] = 'FALSE'
  return original('. otel.sh\n' + command, options, callback);
}

/*
child_process.execFile = function(file, args, options, callback) {
  options = options ?? {};
  options.env = options.env ?? { ... process.env };
  return _execFile('/bin/sh', [ '-c', '. otel.sh\n' + file + ' "$@"', 'node' ].concat(args ?? []), options, callback);
}
*/

function shell_propagator_inject(env) {
  try {
    let opentelemetry_api = require('@opentelemetry/api');
    let opentelemetry_sdk = require('@opentelemetry/sdk-node');
    let carrier = {};
    new opentelemetry_sdk.core.W3CTraceContextPropagator().inject(opentelemetry_api.context.active(), carrier, opentelemetry_api.defaultTextMapSetter);
    env.TRACEPARENT = carrier.traceparent ?? process.env.TRACEPARENT ?? '';
    env.TRACESTATE = carrier.tracestate ?? process.env.TRACESTATE ?? '';
  } catch (err) {
    if (err.code != 'MODULE_NOT_FOUND') {
      throw err;
    }
    env.TRACEPARENT = process.env.TRACEPARENT ?? '';
    env.TRACESTATE = process.env.TRACESTATE ?? '';      
  }
}

