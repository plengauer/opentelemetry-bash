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
  "trace_id": "0205b0a0cdc044ad6f11ea574bf6cd43",
  "span_id": "bf34182984aebb2f",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1730634741144395500,
  "time_end": 1730634742636377900,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 5308,
    "process.parent_pid": 2620,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "bash -e demo.sh",
    "process.command": "bash",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.1-6ubuntu1.1",
    "process.runtime.options": "ehB",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "0205b0a0cdc044ad6f11ea574bf6cd43",
  "span_id": "f0f5e8e750395a4e",
  "parent_span_id": "bf34182984aebb2f",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634741157400300,
  "time_end": 1730634742636248600,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 5308,
    "process.parent_pid": 2620,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "bash -e demo.sh",
    "process.command": "bash",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.1-6ubuntu1.1",
    "process.runtime.options": "ehB",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "0205b0a0cdc044ad6f11ea574bf6cd43",
  "span_id": "442a2fc64a5a8003",
  "parent_span_id": "f0f5e8e750395a4e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634742386000000,
  "time_end": 1730634742432934000,
  "attributes": {
    "http.url": "https://example.com/",
    "http.method": "GET",
    "http.target": "/",
    "net.peer.name": "example.com",
    "http.host": "example.com:443",
    "net.peer.ip": "93.184.215.14",
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
    "telemetry.sdk.version": "1.27.0",
    "vcs.system": "git",
    "vcs.commit.id": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "vcs.branch.name": "main",
    "github.workflow": "Publish",
    "github.run_id": "11650349700",
    "github.run_number": "67",
    "github.actor": "actions-bot-pl",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.ref": "refs/heads/main",
    "process.pid": 6074,
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
    "process.runtime.version": "18.20.4",
    "process.runtime.name": "nodejs",
    "process.runtime.description": "Node.js",
    "process.command": "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js",
    "process.owner": "runner"
  },
  "links": [],
  "events": []
}
```
