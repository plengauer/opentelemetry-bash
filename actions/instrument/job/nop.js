const process = require('process');
if (process.env['GITHUB_REPOSITORY'] == process.env['GITHUB_ACTION_REPOSITORY']) {
  // action is local and pre steps is not supported because the action needs to be checked out first and then its too let to execute a pre step
  require('./inject_and_init.js');
}
