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
  "trace_id": "ceff995c1b91ff0ad3d88106bd722b8d",
  "span_id": "59340cb3c117193d",
  "parent_span_id": "762eec2a7fd469eb",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437517417000000,
  "time_end": 1727437698019752772,
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
    "telemetry.sdk.version": "1.26.0",
    "vcs.system": "git",
    "vcs.commit.id": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "vcs.branch.name": "main",
    "github.workflow": "Publish",
    "github.run_id": "11068449473",
    "github.run_number": "59",
    "github.actor": "plengauer",
    "github.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.ref": "refs/heads/main",
    "process.pid": 8157,
    "process.executable.name": "node",
    "process.executable.path": "/usr/local/bin/node",
    "process.command_args": [
      "/usr/local/bin/node",
      "--require",
      "/usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.js",
      "--require",
      "/usr/share/opentelemetry_shell/opentelemetry_shell.custom.node.deep.instrument.js",
      "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js"
    ],
    "process.runtime.version": "20.17.0",
    "process.runtime.name": "nodejs",
    "process.runtime.description": "Node.js",
    "process.command": "/home/runner/work/opentelemetry-bash/opentelemetry-bash/demos/injection_deep_node/index.js",
    "process.owner": "runner"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "ceff995c1b91ff0ad3d88106bd722b8d",
  "span_id": "762eec2a7fd469eb",
  "parent_span_id": "2eef3f5e101a8e65",
  "name": "node index.js",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437516277398310,
  "time_end": 1727437698037395856,
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
    "telemetry.sdk.version": "4.31.1",
    "service.name": "unknown_service",
    "github.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11068449473",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 7534,
    "process.parent_pid": 2608,
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
  "trace_id": "ceff995c1b91ff0ad3d88106bd722b8d",
  "span_id": "2eef3f5e101a8e65",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1727437516264962762,
  "time_end": 1727437698037515520,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.31.1",
    "service.name": "unknown_service",
    "github.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11068449473",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "e98e7ed40fca3243d4bdf5a66f5f54e3867dc58b",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 7534,
    "process.parent_pid": 2608,
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
