# Demo "Injection into the dockerized Renovate Bot"
This script manually runs the renovate bot, injects deeply into both the docker container and the node process within.
## Script
```sh
export RENOVATE_TOKEN="$GITHUB_TOKEN"
. otel.sh
sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash
```
## Trace Structure Overview
```
bash -e demo.sh
  sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash
    docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash
      /bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash
        exec
          dumb-init -- renovate --dry-run plengauer/opentelemetry-bash
            /bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash
              node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash
                run
                  config
                    git --version
                    GET
                    GET
                  discover
                  repository
                    POST
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    POST
                    git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git
                    git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .
                    git -c core.quotePath=false rev-parse HEAD
                    git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    GET
                    extract
                      git -c core.quotePath=false checkout -f main --
                      GET
                      GET
                      GET
                      GET
                      POST
                      POST
                      GET
                      GET
                      POST
                      POST
                      GET
                      POST
                      GET
                      POST
                      POST
                      POST
                      GET
                      POST
                      GET
                      GET
                      POST
                      POST
                      POST
                      POST
                      GET
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      git -c core.quotePath=false rev-parse HEAD
                      git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1
                      git -c core.quotePath=false reset --hard
                      git -c core.quotePath=false ls-tree -r main
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20
                    onboarding
                    update
```
## Full Trace
```
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "dcd08071c02506fd",
  "parent_span_id": "3f42eebaef00b72e",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996590838322629,
  "time_end": 1728996590847161213,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a3a35b8c6a090a59",
  "parent_span_id": "e1ad5b4e3c17ccef",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996596220634276,
  "time_end": 1728996596253052937,
  "attributes": {
    "shell.command_line": "git --version",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "89c1bea88b5fda7d",
  "parent_span_id": "e1ad5b4e3c17ccef",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996596267000000,
  "time_end": 1728996596392448739,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "ed2a05df589c567d",
  "parent_span_id": "e1ad5b4e3c17ccef",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1728996596396000000,
  "time_end": 1728996596441170972,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 404,
    "http.status_text": "NOT FOUND",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "5d8e93139ab9c0b2",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996596467000000,
  "time_end": 1728996596621853970,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "f7a22a61df5aa364",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996597182000000,
  "time_end": 1728996598608905650,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a4e9974e6e495fd2",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996598647000000,
  "time_end": 1728996599146675095,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "c29c7fd46f5518e5",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996598642000000,
  "time_end": 1728996599251816031,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "20509cff23e93ff8",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996598645000000,
  "time_end": 1728996599266563931,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a051197bffb1f8b9",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996598644000000,
  "time_end": 1728996599370020225,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "1e994966034caae5",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996598642000000,
  "time_end": 1728996599454185291,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "8ace3280f658be25",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996599160000000,
  "time_end": 1728996599476769621,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "8523d54e64989655",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996600598000000,
  "time_end": 1728996600693503748,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "e1ad5b4e3c17ccef",
  "parent_span_id": "ec8b68f8aa4c130b",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996595690000000,
  "time_end": 1728996596457299236,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "ca1bc2ff9ff4e81a",
  "parent_span_id": "ec8b68f8aa4c130b",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996596458000000,
  "time_end": 1728996596458225442,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "d4b94881e7b89a40",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996597043411877,
  "time_end": 1728996597177412531,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "48da9e9d96eb3c11",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996599696567174,
  "time_end": 1728996600102242568,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "9d0bd2fc3c65d0a6",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996600168233033,
  "time_end": 1728996600199031412,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false rev-parse HEAD",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "568c55f48adbf2ca",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996600263994722,
  "time_end": 1728996600302823732,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "67a23de79b1150be",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996600367800208,
  "time_end": 1728996600400459311,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false ls-tree -r main",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "31b173e9e7c5f379",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996600466643337,
  "time_end": 1728996600498421600,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false ls-tree -r main",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "28457d5dfd882047",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996600563352130,
  "time_end": 1728996600595154947,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false ls-tree -r main",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "37cf2e770ca5f5ce",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996600760973251,
  "time_end": 1728996600792703224,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false ls-tree -r main",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "b06ae116c2adc33f",
  "parent_span_id": "530609bc3c516a6f",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996601749899955,
  "time_end": 1728996601804671468,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false checkout -f main --",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "d5b6286858f8c7d3",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996601512000000,
  "time_end": 1728996601603577358,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.response_content_length_uncompressed": 2,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "bffe795713599c14",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602991000000,
  "time_end": 1728996603043444097,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.64.223",
    "net.peer.port": 443,
    "http.response_content_length": 14702,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "b2d325bba6f8d250",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602988000000,
  "time_end": 1728996603043627796,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-distro/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-distro/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.192.223",
    "net.peer.port": 443,
    "http.response_content_length": 12231,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "b07defaeacbc4c11",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603011000000,
  "time_end": 1728996603101518486,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.25.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "7311bb3c147e5044",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603010000000,
  "time_end": 1728996603114998299,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.3.35",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "64d4c4cb9e28c9e1",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602997000000,
  "time_end": 1728996603138517184,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "0b5a3d2b0a1683c8",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602996000000,
  "time_end": 1728996603139410799,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "25a1bcef9ad4487b",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603006000000,
  "time_end": 1728996603158483923,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.31.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "d0d760d982cac0aa",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603005000000,
  "time_end": 1728996603168937051,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.27.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "fb1e7aafcba6c647",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602993000000,
  "time_end": 1728996603169232275,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "bb424fab077a506e",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603001000000,
  "time_end": 1728996603195920486,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "9a686c4cb1ee286f",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603137000000,
  "time_end": 1728996603197322684,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.3.35",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "e5dea20d8b064462",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602999000000,
  "time_end": 1728996603213325329,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a823b22e4504aaef",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603008000000,
  "time_end": 1728996603242582046,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.26.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "577eab842837faf3",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603168000000,
  "time_end": 1728996603271197548,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "9390460006c9a0e2",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603163000000,
  "time_end": 1728996603287186085,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "7bac8096e52accaa",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602994000000,
  "time_end": 1728996603287121492,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a6296f6f46d8de83",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603285000000,
  "time_end": 1728996603369757712,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.31.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "bce6368c5f95defa",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996602998000000,
  "time_end": 1728996603371254797,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "5cd49e2cac9fa879",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603240000000,
  "time_end": 1728996603373732445,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.3.35",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "b0db386fa10e7e74",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603270000000,
  "time_end": 1728996603383480857,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.26.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "152d4503c6db200c",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603295000000,
  "time_end": 1728996603459184355,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "df02370b08e983d1",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603292000000,
  "time_end": 1728996603461718244,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "92ab62827dcc5653",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603314000000,
  "time_end": 1728996603630700572,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "04b09ececc02a392",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603372000000,
  "time_end": 1728996603630461959,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "ca46f96a2f8dc79b",
  "parent_span_id": "530609bc3c516a6f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603190000000,
  "time_end": 1728996603631117248,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.27.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "c20d7cb39d6016c0",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603628000000,
  "time_end": 1728996603800813898,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "ef5eeb60c935ad76",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603629000000,
  "time_end": 1728996603801378683,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "393f8cd8e739a3ab",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603808000000,
  "time_end": 1728996603920957135,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "0a84f9a991f34cf8",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603810000000,
  "time_end": 1728996603948741211,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "f7942a7e6e8630aa",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603377000000,
  "time_end": 1728996604042187157,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a4f6f16d3f12efdb",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603627000000,
  "time_end": 1728996604042889242,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "70c26443a6201c47",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603798000000,
  "time_end": 1728996604043402351,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a3a2062701901fb9",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603800000000,
  "time_end": 1728996604043810390,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "cebe82307eab282c",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996603799000000,
  "time_end": 1728996604066880016,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "e96adec9cb4bbc01",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604057000000,
  "time_end": 1728996604186285363,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "668e730eb361553f",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604051000000,
  "time_end": 1728996604221296399,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "32d818577fd1d41c",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604058000000,
  "time_end": 1728996604236267528,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "b90ca0ebad81cf29",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604073000000,
  "time_end": 1728996604288043585,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "16a4b996eb326cf0",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604227000000,
  "time_end": 1728996604469048135,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "abb99dad4a1f00c5",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604048000000,
  "time_end": 1728996604630042275,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "392208a1a89bf5a2",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604472000000,
  "time_end": 1728996604741340864,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a970c871a9262b51",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996604633000000,
  "time_end": 1728996605139212376,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "021a511dffc6cf3c",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996605142000000,
  "time_end": 1728996605546094338,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "4c2cb9634b88fff0",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996605551000000,
  "time_end": 1728996605950539980,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "c0d6078e6005d7d6",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996605954000000,
  "time_end": 1728996606424690612,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "86eeb1111cf73950",
  "parent_span_id": "530609bc3c516a6f",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996601871827893,
  "time_end": 1728996601902825518,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false rev-parse HEAD",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a9c6bdf9a65135d7",
  "parent_span_id": "530609bc3c516a6f",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996601968323208,
  "time_end": 1728996602005827939,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "0069550be78f5df1",
  "parent_span_id": "530609bc3c516a6f",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996602387408695,
  "time_end": 1728996602422645851,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false reset --hard",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "c0402deac704ad79",
  "parent_span_id": "530609bc3c516a6f",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996602488939163,
  "time_end": 1728996602522036173,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false ls-tree -r main",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "8e69985dcd8d5e47",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996606427000000,
  "time_end": 1728996606914782916,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "6833845784014843",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996606918000000,
  "time_end": 1728996607405663626,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "62eafb1deffd5212",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996607408000000,
  "time_end": 1728996607882274040,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "091839085717c163",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996607885000000,
  "time_end": 1728996608239702142,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "111a3e9e4bff541b",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996608243000000,
  "time_end": 1728996608594495128,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "da70f5014084b7a2",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996608598000000,
  "time_end": 1728996608960257665,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "71be07d6aaba0337",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996608963000000,
  "time_end": 1728996609497089328,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "838418b11f63986c",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996609500000000,
  "time_end": 1728996609651429215,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "f8e2d166f5f1d0dc",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996609671000000,
  "time_end": 1728996609894631802,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "95f7f731f4718528",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996609899000000,
  "time_end": 1728996610084989721,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "cdf86958b33f2515",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996610087000000,
  "time_end": 1728996610302083920,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "e49b6934abc837f8",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996610304000000,
  "time_end": 1728996610537263951,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "70ade67f1309c590",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996610540000000,
  "time_end": 1728996610787341110,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "5f6742794941920a",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996610789000000,
  "time_end": 1728996611037843473,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "12a256095d26200d",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996611040000000,
  "time_end": 1728996611264053903,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "dbe665281a6e2b39",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996611267000000,
  "time_end": 1728996611540682665,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a0eac6c20ca7096c",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996611544000000,
  "time_end": 1728996611819553695,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "812f095ff7bd5bc6",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996611822000000,
  "time_end": 1728996612009483552,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "55ce2246f9cdccb7",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996612011000000,
  "time_end": 1728996612291783894,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "15035d72d203247d",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996612295000000,
  "time_end": 1728996612546248490,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "8cf6f69763e1a07a",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996612548000000,
  "time_end": 1728996612764136854,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "70e63b3f4ec024bb",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996612767000000,
  "time_end": 1728996612989045064,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "bc2f49040216bbe1",
  "parent_span_id": "530609bc3c516a6f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728996612991000000,
  "time_end": 1728996613094599126,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.124.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "530609bc3c516a6f",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996601605000000,
  "time_end": 1728996613690431125,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "f8072b2687e7ab3a",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996613690000000,
  "time_end": 1728996613690387736,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "4fb10860adfbaacb",
  "parent_span_id": "4a582e3f9e23ca97",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996613691000000,
  "time_end": 1728996613691551923,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "4a582e3f9e23ca97",
  "parent_span_id": "ec8b68f8aa4c130b",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996596458000000,
  "time_end": 1728996613708184719,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "ec8b68f8aa4c130b",
  "parent_span_id": "22b62935bb12c2c7",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996595689000000,
  "time_end": 1728996613761429648,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.124.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "4df0297684667863",
  "parent_span_id": "530609bc3c516a6f",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996613651500957,
  "time_end": 1728996613689027127,
  "attributes": {
    "shell.command_line": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
    "shell.command": "git",
    "shell.command.type": "file",
    "shell.command.name": "git",
    "subprocess.executable.path": "/usr/bin/git",
    "subprocess.executable.name": "git",
    "shell.command.exit_code": 0,
    "code.filepath": "node"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "22b62935bb12c2c7",
  "parent_span_id": "05f9b6c5d44c41f4",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996592721844315,
  "time_end": 1728996613801126003,
  "attributes": {
    "shell.command_line": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel.sh",
    "code.lineno": 419,
    "code.function": "_otel_inject"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "05f9b6c5d44c41f4",
  "parent_span_id": "893c71093b9ef5ac",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996591615588863,
  "time_end": 1728996613804015631,
  "attributes": {
    "shell.command_line": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
    "shell.command": "/bin/bash",
    "shell.command.type": "file",
    "shell.command.name": "bash",
    "subprocess.executable.path": "/bin/bash",
    "subprocess.executable.name": "bash",
    "shell.command.exit_code": 0,
    "code.filepath": "dumb-init"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "893c71093b9ef5ac",
  "parent_span_id": "dcd08071c02506fd",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996591214862119,
  "time_end": 1728996613805632155,
  "attributes": {
    "shell.command_line": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
    "shell.command": "dumb-init",
    "shell.command.type": "file",
    "shell.command.name": "dumb-init",
    "subprocess.executable.path": "/usr/bin/dumb-init",
    "subprocess.executable.name": "dumb-init",
    "shell.command.exit_code": 0,
    "code.filepath": "sh"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "3f42eebaef00b72e",
  "parent_span_id": "a106f915c0871bba",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996590315717594,
  "time_end": 1728996613806906963,
  "attributes": {
    "shell.command_line": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
    "shell.command": "/bin/bash",
    "shell.command.type": "file",
    "shell.command.name": "bash",
    "subprocess.executable.path": "/bin/bash",
    "subprocess.executable.name": "bash",
    "shell.command.exit_code": 0,
    "code.filepath": "sh"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "a106f915c0871bba",
  "parent_span_id": "4a3ca581cb1b3634",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996566812845731,
  "time_end": 1728996613881889345,
  "attributes": {
    "shell.command_line": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "shell.command": "docker",
    "shell.command.type": "file",
    "shell.command.name": "docker",
    "subprocess.executable.path": "/usr/bin/docker",
    "subprocess.executable.name": "docker",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3640,
    "process.parent_pid": 3639,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "4a3ca581cb1b3634",
  "parent_span_id": "aff3a1523a3f0df0",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728996566117176861,
  "time_end": 1728996613915854770,
  "attributes": {
    "shell.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "shell.command": "sudo",
    "shell.command.type": "file",
    "shell.command.name": "sudo",
    "subprocess.executable.path": "/usr/bin/sudo",
    "subprocess.executable.name": "sudo",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2810,
    "process.parent_pid": 2712,
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
  "trace_id": "32c482050287a5b99d0ff945f902e958",
  "span_id": "aff3a1523a3f0df0",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1728996566104747656,
  "time_end": 1728996613915991496,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.34.0",
    "service.name": "unknown_service",
    "github.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11344820771",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "b1ffa029fe3f15951942626b4b912b82215d4471",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2810,
    "process.parent_pid": 2712,
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
