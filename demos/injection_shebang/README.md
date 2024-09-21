# Demo "injection into shebangs"
Executables can have shebangs, which means that they are actually scripts and executed via a shell or other interpreter even thought they are called like an executable. This sample shows that `which` is such a command and how we can inject into it effortlessly.
## Script
```sh
. otel.sh
which bash
```
## Trace Structure Overview
```
bash -e demo.sh
  /bin/sh /usr/bin/which bash
```
## Full Trace
```
{
  "trace_id": "6588765de622cdeaadba7a390c7f8f3e",
  "span_id": "dee1997f42c7d4f6",
  "parent_span_id": "9ce6306518a53d07",
  "name": "/bin/sh /usr/bin/which bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726907574147316500,
  "time_end": 1726907574165672700,
  "attributes": {
    "shell.command_line": "/bin/sh /usr/bin/which bash",
    "shell.command": "/bin/sh",
    "shell.command.type": "file",
    "shell.command.name": "sh",
    "subprocess.executable.path": "/bin/sh",
    "subprocess.executable.name": "sh",
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
    "process.pid": 2735,
    "process.parent_pid": 2637,
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
  "trace_id": "6588765de622cdeaadba7a390c7f8f3e",
  "span_id": "9ce6306518a53d07",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726907574134899500,
  "time_end": 1726907574165791200,
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
    "process.pid": 2735,
    "process.parent_pid": 2637,
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
