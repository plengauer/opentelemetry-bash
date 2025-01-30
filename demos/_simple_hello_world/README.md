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
  "trace_id": "8aae396b172e08fbebdb6c413f3be6ed",
  "span_id": "167edcab9bf24a60",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1738246825458152080,
  "time_end": 1738246825488126319,
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
    "process.pid": 2234,
    "process.parent_pid": 2135,
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
  "trace_id": "8aae396b172e08fbebdb6c413f3be6ed",
  "span_id": "b1b0cb148e7c56c7",
  "parent_span_id": "167edcab9bf24a60",
  "name": "echo hello world",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738246825471546367,
  "time_end": 1738246825487963243,
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
    "process.pid": 2234,
    "process.parent_pid": 2135,
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
