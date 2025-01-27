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
```
## Full Trace
```
{
  "trace_id": "b2078813f14aac000faf10bdc8a253de",
  "span_id": "6e754ba6c2e36e5b",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "ERROR",
  "time_start": 1737972545773408489,
  "time_end": 1737972832329912593,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.48.0",
    "service.name": "unknown_service",
    "github.sha": "0c07c3b71cd7ff2097dac82a4476769e1fd0f31b",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/tags/v4.48.0",
    "github.event.ref.sha": "0c07c3b71cd7ff2097dac82a4476769e1fd0f31b",
    "github.event.ref.name": "v4.48.0",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "release",
    "github.workflow.run.id": "12986540126",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v4.48.0",
    "github.workflow.sha": "0c07c3b71cd7ff2097dac82a4476769e1fd0f31b",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 7220,
    "process.parent_pid": 2188,
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
  "trace_id": "b2078813f14aac000faf10bdc8a253de",
  "span_id": "574155854b398acd",
  "parent_span_id": "6e754ba6c2e36e5b",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1737972545786526127,
  "time_end": 1737972832329724731,
  "attributes": {
    "shell.command_line": "node index.js",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 1,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.48.0",
    "service.name": "unknown_service",
    "github.sha": "0c07c3b71cd7ff2097dac82a4476769e1fd0f31b",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/tags/v4.48.0",
    "github.event.ref.sha": "0c07c3b71cd7ff2097dac82a4476769e1fd0f31b",
    "github.event.ref.name": "v4.48.0",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "release",
    "github.workflow.run.id": "12986540126",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v4.48.0",
    "github.workflow.sha": "0c07c3b71cd7ff2097dac82a4476769e1fd0f31b",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 7220,
    "process.parent_pid": 2188,
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
