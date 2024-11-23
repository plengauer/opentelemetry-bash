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
    wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.2.0/opentelemetry-shell_1.2.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.5/opentelemetry-shell_1.0.5.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.4/opentelemetry-shell_1.0.4.deb
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "869f8cd065b7a22f",
  "parent_span_id": "0b542a0c1e645a4c",
  "name": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279284024010000,
  "time_end": 1732279291650371600,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 5817,
    "process.parent_pid": 4452,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "bce069c4bc5ce52b",
  "parent_span_id": "adaf018444154a8c",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279285506311700,
  "time_end": 1732279291472233000,
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
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Fri, 22 Nov 2024 12:41:25 GMT"
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
      "W/\"cf31ecf1d93fbff092a3a5cb585dca4be264e5ec3ab73b1e30ef31a14bad0494\""
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
      "1732282447"
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
      "D441:2FE8CD:7FAE16:80BF43:67407BF5"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 6643,
    "process.parent_pid": 6581,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "4add9b2182b5ac76",
  "parent_span_id": "dc61135c3d9ea78a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279285597946400,
  "time_end": 1732279291630624500,
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
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Fri, 22 Nov 2024 12:41:25 GMT"
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
      "W/\"a029bfaf7a64dfd5906a712db794e40bc68ac99662a6e3c91f2de46d87d068ab\""
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
      "1732282447"
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
      "D442:1DABDC:73E424:74F4BD:67407BF5"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 6641,
    "process.parent_pid": 6581,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "72b86d6852d9dfba",
  "parent_span_id": "8a2ff4e2bdbb9f98",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279285635722500,
  "time_end": 1732279288758245400,
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
    "http.response.status_code": 200,
    "http.response.header.date": [
      "Fri, 22 Nov 2024 12:41:25 GMT"
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
      "W/\"8a96e1e2984db332fce3f279d1042f8897f20ac5dfb91377dd966ac79c754cc6\""
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
      "1732282447"
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
      "D443:30C27B:79D7F5:7AE898:67407BF5"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 6645,
    "process.parent_pid": 6581,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "20846fb5e0ead31c",
  "parent_span_id": "9998fdde6f940cfa",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279292400480500,
  "time_end": 1732279293421164300,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.116.3",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.2.0/opentelemetry-shell_1.2.0.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.2.0/opentelemetry-shell_1.2.0.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "6fa5f2d82d054eae",
  "parent_span_id": "9998fdde6f940cfa",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279292585144000,
  "time_end": 1732279293746451000,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.109.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/32a4c112-e682-4bf7-80f4-206e39fd3188?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241122T124132Z&X-Amz-Expires=300&X-Amz-Signature=2755042d5578d677f5c62b131f2992edb98eaf13c729716c2ab102965216e9c1&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.2.0.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/32a4c112-e682-4bf7-80f4-206e39fd3188",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241122T124132Z&X-Amz-Expires=300&X-Amz-Signature=2755042d5578d677f5c62b131f2992edb98eaf13c729716c2ab102965216e9c1&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.2.0.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "4750"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "075b48639d38c01d",
  "parent_span_id": "9998fdde6f940cfa",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279293755605200,
  "time_end": 1732279294779959300,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.116.3",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.5/opentelemetry-shell_1.0.5.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.0.5/opentelemetry-shell_1.0.5.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "769c26c60db37d0b",
  "parent_span_id": "9998fdde6f940cfa",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279293939732500,
  "time_end": 1732279295092718300,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.109.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/9dc28fde-47de-496b-8b37-1102f47f13d5?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241122T124133Z&X-Amz-Expires=300&X-Amz-Signature=7bd7afd88e370323d2ad7937219e0c8a078599ed844eac793766b5a3a5335e96&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.0.5.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/9dc28fde-47de-496b-8b37-1102f47f13d5",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241122T124133Z&X-Amz-Expires=300&X-Amz-Signature=7bd7afd88e370323d2ad7937219e0c8a078599ed844eac793766b5a3a5335e96&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.0.5.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "4716"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "fa9a9978fc0983d3",
  "parent_span_id": "9998fdde6f940cfa",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279295100266200,
  "time_end": 1732279296124071400,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.116.3",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.4/opentelemetry-shell_1.0.4.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.0.4/opentelemetry-shell_1.0.4.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "e77c6a5ec9fc84d6",
  "parent_span_id": "9998fdde6f940cfa",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279295292384000,
  "time_end": 1732279296418182000,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.109.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/c34b19bf-7dc5-4a6c-b92e-5ccb1e0832d6?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241122T124135Z&X-Amz-Expires=300&X-Amz-Signature=636101e9a31d034515a40c65c77f3186220d08ce71460c1c3d9c7477c1669804&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.0.4.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/c34b19bf-7dc5-4a6c-b92e-5ccb1e0832d6",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241122%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241122T124135Z&X-Amz-Expires=300&X-Amz-Signature=636101e9a31d034515a40c65c77f3186220d08ce71460c1c3d9c7477c1669804&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.0.4.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200,
    "http.response.header.content-type": [
      "application/octet-stream"
    ],
    "http.response.header.content-length": [
      "4720"
    ]
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "422e28944b99e6bf",
  "parent_span_id": "9625ccb0d0c8569a",
  "name": "HEAD",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1732279279130248200,
  "time_end": 1732279282609100500,
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
      "Fri, 22 Nov 2024 12:41:19 GMT"
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
      "W/\"fe77e2ede7a592b0f78da20312dd9dfdd2ea37fd42e8cabf00e60942c76860e1\""
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
      "1732282447"
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
      "D440:1DABDC:73C942:74D9C7:67407BEE"
    ],
    "http.response.header.connection": [
      "close"
    ],
    "http.response.body.size": 0
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "f67dd6e60451e6d2",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1732279278620421000,
  "time_end": 1732279296460931600,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "dc61135c3d9ea78a",
  "parent_span_id": "869f8cd065b7a22f",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279285460765000,
  "time_end": 1732279291634545200,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 6641,
    "process.parent_pid": 6581,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "adaf018444154a8c",
  "parent_span_id": "869f8cd065b7a22f",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279285375954200,
  "time_end": 1732279291476226000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 6643,
    "process.parent_pid": 6581,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "8a2ff4e2bdbb9f98",
  "parent_span_id": "869f8cd065b7a22f",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279285500612000,
  "time_end": 1732279288763114000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 6645,
    "process.parent_pid": 6581,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "7cf53690b9df5ce0",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "cut -d   -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278693705000,
  "time_end": 1732279282621883000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "ce3312dbcefa987d",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "cut -d ; -f1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278678082000,
  "time_end": 1732279282631871000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "912e8904b8647049",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "cut -d = -f 2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278649524200,
  "time_end": 1732279282641479700,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "47ba282100578d4d",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "cut -d ? -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278679005200,
  "time_end": 1732279282634260500,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "6bfca7f7bf0896c3",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "grep .deb$",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278660812300,
  "time_end": 1732279291699852800,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "918947f8628c49cc",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "grep ^link:",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278681967600,
  "time_end": 1732279282619522300,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "227409854793b0a4",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "grep ^page=",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278662474000,
  "time_end": 1732279282639114200,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "ecbb218f1a2e3992",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "grep _1.",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1732279278678431000,
  "time_end": 1732279291703580400,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "d171961a7a546814",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "grep rel=\"last\"",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278645847000,
  "time_end": 1732279282629325800,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "1065b68c94dd9a20",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "head --lines=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278678872800,
  "time_end": 1732279291648294400,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "9e7c1f21f43099fe",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "jq .[].assets[].browser_download_url -r",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278678721500,
  "time_end": 1732279291697000200,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "57a3c6f85fa38781",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1732279278659186000,
  "time_end": 1732279282614462000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "7dccc452daa29d17",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278658987300,
  "time_end": 1732279278764161000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "9625ccb0d0c8569a",
  "parent_span_id": "57a3c6f85fa38781",
  "name": "send/receive",
  "kind": "PRODUCER",
  "status": "UNSET",
  "time_start": 1732279278789012700,
  "time_end": 1732279282609586700,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "8439a741b02e6dfd",
  "parent_span_id": "091b5e4c357f2bea",
  "name": "seq 1 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279283285492500,
  "time_end": 1732279283304795400,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 5189,
    "process.parent_pid": 4380,
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "e091c4deb8c5a799",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "tr & \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278679482600,
  "time_end": 1732279282636732700,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "7e6d768c65b87c71",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "tr , \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278662641200,
  "time_end": 1732279282626846000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "6089933511653b93",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "tr -d  <>",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278660638200,
  "time_end": 1732279282624393500,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "3d2f6c76e2a4034d",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "tr [:upper:] [:lower:]",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278678276600,
  "time_end": 1732279282617019100,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "9998fdde6f940cfa",
  "parent_span_id": "2b1bfc9cfe898948",
  "name": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.2.0/opentelemetry-shell_1.2.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.5/opentelemetry-shell_1.0.5.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.4/opentelemetry-shell_1.0.4.deb",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279292323815000,
  "time_end": 1732279296423272200,
  "attributes": {
    "shell.command_line": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.2.0/opentelemetry-shell_1.2.0.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.5/opentelemetry-shell_1.0.5.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.0.4/opentelemetry-shell_1.0.4.deb",
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 25496,
    "process.parent_pid": 4384,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "xargs wget",
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
  "links": [],
  "events": []
}
{
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "0b542a0c1e645a4c",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278681785000,
  "time_end": 1732279291693591000,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "091b5e4c357f2bea",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "xargs seq 1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278679242500,
  "time_end": 1732279283339670500,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
  "trace_id": "f9742639ac63ac50c825dac31ca741da",
  "span_id": "2b1bfc9cfe898948",
  "parent_span_id": "f67dd6e60451e6d2",
  "name": "xargs wget",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1732279278678576600,
  "time_end": 1732279296460301300,
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
    "telemetry.sdk.version": "4.40.0",
    "service.name": "unknown_service",
    "github.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11969599531",
    "github.workflow.run.attempt": "2",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "6b7d4d865470d5c92812c790db367815af92a6cc",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2929,
    "process.parent_pid": 2721,
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
