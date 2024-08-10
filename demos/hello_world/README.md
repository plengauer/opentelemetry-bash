# Demo "Hello world"
This is a script as easy as it gets, i.e., a simple hello world. It shows some very simple span with the default attributes.
## Script
```sh
. otel.sh
echo hello world
```
## Standard Out
```
hello world
```
## Standard Error
```
```
## Trace Overview
```
bash -e demo.sh
  echo hello world
```
## Full OTLP Data
```json
{
  "name": "echo hello world",
  "context": {
    "trace_id": "0x5fccc29e0f062e8f2aa861fafa43e386",
    "span_id": "0x126ffbfa176fa066",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xa04a4385d6361b91",
  "start_time": "2024-08-10T11:37:11.980301Z",
  "end_time": "2024-08-10T11:37:11.996097Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "echo hello world",
    "shell.command": "echo",
    "shell.command.type": "builtin",
    "shell.command.name": "echo",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 2
  },
  "events": [],
  "links": [],
  "resource": {
    "attributes": {
      "telemetry.sdk.language": "shell",
      "telemetry.sdk.name": "opentelemetry",
      "telemetry.sdk.version": "4.21.2",
      "service.name": "unknown_service",
      "github.sha": "279c050ba8dd9d06e482424fcef61f1a537e9a92",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "279c050ba8dd9d06e482424fcef61f1a537e9a92",
      "github.event.ref.name": "main",
      "github.event.actor.id": "100447901",
      "github.event.actor.name": "plengauer",
      "github.event.name": "push",
      "github.workflow.run.id": "10331005866",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
      "github.workflow.sha": "279c050ba8dd9d06e482424fcef61f1a537e9a92",
      "github.workflow.name": "Publish",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 2641,
      "process.parent_pid": 2628,
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
    "schema_url": ""
  }
}
{
  "name": "bash -e demo.sh",
  "context": {
    "trace_id": "0x5fccc29e0f062e8f2aa861fafa43e386",
    "span_id": "0xa04a4385d6361b91",
    "trace_state": "[]"
  },
  "kind": "SpanKind.SERVER",
  "parent_id": null,
  "start_time": "2024-08-10T11:37:11.967410Z",
  "end_time": "2024-08-10T11:37:11.996369Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {},
  "events": [],
  "links": [],
  "resource": {
    "attributes": {
      "telemetry.sdk.language": "shell",
      "telemetry.sdk.name": "opentelemetry",
      "telemetry.sdk.version": "4.21.2",
      "service.name": "unknown_service",
      "github.sha": "279c050ba8dd9d06e482424fcef61f1a537e9a92",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "279c050ba8dd9d06e482424fcef61f1a537e9a92",
      "github.event.ref.name": "main",
      "github.event.actor.id": "100447901",
      "github.event.actor.name": "plengauer",
      "github.event.name": "push",
      "github.workflow.run.id": "10331005866",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
      "github.workflow.sha": "279c050ba8dd9d06e482424fcef61f1a537e9a92",
      "github.workflow.name": "Publish",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 2641,
      "process.parent_pid": 2628,
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
    "schema_url": ""
  }
}
```
