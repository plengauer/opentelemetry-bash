# Demo "Download GitHub releases"
This script takes a github repository (hard-coded for demo purposes), and downloads the last 3 GitHub releases of version 1.x. It showcases context propgation (via netcat, curl, and wget) and auto-injection into inner commands (via xargs and parallel). Netcat is used for an initial head request to configure pagination, curl to make the inidivdual API requests, and wget for the actual downloads.
## Script
```sh
. otel.sh
repository=plengauer/opentelemetry-bash
per_page=100
host=api.github.com
path="/repos/$repository/releases?per_page=$per_page"
url=https://"$host""$path"
printf "HEAD $path HTTP/1.1\r\nConnection: close\r\nUser-Agent: ncat\r\nHost: $host\r\n\r\n" | ncat --ssl -i 3 --no-shutdown "$host" 443 | tr '[:upper:]' '[:lower:]' \
  | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
  | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
  | grep '^page=' | cut -d = -f 2 \
  | xargs seq 1 | xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors "$url"\&page={} ::: \
  | jq '.[] | .assets[] | .browser_download_url' -r | grep '.deb$' | grep '_1.' | head --lines=3 \
  | xargs wget -q
```
## Standard Out
```
```
## Standard Error
```
Ncat: Idle timeout expired (3000 ms).
grep: write error: Broken pipe
```
## Trace Overview
```
bash -e demo.sh
  printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\r\nConnection: close\r\nUser-Agent: ncat\r\nHost: api.github.com\r\n\r\n
  ncat --ssl -i 3 --no-shutdown api.github.com 443
    send/receive
      HEAD
  tr [:upper:] [:lower:]
  grep ^link:
  cut -d   -f 2-
  tr -d  <>
  tr , \n
  grep rel="last"
  cut -d ; -f1
  cut -d ? -f 2-
  tr & \n
  grep ^page=
  cut -d = -f 2
  xargs seq 1
    seq 1 3
  xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::
    /usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2
        GET
  jq .[] | .assets[] | .browser_download_url -r
  head --lines=3
  grep .deb$
  grep _1.
  xargs wget -q
    wget -q https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb
```
## Full OTLP Data
```json
{
  "name": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x5624772f4b1026ba",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.039402Z",
  "end_time": "2024-07-25T20:07:46.151471Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
    "shell.command": "printf",
    "shell.command.type": "builtin",
    "shell.command.name": "printf",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 7
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "HEAD",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xe4886a7781cab05e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x3ddd7e550b2c95f0",
  "start_time": "2024-07-25T20:07:46.395347Z",
  "end_time": "2024-07-25T20:07:50.019264Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "network.protocol.name": "http",
    "network.protocol.version": "1.1",
    "url.full": "http://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100",
    "url.scheme": "http",
    "http.request.method": "HEAD",
    "http.request.body.size": 0,
    "user_agent.original": "netcat",
    "http.request.header.connection": [
      "close"
    ],
    "http.request.header.user-agent": [
      "ncat"
    ],
    "http.request.header.host": [
      "api.github.com"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Thu, 25 Jul 2024 20:07:47 GMT"
    ],
    "http.response.header.content-type": [
      "application/json; charset=utf-8"
    ],
    "http.response.header.cache-control": [
      "public, max-age=60, s-maxage=60"
    ],
    "http.response.header.vary": [
      "Accept,Accept-Encoding, Accept, X-Requested-With"
    ],
    "http.response.header.etag": [
      "W/\"9fcbcf01b6e3730c62ca37a9f7b609c2d82f924bed0d94f6b133a39a7ac21d0f\""
    ],
    "http.response.header.x-github-media-type": [
      "github.v3; format=json"
    ],
    "http.response.header.link": [
      "<https://api.github.com/repositories/692042935/releases?per_page=100&page=2>; rel=\"next\", <https://api.github.com/repositories/692042935/releases?per_page=100&page=3>; rel=\"last\""
    ],
    "http.response.header.x-github-api-version-selected": [
      "2022-11-28"
    ],
    "http.response.header.access-control-expose-headers": [
      "ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset"
    ],
    "http.response.header.access-control-allow-origin": [
      "*"
    ],
    "http.response.header.strict-transport-security": [
      "max-age=31536000; includeSubdomains; preload"
    ],
    "http.response.header.x-frame-options": [
      "deny"
    ],
    "http.response.header.x-content-type-options": [
      "nosniff"
    ],
    "http.response.header.x-xss-protection": [
      "0"
    ],
    "http.response.header.referrer-policy": [
      "origin-when-cross-origin, strict-origin-when-cross-origin"
    ],
    "http.response.header.content-security-policy": [
      "default-src 'none'"
    ],
    "http.response.header.server": [
      "github.com"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "56"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1721938318"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "4"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "1BC0:672B9:66BBE9:BCFBFD:66A2B092"
    ],
    "http.response.header.connection": [
      "close"
    ],
    "http.response.body.size": 0
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "send/receive",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x3ddd7e550b2c95f0",
    "trace_state": "[]"
  },
  "kind": "SpanKind.PRODUCER",
  "parent_id": "0xb6c20d4cdeeda5af",
  "start_time": "2024-07-25T20:07:46.196884Z",
  "end_time": "2024-07-25T20:07:50.019828Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xb6c20d4cdeeda5af",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.042446Z",
  "end_time": "2024-07-25T20:07:50.024647Z",
  "status": {
    "status_code": "ERROR"
  },
  "attributes": {
    "shell.command_line": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
    "shell.command": "ncat",
    "shell.command.type": "file",
    "shell.command.name": "ncat",
    "subprocess.executable.path": "/usr/bin/ncat",
    "subprocess.executable.name": "ncat",
    "shell.command.exit_code": 1,
    "code.filepath": "demo.sh",
    "code.lineno": 7
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "tr [:upper:] [:lower:]",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xda56e4875098df2f",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.070205Z",
  "end_time": "2024-07-25T20:07:50.027071Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "tr [:upper:] [:lower:]",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 7
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "grep ^link:",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x08df299cae204252",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.081027Z",
  "end_time": "2024-07-25T20:07:50.029414Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "grep ^link:",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "cut -d   -f 2-",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xc1557c280650addb",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.075325Z",
  "end_time": "2024-07-25T20:07:50.031917Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "cut -d   -f 2-",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "tr -d  <>",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x06ef6e932e3e6341",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.081513Z",
  "end_time": "2024-07-25T20:07:50.034326Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "tr -d  <>",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "tr , \\n",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x00b52997db7e3052",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.075041Z",
  "end_time": "2024-07-25T20:07:50.036913Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "tr , \\n",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "grep rel=\"last\"",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xdd2069530f87b12f",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.046279Z",
  "end_time": "2024-07-25T20:07:50.039528Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "grep rel=\"last\"",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "cut -d ; -f1",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xe5b1e06fdbdaa952",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.059246Z",
  "end_time": "2024-07-25T20:07:50.042085Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "cut -d ; -f1",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "cut -d ? -f 2-",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x8324faa16650d24e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.064509Z",
  "end_time": "2024-07-25T20:07:50.044722Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "cut -d ? -f 2-",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "tr & \\n",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x9691b67a7a843b2f",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.059442Z",
  "end_time": "2024-07-25T20:07:50.047313Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "tr & \\n",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "grep ^page=",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x9e2ab31ff43e1635",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.058268Z",
  "end_time": "2024-07-25T20:07:50.049802Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "grep ^page=",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 10
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "cut -d = -f 2",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xfd1b45d1a14267c0",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.060286Z",
  "end_time": "2024-07-25T20:07:50.052372Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "cut -d = -f 2",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 10
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "seq 1 3",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xeb66948b40bac557",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x6127c4b1ccb217c4",
  "start_time": "2024-07-25T20:07:50.654675Z",
  "end_time": "2024-07-25T20:07:50.673282Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "seq 1 3",
    "shell.command": "seq",
    "shell.command.type": "file",
    "shell.command.name": "seq",
    "subprocess.executable.path": "/usr/bin/seq",
    "subprocess.executable.name": "seq",
    "shell.command.exit_code": 0,
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
      "process.pid": 4112,
      "process.parent_pid": 3379,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "xargs seq 1",
      "process.command": "xargs",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "xargs seq 1",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x6127c4b1ccb217c4",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.063794Z",
  "end_time": "2024-07-25T20:07:50.677695Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "xargs seq 1",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 11
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "body": "Ncat: Idle timeout expired (3000 ms).",
  "severity_number": "<SeverityNumber.UNSPECIFIED: 0>",
  "severity_text": "unspecified",
  "attributes": null,
  "dropped_attributes": 0,
  "timestamp": "2024-07-25T20:07:50.015148Z",
  "observed_timestamp": "2024-07-25T20:07:50.015180Z",
  "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
  "span_id": "0xb6c20d4cdeeda5af",
  "trace_flags": 1,
  "resource": "{'telemetry.sdk.language': 'shell', 'telemetry.sdk.name': 'opentelemetry', 'telemetry.sdk.version': '4.18.0', 'service.name': 'unknown_service', 'github.sha': '6670336b0d4c133b1f1829da3e925610bfdf5aa1', 'github.repository.id': '692042935', 'github.repository.name': 'plengauer/opentelemetry-bash', 'github.repository.owner.id': '100447901', 'github.repository.owner.name': 'plengauer', 'github.event.ref': 'refs/heads/main', 'github.event.ref.sha': '6670336b0d4c133b1f1829da3e925610bfdf5aa1', 'github.event.ref.name': 'main', 'github.event.actor.id': '100447901', 'github.event.actor.name': 'plengauer', 'github.event.name': 'push', 'github.workflow.run.id': '10100743414', 'github.workflow.run.attempt': '1', 'github.workflow.ref': 'plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main', 'github.workflow.sha': '6670336b0d4c133b1f1829da3e925610bfdf5aa1', 'github.workflow.name': 'Demo', 'github.job.name': 'demo-generate', 'github.step.name': '', 'github.action.name': 'demo', 'process.pid': 2048, 'process.parent_pid': 1937, 'process.executable.name': 'bash', 'process.executable.path': '/usr/bin/bash', 'process.command_line': 'bash -e demo.sh', 'process.command': 'bash', 'process.owner': 'runner', 'process.runtime.name': 'bash', 'process.runtime.description': 'Bourne Again Shell', 'process.runtime.version': '5.1-6ubuntu1.1', 'process.runtime.options': 'ehB', 'service.version': '', 'service.namespace': '', 'service.instance.id': ''}"
}
{
  "name": "GET",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x19bf41d2051f2141",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x02251f7875747ec7",
  "start_time": "2024-07-25T20:07:52.800931Z",
  "end_time": "2024-07-25T20:07:53.813260Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.114.5",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "url.full": "https://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100&page=3",
    "url.scheme": "https",
    "http.request.method": "GET",
    "http.request.header.host": [
      "api.github.com"
    ],
    "user_agent.original": "curl/7.81.0",
    "http.request.header.user-agent": [
      "curl/7.81.0"
    ],
    "http.request.header.accept": [
      "*/*"
    ],
    "http.request.header.traceparent": [
      "00-298114b38a05d48acf716d68ad7d5b4e-02251f7875747ec7-01"
    ],
    "http.request.body.size": 5,
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Thu, 25 Jul 2024 20:07:52 GMT"
    ],
    "http.response.header.content-type": [
      "application/json; charset=utf-8"
    ],
    "http.response.header.cache-control": [
      "public, max-age=60, s-maxage=60"
    ],
    "http.response.header.vary": [
      "Accept,Accept-Encoding, Accept, X-Requested-With"
    ],
    "http.response.header.etag": [
      "W/\"7aaffda0672bbd190ede6289881b67546a75cebe11276063fc4bae0173c7fdab\""
    ],
    "http.response.header.x-github-media-type": [
      "github.v3; format=json"
    ],
    "http.response.header.link": [
      "<https://api.github.com/repositories/692042935/releases?per_page=100&page=2>; rel=\"prev\", <https://api.github.com/repositories/692042935/releases?per_page=100&page=1>; rel=\"first\""
    ],
    "http.response.header.x-github-api-version-selected": [
      "2022-11-28"
    ],
    "http.response.header.access-control-expose-headers": [
      "ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset"
    ],
    "http.response.header.access-control-allow-origin": [
      "*"
    ],
    "http.response.header.strict-transport-security": [
      "max-age=31536000; includeSubdomains; preload"
    ],
    "http.response.header.x-frame-options": [
      "deny"
    ],
    "http.response.header.x-content-type-options": [
      "nosniff"
    ],
    "http.response.header.x-xss-protection": [
      "0"
    ],
    "http.response.header.referrer-policy": [
      "origin-when-cross-origin, strict-origin-when-cross-origin"
    ],
    "http.response.header.content-security-policy": [
      "default-src 'none'"
    ],
    "http.response.header.server": [
      "github.com"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "53"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1721938318"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "7"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "1BC3:8CB9B:693093:C0BA1F:66A2B098"
    ],
    "http.response.body.size": 5
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
      "process.pid": 5509,
      "process.parent_pid": 5415,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
      "process.command": "/usr/bin/perl",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x02251f7875747ec7",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xd5065bc3229bd148",
  "start_time": "2024-07-25T20:07:52.639868Z",
  "end_time": "2024-07-25T20:07:53.818023Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
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
      "process.pid": 5509,
      "process.parent_pid": 5415,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
      "process.command": "/usr/bin/perl",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "GET",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xfb81aacd3c501bc6",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0xf3f495ebfa069ea3",
  "start_time": "2024-07-25T20:07:52.794391Z",
  "end_time": "2024-07-25T20:07:57.131116Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.114.5",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "url.full": "https://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100&page=1",
    "url.scheme": "https",
    "http.request.method": "GET",
    "http.request.header.host": [
      "api.github.com"
    ],
    "user_agent.original": "curl/7.81.0",
    "http.request.header.user-agent": [
      "curl/7.81.0"
    ],
    "http.request.header.accept": [
      "*/*"
    ],
    "http.request.header.traceparent": [
      "00-298114b38a05d48acf716d68ad7d5b4e-f3f495ebfa069ea3-01"
    ],
    "http.request.body.size": 5,
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Thu, 25 Jul 2024 20:07:53 GMT"
    ],
    "http.response.header.content-type": [
      "application/json; charset=utf-8"
    ],
    "http.response.header.cache-control": [
      "public, max-age=60, s-maxage=60"
    ],
    "http.response.header.vary": [
      "Accept,Accept-Encoding, Accept, X-Requested-With"
    ],
    "http.response.header.etag": [
      "W/\"04deca653fda356827e181f454170ab4b30fe3d143f42fda0a95f7a22515217e\""
    ],
    "http.response.header.x-github-media-type": [
      "github.v3; format=json"
    ],
    "http.response.header.link": [
      "<https://api.github.com/repositories/692042935/releases?per_page=100&page=2>; rel=\"next\", <https://api.github.com/repositories/692042935/releases?per_page=100&page=3>; rel=\"last\""
    ],
    "http.response.header.x-github-api-version-selected": [
      "2022-11-28"
    ],
    "http.response.header.access-control-expose-headers": [
      "ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset"
    ],
    "http.response.header.access-control-allow-origin": [
      "*"
    ],
    "http.response.header.strict-transport-security": [
      "max-age=31536000; includeSubdomains; preload"
    ],
    "http.response.header.x-frame-options": [
      "deny"
    ],
    "http.response.header.x-content-type-options": [
      "nosniff"
    ],
    "http.response.header.x-xss-protection": [
      "0"
    ],
    "http.response.header.referrer-policy": [
      "origin-when-cross-origin, strict-origin-when-cross-origin"
    ],
    "http.response.header.content-security-policy": [
      "default-src 'none'"
    ],
    "http.response.header.server": [
      "github.com"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "54"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1721938318"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "6"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "1BC2:229D9A:67E881:BFE385:66A2B098"
    ],
    "http.response.body.size": 5
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
      "process.pid": 5475,
      "process.parent_pid": 5415,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
      "process.command": "/usr/bin/perl",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xf3f495ebfa069ea3",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xd5065bc3229bd148",
  "start_time": "2024-07-25T20:07:52.629555Z",
  "end_time": "2024-07-25T20:07:57.135441Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
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
      "process.pid": 5475,
      "process.parent_pid": 5415,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
      "process.command": "/usr/bin/perl",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "GET",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x998ab1cdf072aa84",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x60bbf0686b5a757e",
  "start_time": "2024-07-25T20:07:52.769945Z",
  "end_time": "2024-07-25T20:07:57.158038Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.114.5",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "url.full": "https://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100&page=2",
    "url.scheme": "https",
    "http.request.method": "GET",
    "http.request.header.host": [
      "api.github.com"
    ],
    "user_agent.original": "curl/7.81.0",
    "http.request.header.user-agent": [
      "curl/7.81.0"
    ],
    "http.request.header.accept": [
      "*/*"
    ],
    "http.request.header.traceparent": [
      "00-298114b38a05d48acf716d68ad7d5b4e-60bbf0686b5a757e-01"
    ],
    "http.request.body.size": 5,
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Thu, 25 Jul 2024 20:07:53 GMT"
    ],
    "http.response.header.content-type": [
      "application/json; charset=utf-8"
    ],
    "http.response.header.cache-control": [
      "public, max-age=60, s-maxage=60"
    ],
    "http.response.header.vary": [
      "Accept,Accept-Encoding, Accept, X-Requested-With"
    ],
    "http.response.header.etag": [
      "W/\"0e7530eccbecae0924e43f51a90054dbac8e2415950dd059b014b67cfadfccdd\""
    ],
    "http.response.header.x-github-media-type": [
      "github.v3; format=json"
    ],
    "http.response.header.link": [
      "<https://api.github.com/repositories/692042935/releases?per_page=100&page=1>; rel=\"prev\", <https://api.github.com/repositories/692042935/releases?per_page=100&page=3>; rel=\"next\", <https://api.github.com/repositories/692042935/releases?per_page=100&page=3>; rel=\"last\", <https://api.github.com/repositories/692042935/releases?per_page=100&page=1>; rel=\"first\""
    ],
    "http.response.header.x-github-api-version-selected": [
      "2022-11-28"
    ],
    "http.response.header.access-control-expose-headers": [
      "ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Used, X-RateLimit-Resource, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type, X-GitHub-SSO, X-GitHub-Request-Id, Deprecation, Sunset"
    ],
    "http.response.header.access-control-allow-origin": [
      "*"
    ],
    "http.response.header.strict-transport-security": [
      "max-age=31536000; includeSubdomains; preload"
    ],
    "http.response.header.x-frame-options": [
      "deny"
    ],
    "http.response.header.x-content-type-options": [
      "nosniff"
    ],
    "http.response.header.x-xss-protection": [
      "0"
    ],
    "http.response.header.referrer-policy": [
      "origin-when-cross-origin, strict-origin-when-cross-origin"
    ],
    "http.response.header.content-security-policy": [
      "default-src 'none'"
    ],
    "http.response.header.server": [
      "github.com"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "55"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1721938318"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "5"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "1BC1:10336A:699A3F:C21F41:66A2B098"
    ],
    "http.response.body.size": 5
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
      "process.pid": 5507,
      "process.parent_pid": 5415,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
      "process.command": "/usr/bin/perl",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x60bbf0686b5a757e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xd5065bc3229bd148",
  "start_time": "2024-07-25T20:07:52.607501Z",
  "end_time": "2024-07-25T20:07:57.162012Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
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
      "process.pid": 5507,
      "process.parent_pid": 5415,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
      "process.command": "/usr/bin/perl",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xd5065bc3229bd148",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xad8091ec5a82e31e",
  "start_time": "2024-07-25T20:07:51.326811Z",
  "end_time": "2024-07-25T20:07:57.178088Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "shell.command": "/usr/bin/perl",
    "shell.command.type": "file",
    "shell.command.name": "perl",
    "subprocess.executable.path": "/usr/bin/perl",
    "subprocess.executable.name": "perl",
    "shell.command.exit_code": 0,
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
      "process.pid": 4688,
      "process.parent_pid": 3463,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
      "process.command": "xargs",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xad8091ec5a82e31e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.063516Z",
  "end_time": "2024-07-25T20:07:57.183465Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 11
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "jq .[] | .assets[] | .browser_download_url -r",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x7b3a2f9c60047324",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.060445Z",
  "end_time": "2024-07-25T20:07:57.187530Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "jq .[] | .assets[] | .browser_download_url -r",
    "shell.command": "jq",
    "shell.command.type": "file",
    "shell.command.name": "jq",
    "subprocess.executable.path": "/usr/bin/jq",
    "subprocess.executable.name": "jq",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "head --lines=3",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xd68a90bd544605fa",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.058109Z",
  "end_time": "2024-07-25T20:07:57.187850Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "head --lines=3",
    "shell.command": "head",
    "shell.command.type": "file",
    "shell.command.name": "head",
    "subprocess.executable.path": "/usr/bin/head",
    "subprocess.executable.name": "head",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "grep .deb$",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xf18400c144e1ad8e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.070487Z",
  "end_time": "2024-07-25T20:07:57.191781Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "grep .deb$",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "grep _1.",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x8fa3b286dda7527b",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.081239Z",
  "end_time": "2024-07-25T20:07:57.197052Z",
  "status": {
    "status_code": "ERROR"
  },
  "attributes": {
    "shell.command_line": "grep _1.",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 2,
    "code.filepath": "demo.sh",
    "code.lineno": 12
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "name": "wget -q https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0xdd244647127db5cb",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x2cfe2fef52301a32",
  "start_time": "2024-07-25T20:07:57.798980Z",
  "end_time": "2024-07-25T20:07:58.349568Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "wget -q https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb",
    "shell.command": "wget",
    "shell.command.type": "file",
    "shell.command.name": "wget",
    "subprocess.executable.path": "/usr/bin/wget",
    "subprocess.executable.name": "wget",
    "shell.command.exit_code": 0,
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
      "process.pid": 18939,
      "process.parent_pid": 3376,
      "process.executable.name": "bash",
      "process.executable.path": "/usr/bin/bash",
      "process.command_line": "xargs wget -q",
      "process.command": "xargs",
      "process.owner": "runner",
      "process.runtime.name": "bash",
      "process.runtime.description": "Bourne Again Shell",
      "process.runtime.version": "5.1-6ubuntu1.1",
      "process.runtime.options": "hBc",
      "service.version": "",
      "service.namespace": "",
      "service.instance.id": ""
    },
    "schema_url": ""
  }
}
{
  "name": "xargs wget -q",
  "context": {
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x2cfe2fef52301a32",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x4ae4c4538bc3fb03",
  "start_time": "2024-07-25T20:07:46.055428Z",
  "end_time": "2024-07-25T20:07:58.353919Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "shell.command_line": "xargs wget -q",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 13
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
    "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
    "span_id": "0x4ae4c4538bc3fb03",
    "trace_state": "[]"
  },
  "kind": "SpanKind.SERVER",
  "parent_id": null,
  "start_time": "2024-07-25T20:07:46.017404Z",
  "end_time": "2024-07-25T20:07:58.354575Z",
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
      "process.pid": 2048,
      "process.parent_pid": 1937,
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
  "body": "grep: write error: Broken pipe",
  "severity_number": "<SeverityNumber.UNSPECIFIED: 0>",
  "severity_text": "unspecified",
  "attributes": null,
  "dropped_attributes": 0,
  "timestamp": "2024-07-25T20:07:57.194021Z",
  "observed_timestamp": "2024-07-25T20:07:57.194041Z",
  "trace_id": "0x298114b38a05d48acf716d68ad7d5b4e",
  "span_id": "0x8fa3b286dda7527b",
  "trace_flags": 1,
  "resource": "{'telemetry.sdk.language': 'shell', 'telemetry.sdk.name': 'opentelemetry', 'telemetry.sdk.version': '4.18.0', 'service.name': 'unknown_service', 'github.sha': '6670336b0d4c133b1f1829da3e925610bfdf5aa1', 'github.repository.id': '692042935', 'github.repository.name': 'plengauer/opentelemetry-bash', 'github.repository.owner.id': '100447901', 'github.repository.owner.name': 'plengauer', 'github.event.ref': 'refs/heads/main', 'github.event.ref.sha': '6670336b0d4c133b1f1829da3e925610bfdf5aa1', 'github.event.ref.name': 'main', 'github.event.actor.id': '100447901', 'github.event.actor.name': 'plengauer', 'github.event.name': 'push', 'github.workflow.run.id': '10100743414', 'github.workflow.run.attempt': '1', 'github.workflow.ref': 'plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main', 'github.workflow.sha': '6670336b0d4c133b1f1829da3e925610bfdf5aa1', 'github.workflow.name': 'Demo', 'github.job.name': 'demo-generate', 'github.step.name': '', 'github.action.name': 'demo', 'process.pid': 2048, 'process.parent_pid': 1937, 'process.executable.name': 'bash', 'process.executable.path': '/usr/bin/bash', 'process.command_line': 'bash -e demo.sh', 'process.command': 'bash', 'process.owner': 'runner', 'process.runtime.name': 'bash', 'process.runtime.description': 'Bourne Again Shell', 'process.runtime.version': '5.1-6ubuntu1.1', 'process.runtime.options': 'ehB', 'service.version': '', 'service.namespace': '', 'service.instance.id': ''}"
}
```
