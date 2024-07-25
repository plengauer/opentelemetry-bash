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
    "trace_id": "0xcdc4ae27bf7a694cf30c4181407fc178",
    "span_id": "0xec7c8ef4f967b0af",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x01156a5614ae0e82",
  "start_time": "2024-07-25T20:07:46.917676Z",
  "end_time": "2024-07-25T20:07:46.935266Z",
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
      "telemetry.sdk.version": "4.18.0",
      "service.name": "unknown_service",
      "github.sha": "6670336b0d4c133b1f1829da3e925610bfdf5aa1",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "6670336b0d4c133b1f1829da3e925610bfdf5aa1",
      "github.event.ref.name": "main",
      "github.event.actor.id": "100447901",
      "github.event.actor.name": "plengauer",
      "github.event.name": "push",
      "github.workflow.run.id": "10100743414",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
      "github.workflow.sha": "6670336b0d4c133b1f1829da3e925610bfdf5aa1",
      "github.workflow.name": "Demo",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 1960,
      "process.parent_pid": 1947,
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
    "trace_id": "0xcdc4ae27bf7a694cf30c4181407fc178",
    "span_id": "0x01156a5614ae0e82",
    "trace_state": "[]"
  },
  "kind": "SpanKind.SERVER",
  "parent_id": null,
  "start_time": "2024-07-25T20:07:46.903392Z",
  "end_time": "2024-07-25T20:07:46.935666Z",
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
      "telemetry.sdk.version": "4.18.0",
      "service.name": "unknown_service",
      "github.sha": "6670336b0d4c133b1f1829da3e925610bfdf5aa1",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "6670336b0d4c133b1f1829da3e925610bfdf5aa1",
      "github.event.ref.name": "main",
      "github.event.actor.id": "100447901",
      "github.event.actor.name": "plengauer",
      "github.event.name": "push",
      "github.workflow.run.id": "10100743414",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
      "github.workflow.sha": "6670336b0d4c133b1f1829da3e925610bfdf5aa1",
      "github.workflow.name": "Demo",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 1960,
      "process.parent_pid": 1947,
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
