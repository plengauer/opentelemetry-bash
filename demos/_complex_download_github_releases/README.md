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
  xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::
    /usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2
        GET
  jq .[].assets[].browser_download_url -r
  head --lines=3
  grep .deb$
  grep _1.
  xargs wget
    wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.3/opentelemetry-shell_1.10.3.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.2/opentelemetry-shell_1.10.2.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.1/opentelemetry-shell_1.10.1.deb
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "56ea5264ae13a49c",
  "parent_span_id": "c92092aea245bf76",
  "name": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167357287447040,
  "time_end": 1741167359504824064,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 5784,
    "process.parent_pid": 4412,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "3de361a5c8aac9ef",
  "parent_span_id": "458c232c66756f4d",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167358627394816,
  "time_end": 1741167359260926464,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.113.6",
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
      "00-22988313660e8b88cfbd7709f4f7e0d6-458c232c66756f4d-01"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Wed, 05 Mar 2025 09:35:58 GMT"
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
      "W/\"8f9a00c5a9fdb024591dc0f3d66553e53e4da28b94d4148c23cade8a414afdd8\""
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
      "54"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1741169871"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "6"
    ],
    "http.response.header.x-github-request-id": [
      "CAC1:349D4F:1C5A255:3940A37:67C81AFE"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 6593,
    "process.parent_pid": 6552,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "bf99da4bae97746b",
  "parent_span_id": "735fda90cc2779e1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167358705273088,
  "time_end": 1741167359369833472,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.113.6",
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
      "00-22988313660e8b88cfbd7709f4f7e0d6-735fda90cc2779e1-01"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Wed, 05 Mar 2025 09:35:58 GMT"
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
      "W/\"11a971c6bff328861a500dc97ac6d906d3fdfacb332953ec56172aaacb299b8e\""
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
      "53"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1741169871"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "7"
    ],
    "http.response.header.x-github-request-id": [
      "CAC2:1D9F82:1E3D317:3CFAAFC:67C81AFE"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 6595,
    "process.parent_pid": 6552,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "04d4fd69c49d0e7d",
  "parent_span_id": "a47bf58f7ac77850",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167358708889088,
  "time_end": 1741167359485648640,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.113.6",
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
      "00-22988313660e8b88cfbd7709f4f7e0d6-a47bf58f7ac77850-01"
    ],
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Wed, 05 Mar 2025 09:35:59 GMT"
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
      "W/\"1b2e3c8e63ea5df088d8bb370cea9e868d9d46d679b4b9a1396ecd35050dd59b\""
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
      "52"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1741169871"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "8"
    ],
    "http.response.header.x-github-request-id": [
      "CAC3:3054ED:1E7A74E:3D6AE55:67C81AFE"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 6594,
    "process.parent_pid": 6552,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "87201d7da83b739e",
  "parent_span_id": "c23c84f3510474fe",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167360276730624,
  "time_end": 1741167361307280640,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.114.4",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.3/opentelemetry-shell_1.10.3.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.10.3/opentelemetry-shell_1.10.3.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "6e445e7440e8fe9e",
  "parent_span_id": "c23c84f3510474fe",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167360507655680,
  "time_end": 1741167361344385024,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.111.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/3831e6be-ab1d-4cd4-b097-3dc7bb24e220?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250305T093600Z&X-Amz-Expires=300&X-Amz-Signature=05f011540dd11f3220090afa9a8e389a101fd00731e672907b6535e781d43445&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.10.3.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/3831e6be-ab1d-4cd4-b097-3dc7bb24e220",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250305T093600Z&X-Amz-Expires=300&X-Amz-Signature=05f011540dd11f3220090afa9a8e389a101fd00731e672907b6535e781d43445&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.10.3.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "6322"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "59a98e40377436e8",
  "parent_span_id": "c23c84f3510474fe",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167361327999232,
  "time_end": 1741167361433027328,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.114.4",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.2/opentelemetry-shell_1.10.2.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.10.2/opentelemetry-shell_1.10.2.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "82a37018d581dc8b",
  "parent_span_id": "c23c84f3510474fe",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167361425941504,
  "time_end": 1741167361502188544,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.111.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/776833e7-57fc-4c7f-bb7c-0de36548a71e?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250305T093601Z&X-Amz-Expires=300&X-Amz-Signature=9f33d67c549f37ff33cda78a15ac216f2aa9f96516000ffe29cc28ff4f03bd3c&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.10.2.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/776833e7-57fc-4c7f-bb7c-0de36548a71e",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250305T093601Z&X-Amz-Expires=300&X-Amz-Signature=9f33d67c549f37ff33cda78a15ac216f2aa9f96516000ffe29cc28ff4f03bd3c&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.10.2.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "6210"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "5b57c77d6e165d60",
  "parent_span_id": "c23c84f3510474fe",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167361482758912,
  "time_end": 1741167361591927552,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.114.4",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.1/opentelemetry-shell_1.10.1.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.10.1/opentelemetry-shell_1.10.1.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "ea7c6a3df79a60a1",
  "parent_span_id": "c23c84f3510474fe",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167361584526336,
  "time_end": 1741167361650227712,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.111.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/d327a834-339e-4f0c-8e38-32dc3e5bdcc6?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250305T093601Z&X-Amz-Expires=300&X-Amz-Signature=19da8fee70ba38ca3ffefdf41b2664124c81e60b6ce0f9e083a9751061be447c&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.10.1.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/d327a834-339e-4f0c-8e38-32dc3e5bdcc6",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250305T093601Z&X-Amz-Expires=300&X-Amz-Signature=19da8fee70ba38ca3ffefdf41b2664124c81e60b6ce0f9e083a9751061be447c&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.10.1.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "6200"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "df1e30b44ebefbf2",
  "parent_span_id": "f856114e99432c03",
  "name": "HEAD",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1741167352555804928,
  "time_end": 1741167355888430080,
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
      "Wed, 05 Mar 2025 09:35:52 GMT"
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
      "W/\"d666e56cba09d9452356c3dd6656c90a55f7a22257b9750445c2da1ee494281b\""
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
      "55"
    ],
    "http.response.header.x-ratelimit-reset": [
      "1741169871"
    ],
    "http.response.header.x-ratelimit-resource": [
      "core"
    ],
    "http.response.header.x-ratelimit-used": [
      "5"
    ],
    "http.response.header.x-github-request-id": [
      "CAC0:2F3C04:1E0646E:3C852EF:67C81AF8"
    ],
    "http.response.header.connection": [
      "close"
    ],
    "http.response.body.size": 0
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "562086388cc02661",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1741167352143250176,
  "time_end": 1741167361694885888,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "458c232c66756f4d",
  "parent_span_id": "56ea5264ae13a49c",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167358517403136,
  "time_end": 1741167359266354176,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 6593,
    "process.parent_pid": 6552,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "a47bf58f7ac77850",
  "parent_span_id": "56ea5264ae13a49c",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167358611659776,
  "time_end": 1741167359489557760,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 6594,
    "process.parent_pid": 6552,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "735fda90cc2779e1",
  "parent_span_id": "56ea5264ae13a49c",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167358603310336,
  "time_end": 1741167359374089472,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 6595,
    "process.parent_pid": 6552,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "d3a6a86e472025d8",
  "parent_span_id": "562086388cc02661",
  "name": "cut -d   -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352177161984,
  "time_end": 1741167355901277952,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "47f0bc0a53babd88",
  "parent_span_id": "562086388cc02661",
  "name": "cut -d ; -f1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352173300480,
  "time_end": 1741167355911227904,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "74cdf8f7cb337efe",
  "parent_span_id": "562086388cc02661",
  "name": "cut -d = -f 2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352179152128,
  "time_end": 1741167355921004544,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "615995df10023193",
  "parent_span_id": "562086388cc02661",
  "name": "cut -d ? -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352194632192,
  "time_end": 1741167355913692672,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "9ba32e396c8f718f",
  "parent_span_id": "562086388cc02661",
  "name": "grep .deb$",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352207560448,
  "time_end": 1741167359551328256,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "6834635463a6a4c8",
  "parent_span_id": "562086388cc02661",
  "name": "grep ^link:",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352173173760,
  "time_end": 1741167355898782976,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "c378342b4992b25c",
  "parent_span_id": "562086388cc02661",
  "name": "grep ^page=",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352195034624,
  "time_end": 1741167355918572800,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "5873fc8b3a0176d5",
  "parent_span_id": "562086388cc02661",
  "name": "grep _1.",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1741167352196863744,
  "time_end": 1741167359555019264,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "bb63bba113532773",
  "parent_span_id": "562086388cc02661",
  "name": "grep rel=\"last\"",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352161048832,
  "time_end": 1741167355908803584,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "4f9470bed9566f3d",
  "parent_span_id": "562086388cc02661",
  "name": "head --lines=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352196715776,
  "time_end": 1741167359551187968,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "0358f3b0734aa900",
  "parent_span_id": "562086388cc02661",
  "name": "jq .[].assets[].browser_download_url -r",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352194476288,
  "time_end": 1741167359548576512,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "585796eb06b5679f",
  "parent_span_id": "562086388cc02661",
  "name": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1741167352180400384,
  "time_end": 1741167355893645824,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "7355f5d3d4c00c6e",
  "parent_span_id": "562086388cc02661",
  "name": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352172748032,
  "time_end": 1741167352267200000,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "f856114e99432c03",
  "parent_span_id": "585796eb06b5679f",
  "name": "send/receive",
  "kind": "PRODUCER",
  "status": "UNSET",
  "time_start": 1741167352302456064,
  "time_end": 1741167355888932352,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "2b48f29b2322a0d8",
  "parent_span_id": "1081a1425d8e835b",
  "name": "seq 1 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167356557047808,
  "time_end": 1741167356575904000,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 5152,
    "process.parent_pid": 4360,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "d6f9b7851f64ef2e",
  "parent_span_id": "562086388cc02661",
  "name": "tr & \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352172915456,
  "time_end": 1741167355916115712,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "05c89bd7821186f6",
  "parent_span_id": "562086388cc02661",
  "name": "tr , \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352188995584,
  "time_end": 1741167355906271744,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "002b4803e225d9bc",
  "parent_span_id": "562086388cc02661",
  "name": "tr -d  <>",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352173044736,
  "time_end": 1741167355903860224,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "7e5e62515c52da8d",
  "parent_span_id": "562086388cc02661",
  "name": "tr [:upper:] [:lower:]",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352179296512,
  "time_end": 1741167355896239104,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "c23c84f3510474fe",
  "parent_span_id": "fbe89035afaffe01",
  "name": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.3/opentelemetry-shell_1.10.3.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.2/opentelemetry-shell_1.10.2.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.1/opentelemetry-shell_1.10.1.deb",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167360200260352,
  "time_end": 1741167361655653120,
  "attributes": {
    "shell.command_line": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.3/opentelemetry-shell_1.10.3.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.2/opentelemetry-shell_1.10.2.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.10.1/opentelemetry-shell_1.10.1.deb",
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 11178,
    "process.parent_pid": 4349,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "c92092aea245bf76",
  "parent_span_id": "562086388cc02661",
  "name": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352203057920,
  "time_end": 1741167359545450240,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "1081a1425d8e835b",
  "parent_span_id": "562086388cc02661",
  "name": "xargs seq 1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352194876672,
  "time_end": 1741167356612166912,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
  "trace_id": "22988313660e8b88cfbd7709f4f7e0d6",
  "span_id": "fbe89035afaffe01",
  "parent_span_id": "562086388cc02661",
  "name": "xargs wget",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1741167352213473792,
  "time_end": 1741167361694241024,
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
    "telemetry.sdk.version": "5.7.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/refresh_demos.yaml@refs/tags/v5.7.1",
    "github.actions.workflow.sha": "3a17794bd62b26a9e1bf323f47747a5b7a1d33e5",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 2888,
    "process.parent_pid": 2152,
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
