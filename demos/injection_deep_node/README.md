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
  "trace_id": "773becb004967526cc000d4d759378c6",
  "span_id": "12bbb2f515a9e019",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "ERROR",
  "time_start": 1738449014582776705,
  "time_end": 1738449298142951172,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.0.2",
    "service.name": "unknown_service",
    "github.sha": "6e2d1aacf36331dbea5e9b5498087c6b261ed6df",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/tags/v5.0.2",
    "github.event.ref.sha": "6e2d1aacf36331dbea5e9b5498087c6b261ed6df",
    "github.event.ref.name": "v5.0.2",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "release",
    "github.workflow.run.id": "13092351190",
    "github.workflow.run.attempt": "4",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.0.2",
    "github.workflow.sha": "6e2d1aacf36331dbea5e9b5498087c6b261ed6df",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 7143,
    "process.parent_pid": 2159,
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
  "trace_id": "773becb004967526cc000d4d759378c6",
  "span_id": "333138c158e3eaee",
  "parent_span_id": "12bbb2f515a9e019",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1738449014596077532,
  "time_end": 1738449298142785181,
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
    "telemetry.sdk.version": "5.0.2",
    "service.name": "unknown_service",
    "github.sha": "6e2d1aacf36331dbea5e9b5498087c6b261ed6df",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/tags/v5.0.2",
    "github.event.ref.sha": "6e2d1aacf36331dbea5e9b5498087c6b261ed6df",
    "github.event.ref.name": "v5.0.2",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "release",
    "github.workflow.run.id": "13092351190",
    "github.workflow.run.attempt": "4",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.0.2",
    "github.workflow.sha": "6e2d1aacf36331dbea5e9b5498087c6b261ed6df",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 7143,
    "process.parent_pid": 2159,
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
