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
    "trace_id": "0x1994ab3e55a1fbb13fbcf4bac89ed24d",
    "span_id": "0x801be58542b75a37",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xa3da28c6324b0a00",
  "start_time": "2024-08-05T08:43:37.526051Z",
  "end_time": "2024-08-05T08:43:37.543854Z",
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
      "telemetry.sdk.version": "4.20.0",
      "service.name": "unknown_service",
      "github.sha": "5c31c501e17f63e2d38e2744ff362f83f84bf62e",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "5c31c501e17f63e2d38e2744ff362f83f84bf62e",
      "github.event.ref.name": "main",
      "github.event.actor.id": "170979611",
      "github.event.actor.name": "actions-bot-pl",
      "github.event.name": "push",
      "github.workflow.run.id": "10243549196",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
      "github.workflow.sha": "5c31c501e17f63e2d38e2744ff362f83f84bf62e",
      "github.workflow.name": "Publish",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 2698,
      "process.parent_pid": 2685,
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
    "trace_id": "0x1994ab3e55a1fbb13fbcf4bac89ed24d",
    "span_id": "0xa3da28c6324b0a00",
    "trace_state": "[]"
  },
  "kind": "SpanKind.SERVER",
  "parent_id": null,
  "start_time": "2024-08-05T08:43:37.513174Z",
  "end_time": "2024-08-05T08:43:37.544188Z",
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
      "telemetry.sdk.version": "4.20.0",
      "service.name": "unknown_service",
      "github.sha": "5c31c501e17f63e2d38e2744ff362f83f84bf62e",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "5c31c501e17f63e2d38e2744ff362f83f84bf62e",
      "github.event.ref.name": "main",
      "github.event.actor.id": "170979611",
      "github.event.actor.name": "actions-bot-pl",
      "github.event.name": "push",
      "github.workflow.run.id": "10243549196",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
      "github.workflow.sha": "5c31c501e17f63e2d38e2744ff362f83f84bf62e",
      "github.workflow.name": "Publish",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 2698,
      "process.parent_pid": 2685,
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
