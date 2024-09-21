# Demo "Hello world"
This is a script as easy as it gets, i.e., a simple hello world. It shows some very simple span with the default attributes.
## Script
```sh
. otel.sh
echo hello world
```
## Trace Structure Overview
```
bash -e demo.sh
  echo hello world
```
## Full Trace
```
{
  "trace_id": "f1ed0fbc30719346ac1209cb8a58357d",
  "span_id": "4f1cef2e0471ba27",
  "parent_span_id": "44c034b2af229e55",
  "name": "echo hello world",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726907557354781200,
  "time_end": 1726907557369967900,
  "attributes": {
    "shell.command_line": "echo hello world",
    "shell.command": "echo",
    "shell.command.type": "builtin",
    "shell.command.name": "echo",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 2
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.30.0",
    "service.name": "unknown_service",
    "github.sha": "07a673a0bff35301971c4f7b43eb44f67a188199",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "07a673a0bff35301971c4f7b43eb44f67a188199",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "10970860485",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "07a673a0bff35301971c4f7b43eb44f67a188199",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2766,
    "process.parent_pid": 2668,
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
  "trace_id": "f1ed0fbc30719346ac1209cb8a58357d",
  "span_id": "44c034b2af229e55",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726907557342398000,
  "time_end": 1726907557370103300,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.30.0",
    "service.name": "unknown_service",
    "github.sha": "07a673a0bff35301971c4f7b43eb44f67a188199",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "07a673a0bff35301971c4f7b43eb44f67a188199",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "10970860485",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "07a673a0bff35301971c4f7b43eb44f67a188199",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2766,
    "process.parent_pid": 2668,
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
```
