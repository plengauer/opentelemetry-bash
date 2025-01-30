const process = require('process');
if (process.env['OTEL_SHELL_CONFIG_GITHUB_INJECT_ON_MAIN'] == 'TRUE') {
  // action is local and pre steps is not supported because the action needs to be checked out first and then its too let to execute a pre step
  require('./inject_and_init.js');
}
