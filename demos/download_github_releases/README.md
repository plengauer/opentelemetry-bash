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
  head --lines=3
  jq .[] | .assets[] | .browser_download_url -r
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xf45c261913fbcd14",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.467673Z",
  "end_time": "2024-08-05T08:43:18.588294Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x227db4ee387dcab8",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x352c6ae1b8745360",
  "start_time": "2024-08-05T08:43:18.816493Z",
  "end_time": "2024-08-05T08:43:22.389174Z",
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
      "Mon, 05 Aug 2024 08:43:19 GMT"
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
      "W/\"701c2d35fd2ccf81b87572579758d6e0d3635a89645069fcbfbd79978fdcb1e8\""
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
      "58"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1722850862"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "2"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "CC40:20CB58:95EDD3E:1155B1C3:66B090A6"
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x352c6ae1b8745360",
    "trace_state": "[]"
  },
  "kind": "SpanKind.PRODUCER",
  "parent_id": "0x12d8f287cd25d8db",
  "start_time": "2024-08-05T08:43:18.613974Z",
  "end_time": "2024-08-05T08:43:22.389702Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x12d8f287cd25d8db",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.477633Z",
  "end_time": "2024-08-05T08:43:22.394384Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xb59be69bba1c9348",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.477474Z",
  "end_time": "2024-08-05T08:43:22.396737Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xf33dc7b6f1be23fe",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.522238Z",
  "end_time": "2024-08-05T08:43:22.399149Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xef29c2313a8dc9c2",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.501134Z",
  "end_time": "2024-08-05T08:43:22.401453Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x39726bc7840a02af",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.493195Z",
  "end_time": "2024-08-05T08:43:22.403865Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x2e7efa1366ff9e54",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.492443Z",
  "end_time": "2024-08-05T08:43:22.406131Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xc8269db61c550ca6",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.488307Z",
  "end_time": "2024-08-05T08:43:22.408490Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x5824e5bbca1608e9",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.489893Z",
  "end_time": "2024-08-05T08:43:22.410906Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x334bf6e820fc508e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.483577Z",
  "end_time": "2024-08-05T08:43:22.413218Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x18797e865046573c",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.492638Z",
  "end_time": "2024-08-05T08:43:22.415526Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x71027581e6624318",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.484896Z",
  "end_time": "2024-08-05T08:43:22.417888Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x7ebb54d6fffb13aa",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.500833Z",
  "end_time": "2024-08-05T08:43:22.420286Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x857a8107fcfaa41c",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xc92adf325c8f0711",
  "start_time": "2024-08-05T08:43:23.006518Z",
  "end_time": "2024-08-05T08:43:23.025201Z",
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
      "process.pid": 4866,
      "process.parent_pid": 4127,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xc92adf325c8f0711",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.500978Z",
  "end_time": "2024-08-05T08:43:23.030441Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
  "timestamp": "2024-08-05T08:43:22.385165Z",
  "observed_timestamp": "2024-08-05T08:43:22.385183Z",
  "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
  "span_id": "0x12d8f287cd25d8db",
  "trace_flags": 1,
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
  "name": "GET",
  "context": {
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xdca978688cd0aba0",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x64aaa8b751c0eeb9",
  "start_time": "2024-08-05T08:43:25.151464Z",
  "end_time": "2024-08-05T08:43:26.189001Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.113.5",
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
      "00-81e8be98db9abef8535ff71d9ea513b7-64aaa8b751c0eeb9-01"
    ],
    "http.request.body.size": 5,
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Mon, 05 Aug 2024 08:43:25 GMT"
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
      "W/\"b9e9d6efc419d83767a5926c4aff1710359085de2457f3b97fe70fc0e5b4fd69\""
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
      "59"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1722851005"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "1"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "CC40:69407:9DC8652:123E5FFD:66B090AD"
    ],
    "http.response.body.size": 5
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
      "process.pid": 6269,
      "process.parent_pid": 6170,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x64aaa8b751c0eeb9",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x1be8224dca839c0b",
  "start_time": "2024-08-05T08:43:24.992783Z",
  "end_time": "2024-08-05T08:43:26.194110Z",
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
      "process.pid": 6269,
      "process.parent_pid": 6170,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x8c1e70e98511ab5e",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x19561872a6f6a55c",
  "start_time": "2024-08-05T08:43:25.200132Z",
  "end_time": "2024-08-05T08:43:29.482579Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.113.5",
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
      "00-81e8be98db9abef8535ff71d9ea513b7-19561872a6f6a55c-01"
    ],
    "http.request.body.size": 5,
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Mon, 05 Aug 2024 08:43:25 GMT"
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
      "W/\"000cf11caa9e5c44f82c79138c521a38a89b36c378bb79dbd5a5c95b99f11e26\""
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
      "58"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1722851005"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "2"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "CC41:24BEA1:9B8144C:11F9B2D6:66B090AD"
    ],
    "http.response.body.size": 5
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
      "process.pid": 6230,
      "process.parent_pid": 6170,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x19561872a6f6a55c",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x1be8224dca839c0b",
  "start_time": "2024-08-05T08:43:25.033304Z",
  "end_time": "2024-08-05T08:43:29.486731Z",
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
      "process.pid": 6230,
      "process.parent_pid": 6170,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x598543cdfc05a68f",
    "trace_state": "[]"
  },
  "kind": "SpanKind.CLIENT",
  "parent_id": "0x31b7447e1182ef4d",
  "start_time": "2024-08-05T08:43:25.209459Z",
  "end_time": "2024-08-05T08:43:29.535452Z",
  "status": {
    "status_code": "UNSET"
  },
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.113.5",
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
      "00-81e8be98db9abef8535ff71d9ea513b7-31b7447e1182ef4d-01"
    ],
    "http.request.body.size": 5,
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Mon, 05 Aug 2024 08:43:25 GMT"
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
      "W/\"566a9174b62e7ab55c72d984535bec59bdab3233c2f9355c0ec428ad0938193c\""
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
      "57"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1722851005"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "3"
    ],
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-github-request-id": [
      "CC42:36EE3:97132D0:1170F04D:66B090AD"
    ],
    "http.response.body.size": 5
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
      "process.pid": 6267,
      "process.parent_pid": 6170,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x31b7447e1182ef4d",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x1be8224dca839c0b",
  "start_time": "2024-08-05T08:43:25.051348Z",
  "end_time": "2024-08-05T08:43:29.539034Z",
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
      "process.pid": 6267,
      "process.parent_pid": 6170,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x1be8224dca839c0b",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x8f5569248d7c7c65",
  "start_time": "2024-08-05T08:43:23.658004Z",
  "end_time": "2024-08-05T08:43:29.552859Z",
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
      "process.pid": 5443,
      "process.parent_pid": 4226,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x8f5569248d7c7c65",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.500678Z",
  "end_time": "2024-08-05T08:43:29.558473Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xcbc4e8c42fb3d761",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.492299Z",
  "end_time": "2024-08-05T08:43:29.562160Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xad9c5c0509466902",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.492796Z",
  "end_time": "2024-08-05T08:43:29.562745Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xe87f31e3774f992f",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.493047Z",
  "end_time": "2024-08-05T08:43:29.565581Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x5f125c2c18331859",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.488462Z",
  "end_time": "2024-08-05T08:43:29.570865Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x23e67b36282bc3b0",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0x5ef4c2202041afc2",
  "start_time": "2024-08-05T08:43:30.166265Z",
  "end_time": "2024-08-05T08:43:30.699184Z",
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
      "process.pid": 19724,
      "process.parent_pid": 4175,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0x5ef4c2202041afc2",
    "trace_state": "[]"
  },
  "kind": "SpanKind.INTERNAL",
  "parent_id": "0xcd1b2e193235b875",
  "start_time": "2024-08-05T08:43:18.506615Z",
  "end_time": "2024-08-05T08:43:30.703337Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
    "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
    "span_id": "0xcd1b2e193235b875",
    "trace_state": "[]"
  },
  "kind": "SpanKind.SERVER",
  "parent_id": null,
  "start_time": "2024-08-05T08:43:18.447162Z",
  "end_time": "2024-08-05T08:43:30.703922Z",
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
  "timestamp": "2024-08-05T08:43:29.567794Z",
  "observed_timestamp": "2024-08-05T08:43:29.567807Z",
  "trace_id": "0x81e8be98db9abef8535ff71d9ea513b7",
  "span_id": "0x5f125c2c18331859",
  "trace_flags": 1,
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
      "process.pid": 2803,
      "process.parent_pid": 2691,
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
