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
    "trace_id": "0x90079ba9770a511647619cfdb22e1880",
    "span_id": "0xfe3a78c34b91c68f",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xc29077249d98bf65",
  "start_time": "2024-08-09T21:10:31.752049Z",
  "end_time": "2024-08-09T21:10:31.767892Z",
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
      "telemetry.sdk.version": "4.21.1",
      "service.name": "unknown_service",
      "github.sha": "f5a57e3677a8b6bec93fcfe31c194c7584e097eb",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "f5a57e3677a8b6bec93fcfe31c194c7584e097eb",
      "github.event.ref.name": "main",
      "github.event.actor.id": "170979611",
      "github.event.actor.name": "actions-bot-pl",
      "github.event.name": "push",
      "github.workflow.run.id": "10325431054",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
      "github.workflow.sha": "f5a57e3677a8b6bec93fcfe31c194c7584e097eb",
      "github.workflow.name": "Publish",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 2692,
      "process.parent_pid": 2679,
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
    "trace_id": "0x90079ba9770a511647619cfdb22e1880",
    "span_id": "0xc29077249d98bf65",
    "trace_state": "[]"
  },
  "kind": "SpanKind.SERVER",
  "parent_id": null,
  "start_time": "2024-08-09T21:10:31.739159Z",
  "end_time": "2024-08-09T21:10:31.768295Z",
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
      "telemetry.sdk.version": "4.21.1",
      "service.name": "unknown_service",
      "github.sha": "f5a57e3677a8b6bec93fcfe31c194c7584e097eb",
      "github.repository.id": "692042935",
      "github.repository.name": "plengauer/opentelemetry-bash",
      "github.repository.owner.id": "100447901",
      "github.repository.owner.name": "plengauer",
      "github.event.ref": "refs/heads/main",
      "github.event.ref.sha": "f5a57e3677a8b6bec93fcfe31c194c7584e097eb",
      "github.event.ref.name": "main",
      "github.event.actor.id": "170979611",
      "github.event.actor.name": "actions-bot-pl",
      "github.event.name": "push",
      "github.workflow.run.id": "10325431054",
      "github.workflow.run.attempt": "1",
      "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
      "github.workflow.sha": "f5a57e3677a8b6bec93fcfe31c194c7584e097eb",
      "github.workflow.name": "Publish",
      "github.job.name": "demo-generate",
      "github.step.name": "",
      "github.action.name": "demo",
      "process.pid": 2692,
      "process.parent_pid": 2679,
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
