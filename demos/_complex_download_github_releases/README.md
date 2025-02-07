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
  | jq '.[].assets[].browser_download_url' -r | grep '.deb$' | grep '_1.' | head --lines=3 \
  | xargs wget
```
## Trace Structure Overview
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
  head --lines=3
  xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::
    /usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1
        GET
  jq .[].assets[].browser_download_url -r
  grep .deb$
  grep _1.
  xargs wget
    wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0-bash/opentelemetry-bash_1.1.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0/opentelemetry-bash_1.1.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.0-zsh/opentelemetry-zsh_1.0.0.deb
      GET
      GET
      GET
      GET
      GET
      GET
```
## Full Trace
```
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "2e0bb1f796130db1",
  "parent_span_id": "c1d8fc4109d60766",
  "name": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948148130959706,
  "time_end": 1738948150339392444,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 5844,
    "process.parent_pid": 4439,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "d5bfde5ec3323da8",
  "parent_span_id": "2996f862583b620e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948149466091937,
  "time_end": 1738948150065004811,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.114.6",
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
    "user_agent.original": "curl/8.5.0",
    "http.request.header.user-agent": [
      "curl/8.5.0"
    ],
    "http.request.header.accept": [
      "*/*"
    ],
    "http.request.header.traceparent": [
      "00-be00bb36450c5f9815a4a88908f0d4b0-2996f862583b620e-01"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Fri, 07 Feb 2025 17:09:09 GMT"
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
      "W/\"3b3ad770d262b47f0149d9e085e99d29e64d20f4b6ae2c1c34a59ef59727e710\""
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
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "58"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1738951743"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "2"
    ],
    "http.response.header.x-github-request-id": [
      "AB41:251997:15C6C8B:2BC33DC:67A63E35"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 6662,
    "process.parent_pid": 6619,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "process.command": "/usr/bin/perl",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "9920ba22d960616e",
  "parent_span_id": "d4d7145e14942b4f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948149547336033,
  "time_end": 1738948150321678561,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.114.6",
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
    "user_agent.original": "curl/8.5.0",
    "http.request.header.user-agent": [
      "curl/8.5.0"
    ],
    "http.request.header.accept": [
      "*/*"
    ],
    "http.request.header.traceparent": [
      "00-be00bb36450c5f9815a4a88908f0d4b0-d4d7145e14942b4f-01"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Fri, 07 Feb 2025 17:09:09 GMT"
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
      "W/\"0bf5e901129eb94eb7a077e4c38083d85d1a517527684909c4d9ef99897dc692\""
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
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "57"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1738951743"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "3"
    ],
    "http.response.header.x-github-request-id": [
      "AB42:1AAADA:1698D3A:2D6AE2A:67A63E35"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 6660,
    "process.parent_pid": 6619,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "process.command": "/usr/bin/perl",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "18dd103aeff4c448",
  "parent_span_id": "beb0a72c3cdf6867",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948149560616277,
  "time_end": 1738948150259146826,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.114.6",
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
    "user_agent.original": "curl/8.5.0",
    "http.request.header.user-agent": [
      "curl/8.5.0"
    ],
    "http.request.header.accept": [
      "*/*"
    ],
    "http.request.header.traceparent": [
      "00-be00bb36450c5f9815a4a88908f0d4b0-beb0a72c3cdf6867-01"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Fri, 07 Feb 2025 17:09:09 GMT"
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
      "W/\"e2b1639b2d31d87af37c8fa3cc78ff2fe57599cbd280c459097f3cf731ff9413\""
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
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "56"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1738951743"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "4"
    ],
    "http.response.header.x-github-request-id": [
      "AB43:29B1E9:15588A7:2AF47A2:67A63E35"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 6661,
    "process.parent_pid": 6619,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "process.command": "/usr/bin/perl",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "4ae515c1f8cbccc1",
  "parent_span_id": "bc3143d9ce9e1428",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948151083600511,
  "time_end": 1738948152103032292,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.113.3",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0-bash/opentelemetry-bash_1.1.0.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.1.0-bash/opentelemetry-bash_1.1.0.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "20e73587aea7f641",
  "parent_span_id": "bc3143d9ce9e1428",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948151199875353,
  "time_end": 1738948152223181650,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.110.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/3670d8da-2091-4597-a302-65e2d57bb65a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250207T170911Z&X-Amz-Expires=300&X-Amz-Signature=49d4ee032fb32bbcea2d65e8d8571655094a73d6087db4a6d6edc12ccd94940d&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-bash_1.1.0.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/3670d8da-2091-4597-a302-65e2d57bb65a",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250207T170911Z&X-Amz-Expires=300&X-Amz-Signature=49d4ee032fb32bbcea2d65e8d8571655094a73d6087db4a6d6edc12ccd94940d&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-bash_1.1.0.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "708"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "448bd174cbd86e81",
  "parent_span_id": "bc3143d9ce9e1428",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948152229659681,
  "time_end": 1738948153253268408,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.113.3",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0/opentelemetry-bash_1.1.0.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.1.0/opentelemetry-bash_1.1.0.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "c6e6669148363329",
  "parent_span_id": "bc3143d9ce9e1428",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948152335656556,
  "time_end": 1738948153373100820,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.110.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/6792b0dc-d1e4-4826-902f-e7444253a550?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250207T170912Z&X-Amz-Expires=300&X-Amz-Signature=d106cd1a081e3771053d1100c3e47c956caa15e6de0875c5ef7b2af3ae7c2502&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-bash_1.1.0.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/6792b0dc-d1e4-4826-902f-e7444253a550",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250207T170912Z&X-Amz-Expires=300&X-Amz-Signature=d106cd1a081e3771053d1100c3e47c956caa15e6de0875c5ef7b2af3ae7c2502&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-bash_1.1.0.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "706"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "fcc1410d0fb7c8a4",
  "parent_span_id": "bc3143d9ce9e1428",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948153379197089,
  "time_end": 1738948154402593607,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.113.3",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.0-zsh/opentelemetry-zsh_1.0.0.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.0.0-zsh/opentelemetry-zsh_1.0.0.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "ae9e82939191c8d2",
  "parent_span_id": "bc3143d9ce9e1428",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948153493739036,
  "time_end": 1738948154503144895,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.110.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/22df411d-ff4c-4fad-bee3-691bec16b0bd?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250207T170913Z&X-Amz-Expires=300&X-Amz-Signature=1c5c64d199b048d2d345d6960550805668ec89367807f11ecdac964414250413&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-zsh_1.0.0.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/22df411d-ff4c-4fad-bee3-691bec16b0bd",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250207T170913Z&X-Amz-Expires=300&X-Amz-Signature=1c5c64d199b048d2d345d6960550805668ec89367807f11ecdac964414250413&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-zsh_1.0.0.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "710"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "d22409ea2e909ee0",
  "parent_span_id": "9cf0acc3b69168cd",
  "name": "HEAD",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1738948143349787602,
  "time_end": 1738948146752226599,
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
      "Fri, 07 Feb 2025 17:09:03 GMT"
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
      "W/\"2042cc5e9e7edc383f188645ae2aa19f97bd6dbe34bfa96919729dcdc52ee0e2\""
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
    "http.response.header.accept-ranges": [
      "bytes"
    ],
    "http.response.header.x-ratelimit-limit": [
      "60"
    ],
    "http.response.header.x-ratelimit-remaining": [
      "59"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1738951743"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "1"
    ],
    "http.response.header.x-github-request-id": [
      "AB40:BF2C6:177C988:2F18BD3:67A63E2F"
    ],
    "http.response.header.connection": [
      "close"
    ],
    "http.response.body.size": 0
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "139f755b9ce65109",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1738948142920633480,
  "time_end": 1738948154546465332,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "d4d7145e14942b4f",
  "parent_span_id": "2e0bb1f796130db1",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948149436498996,
  "time_end": 1738948150325522190,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 6660,
    "process.parent_pid": 6619,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "process.command": "/usr/bin/perl",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "beb0a72c3cdf6867",
  "parent_span_id": "2e0bb1f796130db1",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948149452562827,
  "time_end": 1738948150264150412,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 6661,
    "process.parent_pid": 6619,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "process.command": "/usr/bin/perl",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "2996f862583b620e",
  "parent_span_id": "2e0bb1f796130db1",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948149359413619,
  "time_end": 1738948150070531150,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 6662,
    "process.parent_pid": 6619,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "process.command": "/usr/bin/perl",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "43fedd91443251d7",
  "parent_span_id": "139f755b9ce65109",
  "name": "cut -d   -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142956579003,
  "time_end": 1738948146764990443,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "37b8ab03231e9759",
  "parent_span_id": "139f755b9ce65109",
  "name": "cut -d ; -f1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142968283334,
  "time_end": 1738948146774670470,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "3667747f586f59cc",
  "parent_span_id": "139f755b9ce65109",
  "name": "cut -d = -f 2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142969410464,
  "time_end": 1738948146784172875,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "f0421a35029701b8",
  "parent_span_id": "139f755b9ce65109",
  "name": "cut -d ? -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142979259561,
  "time_end": 1738948146777032331,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "9f924137e1294e6e",
  "parent_span_id": "139f755b9ce65109",
  "name": "grep .deb$",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142976095186,
  "time_end": 1738948150393480132,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "54e9aa795dc203da",
  "parent_span_id": "139f755b9ce65109",
  "name": "grep ^link:",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142968954084,
  "time_end": 1738948146762423209,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "02881cfa844de4ae",
  "parent_span_id": "139f755b9ce65109",
  "name": "grep ^page=",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142969683112,
  "time_end": 1738948146781779644,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "5e9894ce5aa0dc87",
  "parent_span_id": "139f755b9ce65109",
  "name": "grep _1.",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1738948142969235277,
  "time_end": 1738948150397208913,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "be39426e9ad8aa26",
  "parent_span_id": "139f755b9ce65109",
  "name": "grep rel=\"last\"",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142956719114,
  "time_end": 1738948146772317924,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "1e507f65a8f33105",
  "parent_span_id": "139f755b9ce65109",
  "name": "head --lines=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142968421020,
  "time_end": 1738948150336771753,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "7f8476f35b2e82d1",
  "parent_span_id": "139f755b9ce65109",
  "name": "jq .[].assets[].browser_download_url -r",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142975931722,
  "time_end": 1738948150390590532,
  "attributes": {
    "shell.command_line": "jq .[].assets[].browser_download_url -r",
    "shell.command": "jq",
    "shell.command.type": "file",
    "shell.command.name": "jq",
    "subprocess.executable.path": "/usr/bin/jq",
    "subprocess.executable.name": "jq",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "e30637739ff8dfe8",
  "parent_span_id": "139f755b9ce65109",
  "name": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1738948142954751950,
  "time_end": 1738948146757360964,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "b08892087ad78989",
  "parent_span_id": "139f755b9ce65109",
  "name": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142961345499,
  "time_end": 1738948143072028455,
  "attributes": {
    "shell.command_line": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
    "shell.command": "printf",
    "shell.command.type": "builtin",
    "shell.command.name": "printf",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 7
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "9cf0acc3b69168cd",
  "parent_span_id": "e30637739ff8dfe8",
  "name": "send/receive",
  "kind": "PRODUCER",
  "status": "UNSET",
  "time_start": 1738948143080907997,
  "time_end": 1738948146752705850,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "5214b2dbb76892b2",
  "parent_span_id": "02cf5cf33a412481",
  "name": "seq 1 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948147411242224,
  "time_end": 1738948147429977452,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 5204,
    "process.parent_pid": 4380,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs seq 1",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "7bb4301fc19307e2",
  "parent_span_id": "139f755b9ce65109",
  "name": "tr & \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142967982383,
  "time_end": 1738948146779378783,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "3c0c4d1c17a245a1",
  "parent_span_id": "139f755b9ce65109",
  "name": "tr , \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142968551293,
  "time_end": 1738948146769918092,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "52e738100b15f7fd",
  "parent_span_id": "139f755b9ce65109",
  "name": "tr -d  <>",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142969075640,
  "time_end": 1738948146767401586,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "77ac675d2e227664",
  "parent_span_id": "139f755b9ce65109",
  "name": "tr [:upper:] [:lower:]",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142954570932,
  "time_end": 1738948146759908694,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "bc3143d9ce9e1428",
  "parent_span_id": "cb8fb2e2d4a895fd",
  "name": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0-bash/opentelemetry-bash_1.1.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0/opentelemetry-bash_1.1.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.0-zsh/opentelemetry-zsh_1.0.0.deb",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948150992912366,
  "time_end": 1738948154508553703,
  "attributes": {
    "shell.command_line": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0-bash/opentelemetry-bash_1.1.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.1.0/opentelemetry-bash_1.1.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.0-zsh/opentelemetry-zsh_1.0.0.deb",
    "shell.command": "wget",
    "shell.command.type": "file",
    "shell.command.name": "wget",
    "subprocess.executable.path": "/usr/bin/wget",
    "subprocess.executable.name": "wget",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 11264,
    "process.parent_pid": 4378,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
    "process.command": "xargs",
    "process.owner": "runner",
    "process.runtime.name": "bash",
    "process.runtime.description": "Bourne Again Shell",
    "process.runtime.version": "5.2.21-2ubuntu4",
    "process.runtime.options": "hBc",
    "service.version": "",
    "service.namespace": "",
    "service.instance.id": ""
  },
  "links": [],
  "events": []
}
{
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "c1d8fc4109d60766",
  "parent_span_id": "139f755b9ce65109",
  "name": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142968680424,
  "time_end": 1738948150387880499,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "02cf5cf33a412481",
  "parent_span_id": "139f755b9ce65109",
  "name": "xargs seq 1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142968822719,
  "time_end": 1738948147463519620,
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
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
  "trace_id": "be00bb36450c5f9815a4a88908f0d4b0",
  "span_id": "cb8fb2e2d4a895fd",
  "parent_span_id": "139f755b9ce65109",
  "name": "xargs wget",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1738948142969554723,
  "time_end": 1738948154545821512,
  "attributes": {
    "shell.command_line": "xargs wget",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 13
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.2.0",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.2.0",
    "github.workflow.sha": "c791289ed1e5e06975cf7e4004ff2d0aa0d0abaf",
    "github.workflow.name": "Refresh Demos",
    "github.job.name": "generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "os.type": "linux",
    "os.version": "6.8.0-1020-azure",
    "process.pid": 2932,
    "process.parent_pid": 2137,
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
