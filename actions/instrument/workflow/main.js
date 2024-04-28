const { spawn } = require('child_process');

function run(executable, args = []) {
  return new Promise((resolve, reject) => {
    const process = spawn(executable, args,  { cwd: __dirname, stdio: 'inherit' });
    process.on('close', code => code == 0 ? resolve(code) : reject(code));
    process.on('error', error => reject(new Error(error)));
  });
}

run('/bin/sh', [ '-e', __dirname + '/main.sh' ])
