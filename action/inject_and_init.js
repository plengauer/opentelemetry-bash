const fs = require('fs');
const { spawn } = require('child_process');
const core = require('@actions/core');
const github = require('@actions/github');

function run(executable, args = []) {
  return new Promise((resolve, reject) => {
    const process = spawn(executable, args);
    process.stdout.on('data', data => console.log(data));
    process.stderr.on('data', data => console.error(data));
    process.on('close', code => {
      if (code == 0) {
        resolve(code);
      } else {
        reject(code);
      }
    });
    process.on('error', (error) => reject(new Error(error)));
  });
}

try {
  await run('/bin/sh', ['-c', 'wget -O - https://raw.githubusercontent.com/plengauer/opentelemetry-bash/main/INSTALL.sh | sh -E']);
  await run('/usr/share/opentelemetry_shell/opentelemetry_shell.special.github.inject_and_init');
} catch (error) {
  core.setFailed(error.message);
}
