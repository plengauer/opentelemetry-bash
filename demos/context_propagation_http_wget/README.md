# Demo "Context Propagation with wget"
This script shows context propagation via HTTP from a client (wget) to a server (ncat).
## Script
```sh
otel4netcat_http ncat -l -c 'printf "HTTP/1.1 418 I'\''m a teapot\r\n\r\n"' 12345 & # fake http server
sleep 5
. otel.sh
wget http://127.0.0.1:12345
```
## Trace Structure Overview
```
bash -e demo.sh
  wget http://127.0.0.1:12345
    GET
      GET
        printf HTTP/1.1 418 I'm a teapot
send/receive
```
## Full Trace
```
{
  "trace_id": "6b5bff3b2b61fd346300f77eec3a194a",
  "span_id": "35bd2a7f69ab8c94",
  "parent_span_id": "2923f9fbfe4dd264",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1732509215283253000,
  "time_end": 1732509216008622800,
  "attributes": {
    "network.protocol.name": "http",
    "network.transport": "tcp",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 12345,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "url.full": "http://127.0.0.1:12345/",
    "url.path": "/",
    "url.scheme": "http",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 418
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.41.0",
    "service.name": "unknown_service",
    "github.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12001980998",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3487,
    "process.parent_pid": 2748,
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
  "trace_id": "6b5bff3b2b61fd346300f77eec3a194a",
  "span_id": "9187c77e3e8b837c",
  "parent_span_id": "35bd2a7f69ab8c94",
  "name": "GET",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1732509215890851000,
  "time_end": 1732509216013669600,
  "attributes": {
    "network.transport": "TCP",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 54536,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "client.address": "127.0.0.1",
    "client.port": 54536,
    "network.protocol.name": "http",
    "network.protocol.version": "1.1",
    "url.full": "http://:12345/",
    "url.path": "/",
    "url.scheme": "http",
    "http.request.method": "GET",
    "http.request.body.size": 0,
    "http.request.header.host": [
      "127.0.0.1:12345"
    ],
    "http.response.status_code": 418,
    "http.response.body.size": 0
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.41.0",
    "service.name": "unknown_service",
    "github.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12001980998",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 4458,
    "process.parent_pid": 4455,
    "process.executable.name": "dash",
    "process.executable.path": "/usr/bin/dash",
    "process.command_line": "ncat -l -c printf \"HTTP/1.1 418 I'm a teapot    \" 12345",
    "process.command": "ncat",
    "process.owner": "runner",
    "process.runtime.name": "dash",
    "process.runtime.description": "Debian Almquist Shell",
    "process.runtime.version": "0.5.11+git20210903+057cd650a4ed-3build1",
    "process.runtime.options": "e",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [
    {
      "trace_id": "9e30d175aedcb80d9603cf08a6c29f6e",
      "span_id": "0bd5e6d002f9c95e",
      "attributes": {}
    }
  ],
  "events": []
}
{
  "trace_id": "6b5bff3b2b61fd346300f77eec3a194a",
  "span_id": "1aca0ad01bdf4dfa",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "ERROR",
  "time_start": 1732509215240535600,
  "time_end": 1732509216013647000,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.41.0",
    "service.name": "unknown_service",
    "github.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12001980998",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3487,
    "process.parent_pid": 2748,
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
  "trace_id": "6b5bff3b2b61fd346300f77eec3a194a",
  "span_id": "ea0170d3185d9dbd",
  "parent_span_id": "9187c77e3e8b837c",
  "name": "printf HTTP/1.1 418 I'm a teapot",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732509215900481000,
  "time_end": 1732509215919845400,
  "attributes": {
    "shell.command_line": "printf HTTP/1.1 418 I'm a teapot",
    "shell.command": "printf",
    "shell.command.type": "builtin",
    "shell.command.name": "printf",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel4netcat_handler"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.41.0",
    "service.name": "unknown_service",
    "github.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12001980998",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 4458,
    "process.parent_pid": 4455,
    "process.executable.name": "dash",
    "process.executable.path": "/usr/bin/dash",
    "process.command_line": "ncat -l -c printf \"HTTP/1.1 418 I'm a teapot    \" 12345",
    "process.command": "ncat",
    "process.owner": "runner",
    "process.runtime.name": "dash",
    "process.runtime.description": "Debian Almquist Shell",
    "process.runtime.version": "0.5.11+git20210903+057cd650a4ed-3build1",
    "process.runtime.options": "e",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "9e30d175aedcb80d9603cf08a6c29f6e",
  "span_id": "0bd5e6d002f9c95e",
  "parent_span_id": "",
  "name": "send/receive",
  "kind": "CONSUMER",
  "status": "UNSET",
  "time_start": 1732509215781554200,
  "time_end": 1732509216016642600,
  "attributes": {
    "network.transport": "TCP",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 54536,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "client.address": "127.0.0.1",
    "client.port": 54536
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.41.0",
    "service.name": "unknown_service",
    "github.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12001980998",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 4458,
    "process.parent_pid": 4455,
    "process.executable.name": "dash",
    "process.executable.path": "/usr/bin/dash",
    "process.command_line": "ncat -l -c printf \"HTTP/1.1 418 I'm a teapot    \" 12345",
    "process.command": "ncat",
    "process.owner": "runner",
    "process.runtime.name": "dash",
    "process.runtime.description": "Debian Almquist Shell",
    "process.runtime.version": "0.5.11+git20210903+057cd650a4ed-3build1",
    "process.runtime.options": "e",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [
    {
      "trace_id": "6b5bff3b2b61fd346300f77eec3a194a",
      "span_id": "9187c77e3e8b837c",
      "attributes": {}
    }
  ],
  "events": []
}
{
  "trace_id": "6b5bff3b2b61fd346300f77eec3a194a",
  "span_id": "2923f9fbfe4dd264",
  "parent_span_id": "1aca0ad01bdf4dfa",
  "name": "wget http://127.0.0.1:12345",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1732509215253450500,
  "time_end": 1732509216013446000,
  "attributes": {
    "shell.command_line": "wget http://127.0.0.1:12345",
    "shell.command": "wget",
    "shell.command.type": "file",
    "shell.command.name": "wget",
    "subprocess.executable.path": "/usr/bin/wget",
    "subprocess.executable.name": "wget",
    "shell.command.exit_code": 8,
    "code.filepath": "demo.sh",
    "code.lineno": 4
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.41.0",
    "service.name": "unknown_service",
    "github.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "12001980998",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "3e8b13c5ef998a6556a657d8de0e8a5588b40ed4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3487,
    "process.parent_pid": 2748,
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
