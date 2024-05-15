const process = require('node:process');
const child_process = require('node:child_process');
const _spawn = child_process.spawn;
const _exec = child_process.exec;
const _execFile = child_process.execFile;

if (process.platform != 'linux') return;

child_process.spawn = function(command, args, options) {
  if (args && !options && !Array.isArray(args)) {
    options = args;
    args = [];
  }
  options = options ?? {};
  options.env = options.env ?? { ... process.env };
  options.env['OTEL_SHELL_AUTO_INSTRUMENTATION_HINT'] = command + ' ';
  if (command.includes('/')) command = 'otel_observe ' + command;
  if (options.shell) {
    if (typeof options.shell == 'boolean') options.shell = '/bin/sh';
    options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE'] = options.shell + ' -c ' + command + ' ' + args.join(' ');
    options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE'] = process.pid;
    options.env['OTEL_SHELL_AUTO_INJECTED'] = 'FALSE'
    return _spawn(options.shell, [ '-c', '. otel.sh\n' + command + ' "$@"', options.shell ].concat(args ?? []), { ... options, shell: false });
  } else {
    return _spawn('/bin/sh', [ '-c', '. otel.sh\n' + command + ' "$@"', 'node' ].concat(args ?? []), options);
  }
}

child_process.exec = function(command, options, callback) {
  if (options && !callback && typeof options == 'function') {
    callback = options;
    options = {};
  }
  if (command.includes('/')) command = 'otel_observe ' + command;
  options = options ?? {};
  options.env = options.env ?? { ... process.env };
  options.env['OTEL_SHELL_AUTO_INSTRUMENTATION_HINT'] = command + ' ';
  options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE'] = (options.shell ?? '/bin/sh') + ' -c ' + command;
  options.env['OTEL_SHELL_COMMANDLINE_OVERRIDE_SIGNATURE'] = process.pid;
  options.env['OTEL_SHELL_AUTO_INJECTED'] = 'FALSE'
  return _exec('. otel.sh\n' + command, options, callback);
}

/*
child_process.execFile = function(file, args, options, callback) {
  options = options ?? {};
  options.env = options.env ?? { ... process.env };
  options.env['OTEL_SHELL_AUTO_INSTRUMENTATION_HINT'] = file;
  return _execFile('/bin/sh', [ '-c', '. otel.sh\n' + file + ' "$@"', 'node' ].concat(args ?? []), options, callback);
}
*/
