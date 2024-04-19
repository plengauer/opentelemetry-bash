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
  // download and install
  await run('/bin/sh', ['-c', 'wget -O - https://raw.githubusercontent.com/plengauer/opentelemetry-bash/main/INSTALL.sh | sh -E']);

  // inject
  const script_dir = '/home/runner/work/_temp';
  for (let file of fs.readdirSync(script_dir)) {
    if (!file.endsWith('.sh')) continue;
    let script = '' + fs.readFileSync(script_dir + '/' + file);
    script = '. otel.sh\n' + script;
    fs.writeFileSync(script_dir + '/' + file);
  }

  // init
  // start a process
  // init otel (and make a root span)
  // get the traceparent of the root span
  // make sure the process doesn die so i can find it again later in shutdown.js and end the span
  let traceparent = '';

  // setup env
  const env_dir = script_dir + '/_runner_file_commands';
  let env = {};
  env['OTEL_SERVICE_NAME'] = core.getInput('service-name');
  env['OTEL_TRACEPARENT'] = traceparent;
  for (let file of fs.readdirSync(env_dir)) {
    if (!file.startsWith('set_env_')) continue;
    for (let key in env) {
      let value = env[key];
      fs.appendFileSync(env_dir + '/' + file, '\n' + key + '=' + value);
    }
  }
  
  // const payload = JSON.stringify(github.context.payload, undefined, 2)
} catch (error) {
  core.setFailed(error.message);
}
