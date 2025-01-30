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
  "trace_id": "4feefc4a1f61e7cf1f7bdd75497e05a0",
  "span_id": "b78abd652c2da0b2",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "ERROR",
  "time_start": 1738246885760411262,
  "time_end": 1738247171744214141,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.0.0",
    "service.name": "unknown_service",
    "github.sha": "e8821158e9a597766f02ee3dbeb784ba4339138c",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/tags/v5.0.0",
    "github.event.ref.sha": "e8821158e9a597766f02ee3dbeb784ba4339138c",
    "github.event.ref.name": "v5.0.0",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "release",
    "github.workflow.run.id": "13054336283",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.0.0",
    "github.workflow.sha": "e8821158e9a597766f02ee3dbeb784ba4339138c",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": "",
    "process.pid": 7116,
    "process.parent_pid": 2141,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "bash -e demo.sh",
    "process.command": "bash",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "ehB"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "4feefc4a1f61e7cf1f7bdd75497e05a0",
  "span_id": "0c203ab6b04544dc",
  "parent_span_id": "b78abd652c2da0b2",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1738246885773046651,
  "time_end": 1738247171744058460,
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
    "telemetry.sdk.version": "5.0.0",
    "service.name": "unknown_service",
    "github.sha": "e8821158e9a597766f02ee3dbeb784ba4339138c",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/tags/v5.0.0",
    "github.event.ref.sha": "e8821158e9a597766f02ee3dbeb784ba4339138c",
    "github.event.ref.name": "v5.0.0",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "release",
    "github.workflow.run.id": "13054336283",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.0.0",
    "github.workflow.sha": "e8821158e9a597766f02ee3dbeb784ba4339138c",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": "",
    "process.pid": 7116,
    "process.parent_pid": 2141,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "bash -e demo.sh",
    "process.command": "bash",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "ehB"
  },
  "links": [],
  "events": []
}
```
