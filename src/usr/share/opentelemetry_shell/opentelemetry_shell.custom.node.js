const child_process = require('node:child_process');
const _spawn = child_process.spawn;
const _exec = child_process.exec;
const _execFile = child_process.execFile;

child_process.spawn = function(command, args, options) {
  args = args ?? [];
  args = [ '-e', '-c', '. otel.sh\n' + command + ' "$@"', 'node', ...args];
  return _spawn('/bin/sh', args, options);
}

child_process.exec = function(command, options, callback) {
  return _exec('. otel.sh\n' + command, options, callback);
}

child_process.execFile = function(file, args, options, callback) {
  args = args ?? [];
  args = [ '-e', '-c', '. otel.sh\n' + file + ' "$@"', 'node', ...args];
  return execFile('/bin/sh', args, options, callback);
}
