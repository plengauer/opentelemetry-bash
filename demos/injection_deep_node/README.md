# Demo "Deep injection into a Node.js app"
This script uses a node.js app and configures opentelemetry to inject into the app and continue tracing.
## Script
```sh
export OTEL_SHELL_CONFIG_INJECT_DEEP=TRUE
. otel.sh
 node index.js
```
## Trace Structure Overview
```
bash -e demo.sh
  node index.js
    GET
```
## Full Trace
```
{
  "trace_id": "63545befff86ab2715da00b856875e58",
  "span_id": "6af859e73aee9ef8",
  "parent_span_id": "f420b368c0e966dc",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741804488466000000,
  "time_end": 1741804488595603875,
  "attributes": {
    "http.url": "https://example.com/",
    "http.method": "GET",
    "http.target": "/",
    "net.peer.name": "example.com",
    "http.host": "example.com:443",
    "net.peer.ip": "23.192.228.84",
    "net.peer.port": 443,
    "http.response_content_length_uncompressed": 1256,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "unknown_service:node",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.30.1",
    "vcs.system": "git",
    "vcs.commit.id": "11df64051f47a639cc24d8629239ed44b1e0a5c2",
    "github.workflow": "Refresh Demos",
    "github.run_id": "13818901372",
    "github.run_number": "34",
    "github.actor": "actions-bot-pl",
    "github.sha": "11df64051f47a639cc24d8629239ed44b1e0a5c2",
    "github.ref": "refs/tags/v5.8.2",
    "process.pid": 7848,
    "process.executable.name": "node",
    "process.executable.path": "/usr/local/bin/node",
    "process.command_args": [
      "/usr/local/bin/node",
      "--require",
      "/usr/share/opentelemetry_shell/agent.instrumentation.node.js",
      "--require",
      "/usr/share/opentelemetry_shell/agent.instrumentation.node.deep.instrument.js",
      "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js"
    ],
    "process.runtime.version": "20.18.3",
    "process.runtime.name": "nodejs",
    "process.runtime.description": "Node.js",
    "process.command": "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js",
    "process.owner": "runner"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "63545befff86ab2715da00b856875e58",
  "span_id": "630541775f367100",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1741804486962716928,
  "time_end": 1741804488615584000,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.8.2",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.8.2",
    "github.actions.workflow.sha": "11df64051f47a639cc24d8629239ed44b1e0a5c2",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 7082,
    "process.parent_pid": 2104,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "bash -e demo.sh",
    "process.command": "bash",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "ehB",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "63545befff86ab2715da00b856875e58",
  "span_id": "f420b368c0e966dc",
  "parent_span_id": "630541775f367100",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741804486975274496,
  "time_end": 1741804488615401216,
  "attributes": {
    "shell.command_line": "node index.js",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.8.2",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.8.2",
    "github.actions.workflow.sha": "11df64051f47a639cc24d8629239ed44b1e0a5c2",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 7082,
    "process.parent_pid": 2104,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "bash -e demo.sh",
    "process.command": "bash",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "ehB",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
```
