# Demo "Download GitHub releases"
This script takes a github repository (hard-coded for demo purposes), and downloads the last 3 GitHub releases of version 1.x. It showcases context propgation (via netcat, curl, and wget) and auto-injection into inner commands (via xargs and parallel). Netcat is used for an initial head request to configure pagination, curl to make the inidivdual API requests, and wget for the actual downloads.
## Script
´´´sh
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
´´´
## Standard Out
´´´
´´´
## Standard Error
´´´
Ncat: Idle timeout expired (3000 ms).
grep: write error: Broken pipe
´´´
## Trace Overview
´´´
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
  head --lines=3
  xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::
    /usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1
        GET
  jq .[] | .assets[] | .browser_download_url -r
  grep .deb$
  grep _1.
  xargs wget -q
    wget -q https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb
´´´
## Full OTLP Data
´´´json
{
    "name": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
    "context": {
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xe0a08f317fc5b7fe",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.785211Z",
    "end_time": "2024-07-22T14:45:10.898929Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xc43e69bb61f78b48",
        "trace_state": "[]"
    },
    "kind": "SpanKind.CLIENT",
    "parent_id": "0x2aba6e689b79ea72",
    "start_time": "2024-07-22T14:45:11.135724Z",
    "end_time": "2024-07-22T14:45:14.918971Z",
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
            "Mon, 22 Jul 2024 14:45:11 GMT"
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
            "W/\"c3bab18ad13f8d9e0c9d81a08a4f0af509259ba624b6abde319c912311c342d7\""
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
            "1721663087"
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
            "1840:58489:B21CE68:B4020A1:669E7077"
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x2aba6e689b79ea72",
        "trace_state": "[]"
    },
    "kind": "SpanKind.PRODUCER",
    "parent_id": "0x2a222951bcc04f8a",
    "start_time": "2024-07-22T14:45:10.933106Z",
    "end_time": "2024-07-22T14:45:14.919526Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x2a222951bcc04f8a",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.802070Z",
    "end_time": "2024-07-22T14:45:14.924579Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x0827e477c4a88c0f",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.815521Z",
    "end_time": "2024-07-22T14:45:14.927075Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xee1db004c1362c75",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.802214Z",
    "end_time": "2024-07-22T14:45:14.929447Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x52649e79b1b4754b",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.811848Z",
    "end_time": "2024-07-22T14:45:14.932096Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xc0117ce826cbcae2",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.812025Z",
    "end_time": "2024-07-22T14:45:14.934467Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x7cdb6e429cf825e5",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.801910Z",
    "end_time": "2024-07-22T14:45:14.937015Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x8040ac23dcbdcdc0",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.800871Z",
    "end_time": "2024-07-22T14:45:14.939597Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xbc67a25a107e071b",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.802372Z",
    "end_time": "2024-07-22T14:45:14.942029Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x390a7b897c449a95",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.811701Z",
    "end_time": "2024-07-22T14:45:14.944476Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x6e1c7934fa04791e",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.800656Z",
    "end_time": "2024-07-22T14:45:14.946891Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x6bde32bfb411b408",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.805570Z",
    "end_time": "2024-07-22T14:45:14.949242Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xcd8ac4afd3c45aa8",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.824491Z",
    "end_time": "2024-07-22T14:45:14.951676Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xa0a3c781c39ebdbf",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0xea48115863e9ad31",
    "start_time": "2024-07-22T14:45:15.536108Z",
    "end_time": "2024-07-22T14:45:15.554792Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 4173,
            "process.parent_pid": 3454,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xea48115863e9ad31",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.805411Z",
    "end_time": "2024-07-22T14:45:15.559435Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
    "timestamp": "2024-07-22T14:45:14.914765Z",
    "observed_timestamp": "2024-07-22T14:45:14.914792Z",
    "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
    "span_id": "0x2a222951bcc04f8a",
    "trace_flags": 1,
    "resource": "{'telemetry.sdk.language': 'shell', 'telemetry.sdk.name': 'opentelemetry', 'telemetry.sdk.version': '4.18.0', 'service.name': 'unknown_service', 'github.sha': '5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9', 'github.repository.id': '692042935', 'github.repository.name': 'plengauer/opentelemetry-bash', 'github.repository.owner.id': '100447901', 'github.repository.owner.name': 'plengauer', 'github.event.ref': 'refs/heads/main', 'github.event.ref.sha': '5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9', 'github.event.ref.name': 'main', 'github.event.actor.id': '100447901', 'github.event.actor.name': 'plengauer', 'github.event.name': 'push', 'github.workflow.run.id': '10043051260', 'github.workflow.run.attempt': '1', 'github.workflow.ref': 'plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main', 'github.workflow.sha': '5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9', 'github.workflow.name': 'Demo', 'github.job.name': 'demo-generate', 'github.step.name': '', 'github.action.name': 'demo', 'process.pid': 2107, 'process.parent_pid': 1991, 'process.executable.name': 'bash', 'process.executable.path': '/usr/bin/bash', 'process.command_line': 'bash -e demo.sh', 'process.command': 'bash', 'process.owner': 'runner', 'process.runtime.name': 'bash', 'process.runtime.description': 'Bourne Again Shell', 'process.runtime.version': '5.1-6ubuntu1.1', 'process.runtime.options': 'ehB', 'service.version': '', 'service.namespace': '', 'service.instance.id': ''}"
}
{
    "name": "GET",
    "context": {
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xa53596521e9cd688",
        "trace_state": "[]"
    },
    "kind": "SpanKind.CLIENT",
    "parent_id": "0x9db65bdff0e16453",
    "start_time": "2024-07-22T14:45:17.813517Z",
    "end_time": "2024-07-22T14:45:18.704108Z",
    "status": {
        "status_code": "UNSET"
    },
    "attributes": {
        "network.transport": "tcp",
        "network.protocol.name": "https",
        "network.protocol.version": "2",
        "network.peer.address": "140.82.116.6",
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
            "00-a80fb455497fbe832a39349bc7d70dd4-9db65bdff0e16453-01"
        ],
        "http.request.body.size": 5,
        "http.response.status_code": 200,
        "http.response.header.date": [
            "Mon, 22 Jul 2024 14:45:17 GMT"
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
            "55"
        ],
        "http.response.header.x-ratelimit-reset": [
            "1721663087"
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
            "1843:263F15:BB9A7C2:BD7FC90:669E707D"
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 5623,
            "process.parent_pid": 5476,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x9db65bdff0e16453",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0xe9e8425db50d3655",
    "start_time": "2024-07-22T14:45:17.626629Z",
    "end_time": "2024-07-22T14:45:18.708211Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 5623,
            "process.parent_pid": 5476,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xfd5edf38eeed91f6",
        "trace_state": "[]"
    },
    "kind": "SpanKind.CLIENT",
    "parent_id": "0xbd4eb7c327d3147f",
    "start_time": "2024-07-22T14:45:17.723798Z",
    "end_time": "2024-07-22T14:45:21.828118Z",
    "status": {
        "status_code": "UNSET"
    },
    "attributes": {
        "network.transport": "tcp",
        "network.protocol.name": "https",
        "network.protocol.version": "2",
        "network.peer.address": "140.82.116.6",
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
            "00-a80fb455497fbe832a39349bc7d70dd4-bd4eb7c327d3147f-01"
        ],
        "http.request.body.size": 5,
        "http.response.status_code": 200,
        "http.response.header.date": [
            "Mon, 22 Jul 2024 14:45:18 GMT"
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
            "W/\"7b35caae9fb640fe386d3824fee9dcdb322e6eaa4c8755cf3d9774a6330d9f59\""
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
            "56"
        ],
        "http.response.header.x-ratelimit-reset": [
            "1721663087"
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
            "1842:37F96C:2EB628B:2F23DD3:669E707D"
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 5620,
            "process.parent_pid": 5476,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xbd4eb7c327d3147f",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0xe9e8425db50d3655",
    "start_time": "2024-07-22T14:45:17.552660Z",
    "end_time": "2024-07-22T14:45:21.832530Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 5620,
            "process.parent_pid": 5476,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xb12d33c313fd7012",
        "trace_state": "[]"
    },
    "kind": "SpanKind.CLIENT",
    "parent_id": "0x611269c1a2b17f59",
    "start_time": "2024-07-22T14:45:17.701389Z",
    "end_time": "2024-07-22T14:45:22.618932Z",
    "status": {
        "status_code": "UNSET"
    },
    "attributes": {
        "network.transport": "tcp",
        "network.protocol.name": "https",
        "network.protocol.version": "2",
        "network.peer.address": "140.82.116.6",
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
            "00-a80fb455497fbe832a39349bc7d70dd4-611269c1a2b17f59-01"
        ],
        "http.request.body.size": 5,
        "http.response.status_code": 200,
        "http.response.header.date": [
            "Mon, 22 Jul 2024 14:45:19 GMT"
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
            "W/\"e9f445e192e5f60cb43802481ee64758e368bea9e7610287b34d42c9c95aea49\""
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
            "57"
        ],
        "http.response.header.x-ratelimit-reset": [
            "1721663087"
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
            "1841:1961CF:10A234C2:10CC6913:669E707D"
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 5536,
            "process.parent_pid": 5476,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x611269c1a2b17f59",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0xe9e8425db50d3655",
    "start_time": "2024-07-22T14:45:17.511882Z",
    "end_time": "2024-07-22T14:45:22.622413Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 5536,
            "process.parent_pid": 5476,
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
    "name": "head --lines=3",
    "context": {
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x1035be06c3df62f3",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.815338Z",
    "end_time": "2024-07-22T14:45:22.633533Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
    "name": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "context": {
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xe9e8425db50d3655",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x4e7bad5feaf837dc",
    "start_time": "2024-07-22T14:45:16.195933Z",
    "end_time": "2024-07-22T14:45:22.636983Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 4749,
            "process.parent_pid": 3516,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x4e7bad5feaf837dc",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.815175Z",
    "end_time": "2024-07-22T14:45:22.646272Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x198a245db32d5435",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.807546Z",
    "end_time": "2024-07-22T14:45:22.649049Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x9c42af6fa590ad0b",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.807378Z",
    "end_time": "2024-07-22T14:45:22.652976Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0xb978b43b1e34d18b",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.817283Z",
    "end_time": "2024-07-22T14:45:22.658131Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x9fc55cf8e9e5280c",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x25821d7748b5c90f",
    "start_time": "2024-07-22T14:45:23.256356Z",
    "end_time": "2024-07-22T14:45:25.027197Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 18906,
            "process.parent_pid": 3455,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x25821d7748b5c90f",
        "trace_state": "[]"
    },
    "kind": "SpanKind.INTERNAL",
    "parent_id": "0x2d88d46b25052cc5",
    "start_time": "2024-07-22T14:45:10.833786Z",
    "end_time": "2024-07-22T14:45:25.031566Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
        "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
        "span_id": "0x2d88d46b25052cc5",
        "trace_state": "[]"
    },
    "kind": "SpanKind.SERVER",
    "parent_id": null,
    "start_time": "2024-07-22T14:45:10.763077Z",
    "end_time": "2024-07-22T14:45:25.032255Z",
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
            "github.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.repository.id": "692042935",
            "github.repository.name": "plengauer/opentelemetry-bash",
            "github.repository.owner.id": "100447901",
            "github.repository.owner.name": "plengauer",
            "github.event.ref": "refs/heads/main",
            "github.event.ref.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.event.ref.name": "main",
            "github.event.actor.id": "100447901",
            "github.event.actor.name": "plengauer",
            "github.event.name": "push",
            "github.workflow.run.id": "10043051260",
            "github.workflow.run.attempt": "1",
            "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main",
            "github.workflow.sha": "5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9",
            "github.workflow.name": "Demo",
            "github.job.name": "demo-generate",
            "github.step.name": "",
            "github.action.name": "demo",
            "process.pid": 2107,
            "process.parent_pid": 1991,
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
    "timestamp": "2024-07-22T14:45:22.655315Z",
    "observed_timestamp": "2024-07-22T14:45:22.655336Z",
    "trace_id": "0xa80fb455497fbe832a39349bc7d70dd4",
    "span_id": "0xb978b43b1e34d18b",
    "trace_flags": 1,
    "resource": "{'telemetry.sdk.language': 'shell', 'telemetry.sdk.name': 'opentelemetry', 'telemetry.sdk.version': '4.18.0', 'service.name': 'unknown_service', 'github.sha': '5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9', 'github.repository.id': '692042935', 'github.repository.name': 'plengauer/opentelemetry-bash', 'github.repository.owner.id': '100447901', 'github.repository.owner.name': 'plengauer', 'github.event.ref': 'refs/heads/main', 'github.event.ref.sha': '5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9', 'github.event.ref.name': 'main', 'github.event.actor.id': '100447901', 'github.event.actor.name': 'plengauer', 'github.event.name': 'push', 'github.workflow.run.id': '10043051260', 'github.workflow.run.attempt': '1', 'github.workflow.ref': 'plengauer/opentelemetry-bash/.github/workflows/demo.yaml@refs/heads/main', 'github.workflow.sha': '5dd39185b61d7cfb2b9e74e99d3a60358d8a8bc9', 'github.workflow.name': 'Demo', 'github.job.name': 'demo-generate', 'github.step.name': '', 'github.action.name': 'demo', 'process.pid': 2107, 'process.parent_pid': 1991, 'process.executable.name': 'bash', 'process.executable.path': '/usr/bin/bash', 'process.command_line': 'bash -e demo.sh', 'process.command': 'bash', 'process.owner': 'runner', 'process.runtime.name': 'bash', 'process.runtime.description': 'Bourne Again Shell', 'process.runtime.version': '5.1-6ubuntu1.1', 'process.runtime.options': 'ehB', 'service.version': '', 'service.namespace': '', 'service.instance.id': ''}"
}
´´´
