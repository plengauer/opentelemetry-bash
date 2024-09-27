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
                    git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git
                    POST
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    POST
                    GET
                    git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .
                    git -c core.quotePath=false rev-parse HEAD
                    git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    extract
                      git -c core.quotePath=false checkout -f main --
                      git -c core.quotePath=false rev-parse HEAD
                      git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1
                      git -c core.quotePath=false reset --hard
                      git -c core.quotePath=false ls-tree -r main
                      GET
                      GET
                      GET
                      GET
                      GET
                      GET
                      GET
                      POST
                      GET
                      POST
                      POST
                      POST
                      GET
                      GET
                      POST
                      POST
                      GET
                      GET
                      GET
                      POST
                      POST
                      GET
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "9778f49a1a542a0d",
  "parent_span_id": "6826e48f53f7cb71",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437494447472709,
  "time_end": 1727437494455969968,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "188c67c0b856caeb",
  "parent_span_id": "c6c8b019b9f23316",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437499289319560,
  "time_end": 1727437499317391324,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "e1ee3d1f24a331d1",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437499921325508,
  "time_end": 1727437500031450105,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "fb34af080292c280",
  "parent_span_id": "c6c8b019b9f23316",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437499330000000,
  "time_end": 1727437499416168760,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "24a873ba422f7ac8",
  "parent_span_id": "c6c8b019b9f23316",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1727437499419000000,
  "time_end": 1727437499453527915,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "0bb3e155358568ae",
  "parent_span_id": "c8167be169529cc9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437499478000000,
  "time_end": 1727437499614556857,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2158723edcac6390",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437500036000000,
  "time_end": 1727437500547805484,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2a5bdee3aefe510e",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437500584000000,
  "time_end": 1727437500946899843,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "582133a70386c56e",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437500583000000,
  "time_end": 1727437500965134702,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "3d2824a3d9ece687",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437500580000000,
  "time_end": 1727437501139002735,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "cbe76c6ca7214360",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437500579000000,
  "time_end": 1727437501172740983,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "67450107ec9516a4",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437500582000000,
  "time_end": 1727437501396838730,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "0d93f912a06d0606",
  "parent_span_id": "c8167be169529cc9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437502440000000,
  "time_end": 1727437502553330747,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "dcd532e2be956b84",
  "parent_span_id": "c8167be169529cc9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437503360000000,
  "time_end": 1727437503478105049,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "c6c8b019b9f23316",
  "parent_span_id": "3e4ab599f41eb332",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437498871000000,
  "time_end": 1727437499468710014,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "fd526737c59fd4f5",
  "parent_span_id": "3e4ab599f41eb332",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437499469000000,
  "time_end": 1727437499469181921,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "406e038076d42cd5",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437501598317474,
  "time_end": 1727437501943129129,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "446dc5951808ba9f",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437502009736236,
  "time_end": 1727437502041358881,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "c1aedba820889a99",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437502106950765,
  "time_end": 1727437502144664368,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "6eeda554daacecf3",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437502209519160,
  "time_end": 1727437502241104526,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "ff16bb8f35d7703b",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437502308239270,
  "time_end": 1727437502339948900,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "a8a81ea4c0390576",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437502406317701,
  "time_end": 1727437502437816533,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "c492bbbc60af5ff5",
  "parent_span_id": "c8167be169529cc9",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437502621258226,
  "time_end": 1727437502654909105,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "466846e0dd3913df",
  "parent_span_id": "c87c6554277030a3",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437503621596048,
  "time_end": 1727437503667959755,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "4ae9bad642f2c977",
  "parent_span_id": "c87c6554277030a3",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437503733106905,
  "time_end": 1727437503763717874,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "94bb2a9649d7b445",
  "parent_span_id": "c87c6554277030a3",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437503828701879,
  "time_end": 1727437503866722849,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "05956e08c9dd9159",
  "parent_span_id": "c87c6554277030a3",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437504177604900,
  "time_end": 1727437504212217521,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "81a8055ee14c5206",
  "parent_span_id": "c87c6554277030a3",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437504277595742,
  "time_end": 1727437504309860063,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "d16e232b7e24623b",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504745000000,
  "time_end": 1727437504770621087,
  "attributes": {
    "http.url": "https://pypi.org/pypi/requests/json",
    "http.method": "GET",
    "http.target": "/pypi/requests/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.0.223",
    "net.peer.port": 443,
    "http.response_content_length": 37099,
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "b285c43b5fc75f26",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504746000000,
  "time_end": 1727437504771008679,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-sdk/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-sdk/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.128.223",
    "net.peer.port": 443,
    "http.response_content_length": 17640,
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "559361716bf4dec3",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504748000000,
  "time_end": 1727437504778701790,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.64.223",
    "net.peer.port": 443,
    "http.response_content_length": 10182,
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "5ed174c12a668e3e",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504749000000,
  "time_end": 1727437504780016060,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-docker/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-docker/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.64.223",
    "net.peer.port": 443,
    "http.response_content_length": 3204,
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "63e0902e4bc4f404",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504750000000,
  "time_end": 1727437504798163984,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.192.223",
    "net.peer.port": 443,
    "http.response_content_length": 3759,
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "0c6ce70602318839",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504740000000,
  "time_end": 1727437504818685166,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.2.35",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "f62d45f0b2a0da8d",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504742000000,
  "time_end": 1727437504819901527,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "1934b15926babf14",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504728000000,
  "time_end": 1727437504870845605,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "4eda6c9cef3bb154",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504737000000,
  "time_end": 1727437504888656381,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "9051975f0b8c417a",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504729000000,
  "time_end": 1727437504890288587,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "4c785a8f2dc47e74",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504721000000,
  "time_end": 1727437504913919932,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "e0bc0097d70565dd",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504725000000,
  "time_end": 1727437504914364137,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "0b72b0260bdae00b",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504735000000,
  "time_end": 1727437504929939758,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "9dd1987812f1b6c0",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504739000000,
  "time_end": 1727437504963833053,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "0047826fb59818c5",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504727000000,
  "time_end": 1727437504966399829,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "72405427d939650d",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504723000000,
  "time_end": 1727437504995315470,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "cdb451e7a028558c",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504947000000,
  "time_end": 1727437505024449139,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "8db96a27ec46c1d7",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504964000000,
  "time_end": 1727437505048449712,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "f0c25a3b99280995",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504913000000,
  "time_end": 1727437505063149477,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "803e87d31d11c208",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504915000000,
  "time_end": 1727437505063100716,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "140479458a2a040c",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504953000000,
  "time_end": 1727437505085650664,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "a87f12611fdad5ba",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505048000000,
  "time_end": 1727437505107683587,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "7d5115b3cabe00b6",
  "parent_span_id": "c87c6554277030a3",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505024000000,
  "time_end": 1727437505113639971,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "765effa217706a54",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504969000000,
  "time_end": 1727437505130614436,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "aa709796e30804c8",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504979000000,
  "time_end": 1727437505159576580,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "1d24950d050db827",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437504731000000,
  "time_end": 1727437505175842510,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "699251bc57694de8",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505028000000,
  "time_end": 1727437505176783273,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "acd64a36ab465630",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505050000000,
  "time_end": 1727437505291860356,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "b520963ed4bcd287",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505290000000,
  "time_end": 1727437505415182614,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "df9b617c02aeda13",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505291000000,
  "time_end": 1727437505447023728,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "1bde4a52c08c40fb",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505384000000,
  "time_end": 1727437505509574097,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "59fb598b673f5a9e",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505420000000,
  "time_end": 1727437505528129640,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "b26546646023c396",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505386000000,
  "time_end": 1727437505579271761,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "6a88865fe62b75aa",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505452000000,
  "time_end": 1727437505604221412,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "886013c722390d9b",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505289000000,
  "time_end": 1727437505667187216,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "992e2e8419754281",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505385000000,
  "time_end": 1727437505667438173,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "7472f680dd0858ac",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505515000000,
  "time_end": 1727437505668674447,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "04295a47b190d7b1",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505180000000,
  "time_end": 1727437505726135307,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2575a6a850257436",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505585000000,
  "time_end": 1727437505740591457,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "bdaab216e9110fba",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505684000000,
  "time_end": 1727437505845946760,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "a23a25a698d9e4e9",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505672000000,
  "time_end": 1727437505862418711,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "36d77ba18059db0e",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505868000000,
  "time_end": 1727437506081588423,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "0299d9687677efe9",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437506086000000,
  "time_end": 1727437506221114192,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "020d76adeac45403",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437505730000000,
  "time_end": 1727437506284046413,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "8f45a367d873a191",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437506288000000,
  "time_end": 1727437506668413317,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "9268b98a68e49845",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437506673000000,
  "time_end": 1727437507031119147,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "8eb31ee8e6b75801",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437507036000000,
  "time_end": 1727437507801529320,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2bff4287177643b4",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437507805000000,
  "time_end": 1727437508236819859,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "010fc47b1c14ec14",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437508241000000,
  "time_end": 1727437508766914009,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "f1ac79d9bea718a6",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437508771000000,
  "time_end": 1727437509307190188,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "5f66b4201e5ddfff",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437509310000000,
  "time_end": 1727437509837062315,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "1bb350b59c2cd133",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437509840000000,
  "time_end": 1727437510276287898,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "d02a84af8c3f1380",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437510279000000,
  "time_end": 1727437510727353155,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "4b4bbc2e480a9f1e",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437510730000000,
  "time_end": 1727437511215348576,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "f1d6c7e5d878a0c3",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437511219000000,
  "time_end": 1727437511604635538,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "e89bd782cc1197f9",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437511607000000,
  "time_end": 1727437511826099753,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "3fc2a01f2f56df24",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437511843000000,
  "time_end": 1727437512111487289,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "54abd48823cdeeb0",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437512117000000,
  "time_end": 1727437512412297459,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "a2d667ab8133d400",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437512414000000,
  "time_end": 1727437512667861456,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "a1d73d04f9d40bb2",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437512670000000,
  "time_end": 1727437512890095803,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "50821411d0faf2f3",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437512892000000,
  "time_end": 1727437513096407904,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2762354ea7cc0ea0",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437513099000000,
  "time_end": 1727437513448548810,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "16fcbf2cc1aa0ce1",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437513451000000,
  "time_end": 1727437513646211053,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "46d16d2340147216",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437513648000000,
  "time_end": 1727437513947084250,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "4fcd07a0888ca10e",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437513949000000,
  "time_end": 1727437514230557278,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2df75fd51c16d572",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437514233000000,
  "time_end": 1727437514479686398,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "b2adff06522997f9",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437514482000000,
  "time_end": 1727437514735795661,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "39a4c7b25501a87d",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437514738000000,
  "time_end": 1727437515059867317,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "4b519c4f457182b6",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437515062000000,
  "time_end": 1727437515305747509,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "fae66be9d674dad3",
  "parent_span_id": "c87c6554277030a3",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727437515308000000,
  "time_end": 1727437515591361508,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.98.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.5",
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
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "c87c6554277030a3",
  "parent_span_id": "c8167be169529cc9",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437503479000000,
  "time_end": 1727437516176144821,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "663d855e2a013486",
  "parent_span_id": "c8167be169529cc9",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437516176000000,
  "time_end": 1727437516176350787,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "d086d5391b5d81c3",
  "parent_span_id": "c8167be169529cc9",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437516176000000,
  "time_end": 1727437516176531777,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "c8167be169529cc9",
  "parent_span_id": "3e4ab599f41eb332",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437499469000000,
  "time_end": 1727437516192813896,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "3e4ab599f41eb332",
  "parent_span_id": "9adba52bca378e04",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437498870000000,
  "time_end": 1727437516246620918,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.98.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "18220b5a06cd80d2",
  "parent_span_id": "c87c6554277030a3",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437516136426348,
  "time_end": 1727437516174576472,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "9adba52bca378e04",
  "parent_span_id": "1ddcf213ef99c1c7",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437495960540907,
  "time_end": 1727437516287431050,
  "attributes": {
    "shell.command_line": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel.sh",
    "code.lineno": 403,
    "code.function": "_otel_inject"
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "1ddcf213ef99c1c7",
  "parent_span_id": "e274dc411d2c143c",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437495094835896,
  "time_end": 1727437516290276436,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "e274dc411d2c143c",
  "parent_span_id": "9778f49a1a542a0d",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437494760826416,
  "time_end": 1727437516291906992,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "6826e48f53f7cb71",
  "parent_span_id": "dae6e40798e103ed",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437494024823499,
  "time_end": 1727437516293257902,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "dae6e40798e103ed",
  "parent_span_id": "2aecf0d11e854c66",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437471042404487,
  "time_end": 1727437516360105192,
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
    "process.pid": 3399,
    "process.parent_pid": 3398,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "2aecf0d11e854c66",
  "parent_span_id": "753677e13768ccd3",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727437470437247846,
  "time_end": 1727437516393402522,
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
    "process.pid": 2711,
    "process.parent_pid": 2617,
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
  "trace_id": "7b99ff0fff7f5b807abfc8a3730ca576",
  "span_id": "753677e13768ccd3",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1727437470424858179,
  "time_end": 1727437516393571208,
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
    "process.pid": 2711,
    "process.parent_pid": 2617,
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
