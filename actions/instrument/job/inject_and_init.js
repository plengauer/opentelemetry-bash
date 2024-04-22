const { spawn } = require('child_process');

function run(executable, args = []) {
  return new Promise((resolve, reject) => {
    const process = spawn(executable, args, { stdio: 'inherit' });
    process.on('close', code => code == 0 ? resolve(code) : reject(code));
    process.on('error', error => reject(new Error(error)));
  });
}

run('/bin/sh', [ '-c', 'wget -O - https://raw.githubusercontent.com/plengauer/opentelemetry-bash/main/INSTALL.sh | sh -E' ])
  .then(() => run('/bin/bash', [ '-e', __dirname + '/inject_and_init.bash' ]))
