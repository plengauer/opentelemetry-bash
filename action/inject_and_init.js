const fs = require('fs');
const core = require('@actions/core');
const github = require('@actions/github');

// - uses: plengauer/opentelemetry-bash/inject.yaml
try {
  // download and install
  // TODO

  // inject
  const script_dir = '/home/runner/work/_temp';
  for (let file of fs.readdirSync(script_dir)) {
    if (!file.endsWith('.sh')) continue;
    let script = '' + fs.readFileSync(script_dir + '/' + file);
    script = '. otel.sh\n' + script;
    fs.writeFileSync(script_dir + '/' + file);
  }

  // init
  let traceparent = ''; // TODO

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
