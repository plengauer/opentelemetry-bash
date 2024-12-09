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
    GET
```
## Full Trace
```
{
  "trace_id": "62bd51f6efa2a3b90793c712e23a3a72",
  "span_id": "559758fe607e7533",
  "parent_span_id": "caa5bedf76401f89",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1733778665203000000,
  "time_end": 1733778846197841945,
  "attributes": {
    "http.url": "https://example.com/",
    "http.method": "GET",
    "http.target": "/",
    "net.peer.name": "example.com",
    "http.host": "example.com:443",
    "net.peer.ip": "93.184.215.14",
    "net.peer.port": 443,
    "http.response_content_length_uncompressed": 1256,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "unknown_service:node",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.29.0",
    "vcs.system": "git",
    "vcs.commit.id": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "vcs.branch.name": "main",
    "github.workflow": "Publish",
    "github.run_id": "12235876956",
    "github.run_number": "75",
    "github.actor": "actions-bot-pl",
    "github.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.ref": "refs/heads/main",
    "process.pid": 8445,
    "process.executable.name": "node",
    "process.executable.path": "/usr/local/bin/node",
    "process.command_args": [
      "/usr/local/bin/node",
      "--require",
      "/usr/share/opentelemetry_shell/agent.instrumentation.node.js",
      "--require",
      "/usr/share/opentelemetry_shell/agent.instrumentation.node.deep.instrument.js",
      "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js"
    ],
    "process.runtime.version": "20.18.1",
    "process.runtime.name": "nodejs",
    "process.runtime.description": "Node.js",
    "process.command": "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js",
    "process.owner": "runner"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "62bd51f6efa2a3b90793c712e23a3a72",
  "span_id": "b92e69443ee12510",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1733778663859815467,
  "time_end": 1733778846217619070,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.42.0",
    "service.name": "unknown_service",
    "github.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12235876956",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1017-azure",
    "process.pid": 7681,
    "process.parent_pid": 2574,
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
  "trace_id": "62bd51f6efa2a3b90793c712e23a3a72",
  "span_id": "caa5bedf76401f89",
  "parent_span_id": "b92e69443ee12510",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1733778663872268370,
  "time_end": 1733778846217454181,
  "attributes": {
    "shell.command_line": "node index.js",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.42.0",
    "service.name": "unknown_service",
    "github.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12235876956",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "707bf506dd05fc41f8d46b1038d9ab6bee9f4cf3",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1017-azure",
    "process.pid": 7681,
    "process.parent_pid": 2574,
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
