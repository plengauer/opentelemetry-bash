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
                      POST
                      POST
                      POST
                      POST
                      POST
                      GET
                      GET
                      GET
                      GET
                      GET
                      GET
                      POST
                      POST
                      POST
                      POST
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
                      git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20
                    onboarding
                    update
```
## Full Trace
```
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "d50945295342f216",
  "parent_span_id": "02fe9a0d86b0298c",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686369695457694,
  "time_end": 1727686369703954429,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "b4307eba0da2f692",
  "parent_span_id": "d3b8fec5d99f1be2",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686374540076659,
  "time_end": 1727686374568260448,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2e2f027cf256857f",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686375278643618,
  "time_end": 1727686375467301517,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1fe5b62b94a726a5",
  "parent_span_id": "d3b8fec5d99f1be2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686374581000000,
  "time_end": 1727686374752912405,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "14374d3e40728781",
  "parent_span_id": "d3b8fec5d99f1be2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1727686374756000000,
  "time_end": 1727686374815846174,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "67fbbc0a708f3cc7",
  "parent_span_id": "160c4da874ee6e87",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686374840000000,
  "time_end": 1727686374971107617,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "cac3bfbbe1d360b7",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686375472000000,
  "time_end": 1727686376218007947,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2ac09c3991ece741",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686376246000000,
  "time_end": 1727686376752385257,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "f18bc3b50eb0e03d",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686376241000000,
  "time_end": 1727686376808946896,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "6ed0c8611b96b89a",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686376245000000,
  "time_end": 1727686376826733327,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "7a5768e0247f02d8",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686376243000000,
  "time_end": 1727686376941529575,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "384ec78e32350409",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686376241000000,
  "time_end": 1727686377006802973,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "9d1ddc4cda0373ad",
  "parent_span_id": "160c4da874ee6e87",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686378344000000,
  "time_end": 1727686378457603468,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "650dc0440ff8cb61",
  "parent_span_id": "160c4da874ee6e87",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686379281000000,
  "time_end": 1727686379372268047,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "d3b8fec5d99f1be2",
  "parent_span_id": "4a7822cbfb0f8520",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686374121000000,
  "time_end": 1727686374831902977,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "e364676e210b4104",
  "parent_span_id": "4a7822cbfb0f8520",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686374832000000,
  "time_end": 1727686374832210765,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "5875ccc40d861ce5",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686377208606976,
  "time_end": 1727686377853580814,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "813677402815640a",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686377917948140,
  "time_end": 1727686377948725011,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "335f6e4656695b20",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686378015798184,
  "time_end": 1727686378053436290,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2bf4c4d26bcac659",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686378118183648,
  "time_end": 1727686378150322735,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "7f9a3c9337f30451",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686378214636261,
  "time_end": 1727686378245984249,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "07464580f3a17d36",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686378309854617,
  "time_end": 1727686378341332226,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "77769d94dd10fea4",
  "parent_span_id": "160c4da874ee6e87",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686378524797422,
  "time_end": 1727686378556613755,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "e8ba948b92ca84f6",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686379514752876,
  "time_end": 1727686379564160902,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1b130ef49801d1a0",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686379628463258,
  "time_end": 1727686379659252039,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "ac5e6a99a56e9ffe",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686379723542962,
  "time_end": 1727686379761416177,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "fe0f8f05cc281553",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686380071817408,
  "time_end": 1727686380106031400,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "243a553979aca4fd",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686380170675567,
  "time_end": 1727686380203300925,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "aaee1204b3841ed0",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380634000000,
  "time_end": 1727686380653365692,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-docker/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-docker/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.0.223",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "24a1a1ccecdc5a31",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380629000000,
  "time_end": 1727686380662742953,
  "attributes": {
    "http.url": "https://pypi.org/pypi/requests/json",
    "http.method": "GET",
    "http.target": "/pypi/requests/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.128.223",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1d2fc40823fc451a",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380635000000,
  "time_end": 1727686380666333361,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.64.223",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "5ff83f2f5c2a97de",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380631000000,
  "time_end": 1727686380667625040,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-sdk/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-sdk/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.0.223",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "d9a433b4715e37e9",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380632000000,
  "time_end": 1727686380668047428,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.192.223",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "126d94ddd0fb6b57",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380627000000,
  "time_end": 1727686380690830483,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "15dbc78d69008c7a",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380625000000,
  "time_end": 1727686380704457253,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.28.34",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "cbd9de17558d2d79",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380605000000,
  "time_end": 1727686380775389049,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "8304de5de840aeb7",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380611000000,
  "time_end": 1727686380842810109,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "64dbf81f0d03d903",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380612000000,
  "time_end": 1727686380843492113,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "21af26905512c4f3",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380614000000,
  "time_end": 1727686380845146336,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "9d22558e30829d9b",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380610000000,
  "time_end": 1727686380845858749,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "3a79ef48603f501f",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380608000000,
  "time_end": 1727686380846265226,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "4137457744da4dc2",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380622000000,
  "time_end": 1727686380867153253,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1e782a35e4d701f0",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380620000000,
  "time_end": 1727686380905059697,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "92a59f2e41d3b92f",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380623000000,
  "time_end": 1727686380932705165,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "a42b479c72787c82",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380897000000,
  "time_end": 1727686380969248363,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "3cc03fd8f0abdf60",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380930000000,
  "time_end": 1727686380999087494,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "36c0184887f46e00",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381000000000,
  "time_end": 1727686381045162475,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "75a7492ac96deb05",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380904000000,
  "time_end": 1727686381053065832,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "ecc0cfeeaced27ef",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380907000000,
  "time_end": 1727686381052981747,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "064f54e502901ca3",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380616000000,
  "time_end": 1727686381054064805,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "a34716c250af205b",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380883000000,
  "time_end": 1727686381062537379,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "d0ffa60dcf748cdb",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380901000000,
  "time_end": 1727686381067267913,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "def7cd823e49b45f",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380902000000,
  "time_end": 1727686381092166622,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "0a82618dbe5c1e88",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380954000000,
  "time_end": 1727686381096244181,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "9b5720cfe156ba02",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381014000000,
  "time_end": 1727686381121368845,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "ac102c21b7e2ffa5",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686380905000000,
  "time_end": 1727686381154937070,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2aeceb7930105165",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381277000000,
  "time_end": 1727686381419243658,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "3e347c04a84402fc",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381276000000,
  "time_end": 1727686381424344551,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "d40253bfe8019962",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381275000000,
  "time_end": 1727686381528235407,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "7dd3f6c76ccbea12",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381061000000,
  "time_end": 1727686381535268706,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "6192b37cc82fbc8c",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381385000000,
  "time_end": 1727686381549372433,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2271ccff413d3c35",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381431000000,
  "time_end": 1727686381576156212,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "7aff34e8240ea2c4",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381426000000,
  "time_end": 1727686381591916183,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "f1feeeb0f18e5590",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381387000000,
  "time_end": 1727686381592643443,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "21d19643ca34d234",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381388000000,
  "time_end": 1727686381670724266,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "7b4624302da2702f",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381530000000,
  "time_end": 1727686381694071092,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "ed125c3e8d5e933e",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381555000000,
  "time_end": 1727686381716356648,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1852330202195866",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381673000000,
  "time_end": 1727686381856218081,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "b0c41503e1818b80",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381679000000,
  "time_end": 1727686381879355972,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "59a50e90ae64d2f7",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381700000000,
  "time_end": 1727686381974118369,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "be383779c2a1d884",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381539000000,
  "time_end": 1727686381976776678,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "a03600f2dbbaa04d",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381978000000,
  "time_end": 1727686382107734174,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "abbd19a042c22c65",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686381982000000,
  "time_end": 1727686382460968173,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "f294febeaef65f27",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686382465000000,
  "time_end": 1727686382866326515,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "371f44d688aac222",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686382870000000,
  "time_end": 1727686383395065948,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "b3205c1948446ce7",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686383398000000,
  "time_end": 1727686383800339444,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "5a65fd427a0b50d0",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686383804000000,
  "time_end": 1727686384411113239,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "b67f812c2f0b89c6",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686384414000000,
  "time_end": 1727686384863913593,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "126e21167e20b086",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686384867000000,
  "time_end": 1727686385319524696,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "6a37780c19bd121b",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686385323000000,
  "time_end": 1727686386070543211,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "b6324b8b0000d15f",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686386073000000,
  "time_end": 1727686386652182570,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "59ffafdf210a8cf1",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686386657000000,
  "time_end": 1727686387204401219,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "cb2ee967a53f489e",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686387207000000,
  "time_end": 1727686387752708781,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "829d27d9436a5cc9",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686387756000000,
  "time_end": 1727686388050056413,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "acd2a6e6909ff7af",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686388067000000,
  "time_end": 1727686388369482059,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "8aa4276dd9b46b87",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686388375000000,
  "time_end": 1727686388608656661,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "fd42a35c974c5967",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686388610000000,
  "time_end": 1727686388826011238,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "3f63ce939c7526cf",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686388828000000,
  "time_end": 1727686389062769130,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "d4d944efd7b8c93e",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686389065000000,
  "time_end": 1727686389417030583,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "180ef236b2bf46fa",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686389420000000,
  "time_end": 1727686389660440092,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2de5830e9addd60b",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686389662000000,
  "time_end": 1727686389953501750,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1d10a55484dd7c06",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686389956000000,
  "time_end": 1727686390237626389,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "8b10f82509e2c40c",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686390240000000,
  "time_end": 1727686390479708743,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "12d4db20498784a5",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686390482000000,
  "time_end": 1727686390768090158,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "e2bc3d739496ae7f",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686390770000000,
  "time_end": 1727686391013662250,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "b1db3f8ffebbafb7",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686391016000000,
  "time_end": 1727686391267831630,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "2fd194c1ae9b1cff",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686391270000000,
  "time_end": 1727686391541322849,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "3e49ab7e49749fb3",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1727686391543000000,
  "time_end": 1727686391784051833,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.101.1 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "e2f95b1022be7d9f",
  "parent_span_id": "160c4da874ee6e87",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686379373000000,
  "time_end": 1727686392369477141,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "1b8127a7d1c04fa3",
  "parent_span_id": "160c4da874ee6e87",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686392370000000,
  "time_end": 1727686392370386894,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "c385241348a0dcb5",
  "parent_span_id": "160c4da874ee6e87",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686392370000000,
  "time_end": 1727686392370507590,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "160c4da874ee6e87",
  "parent_span_id": "4a7822cbfb0f8520",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686374832000000,
  "time_end": 1727686392386985405,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "4a7822cbfb0f8520",
  "parent_span_id": "11b02c4dc5348e7d",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686374120000000,
  "time_end": 1727686392444113915,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.101.1"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "6ddd9122f51f1bf2",
  "parent_span_id": "e2f95b1022be7d9f",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686392331044750,
  "time_end": 1727686392368059423,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "11b02c4dc5348e7d",
  "parent_span_id": "4ea60359c0c3eea5",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686371195727457,
  "time_end": 1727686392481251041,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "4ea60359c0c3eea5",
  "parent_span_id": "119ab02169a03059",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686370336878558,
  "time_end": 1727686392484030906,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "119ab02169a03059",
  "parent_span_id": "d50945295342f216",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686370004883595,
  "time_end": 1727686392485666781,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "02fe9a0d86b0298c",
  "parent_span_id": "abfe2ac65a4779fa",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686369275405468,
  "time_end": 1727686392486919327,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "abfe2ac65a4779fa",
  "parent_span_id": "8efe810bdf232e7f",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686346032149252,
  "time_end": 1727686392553657419,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3400,
    "process.parent_pid": 3399,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "8efe810bdf232e7f",
  "parent_span_id": "74375bca175d5753",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1727686345406787635,
  "time_end": 1727686392587573617,
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
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2712,
    "process.parent_pid": 2620,
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
  "trace_id": "b78cb3e22498511b3ac619053dab5c57",
  "span_id": "74375bca175d5753",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1727686345394152586,
  "time_end": 1727686392587736472,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.31.2",
    "service.name": "unknown_service",
    "github.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11101791154",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "72c1e8bf0e19a2595e88116e30fe96e5d1a98b39",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2712,
    "process.parent_pid": 2620,
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
