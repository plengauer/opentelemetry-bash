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
```
## Full Trace
```
{
  "trace_id": "611ad6400847a8dd217e3737e3bdedf8",
  "span_id": "132a46a73b2e4c5a",
  "parent_span_id": "432fcc5f82eaf6b2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1742270270713000000,
  "time_end": 1742270270945842240,
  "attributes": {
    "http.url": "https://example.com/",
    "http.method": "GET",
    "http.target": "/",
    "net.peer.name": "example.com",
    "http.host": "example.com:443",
    "net.peer.ip": "23.192.228.80",
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
    "telemetry.sdk.version": "1.30.1",
    "vcs.system": "git",
    "vcs.commit.id": "4ffb33f2a8ad4cf9c7abd4b4c12151d2624892c1",
    "github.workflow": "Refresh Demos",
    "github.run_id": "13915043667",
    "github.run_number": "35",
    "github.actor": "actions-bot-pl",
    "github.sha": "4ffb33f2a8ad4cf9c7abd4b4c12151d2624892c1",
    "github.ref": "refs/tags/v5.9.0",
    "process.pid": 7925,
    "process.executable.name": "node",
    "process.executable.path": "/usr/local/bin/node",
    "process.command_args": [
      "/usr/local/bin/node",
      "--require",
      "/usr/share/opentelemetry_shell/agent.instrumentation.node.js",
      "--require",
      "/usr/share/opentelemetry_shell/agent.instrumentation.node.deep.instrument.js",
      "/home/runner/work/Thoth/Thoth/demos/injection_deep_node/index.js"
    ],
    "process.runtime.version": "20.18.3",
    "process.runtime.name": "nodejs",
    "process.runtime.description": "Node.js",
    "process.command": "/home/runner/work/Thoth/Thoth/demos/injection_deep_node/index.js",
    "process.owner": "runner"
  },
  "links": [],
  "events": []
}
```
