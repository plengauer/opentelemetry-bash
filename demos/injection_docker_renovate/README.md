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
                      GET
                      POST
                      GET
                      GET
                      GET
                      GET
                      POST
                      POST
                      POST
                      POST
                      POST
                      GET
                      GET
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "90258dbb4892ff8b",
  "parent_span_id": "1cf7c337fe5677d7",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283477609722808,
  "time_end": 1728283477618325749,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "ef94ed8621b0bfba",
  "parent_span_id": "7b7fe09294cf8ad8",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283482488321375,
  "time_end": 1728283482515537775,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "3c4caa9460dfc371",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283483159652899,
  "time_end": 1728283483286703818,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "fb3b9629b45649b7",
  "parent_span_id": "7b7fe09294cf8ad8",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283482528000000,
  "time_end": 1728283482624510572,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "ef9c5941b313bfd1",
  "parent_span_id": "7b7fe09294cf8ad8",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1728283482628000000,
  "time_end": 1728283482662418157,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "53fe42c37129f18b",
  "parent_span_id": "d52909dae77766cd",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283482687000000,
  "time_end": 1728283482849314502,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "5d0128ff6bf6728f",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283483291000000,
  "time_end": 1728283483990171592,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d71f9439cd5adc73",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283484026000000,
  "time_end": 1728283484453563599,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "e816a17423d7fe4b",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283484025000000,
  "time_end": 1728283484477519956,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "2325bc2b2d256ccb",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283484021000000,
  "time_end": 1728283484574119676,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "422daab05105bdbc",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283484471000000,
  "time_end": 1728283484608183974,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "bc6bf097ee4b04cb",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283484024000000,
  "time_end": 1728283484624228082,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "c050bb9c37d82bb5",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283484022000000,
  "time_end": 1728283484842682905,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "9e59291a955ee6b4",
  "parent_span_id": "d52909dae77766cd",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283486067000000,
  "time_end": 1728283486173584347,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "6848f6c63dd0e181",
  "parent_span_id": "d52909dae77766cd",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283487025000000,
  "time_end": 1728283487095530494,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "7b7fe09294cf8ad8",
  "parent_span_id": "b1cef8b483f0c099",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283482054000000,
  "time_end": 1728283482677695088,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "6cec226054db8b16",
  "parent_span_id": "b1cef8b483f0c099",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283482678000000,
  "time_end": 1728283482678182984,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "2ab677f53274466d",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283485072901321,
  "time_end": 1728283485507078338,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "319b959337aac9f9",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283485577811907,
  "time_end": 1728283485613322175,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "2025365f747fa4ec",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283485689115130,
  "time_end": 1728283485731739997,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "eb1aef4de5a6ccd4",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283485806525171,
  "time_end": 1728283485843770312,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "eb0e1a2a35afdaee",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283485915594967,
  "time_end": 1728283485951147443,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "689a0887a4be9281",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283486027578939,
  "time_end": 1728283486064299899,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "15831b6c96ce025b",
  "parent_span_id": "d52909dae77766cd",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283486248631011,
  "time_end": 1728283486284303264,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "7788850826c9a749",
  "parent_span_id": "d6f3f306d0171076",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283487246020937,
  "time_end": 1728283487298215772,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "1a5653c47072688d",
  "parent_span_id": "d6f3f306d0171076",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283487364415010,
  "time_end": 1728283487396922518,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "2912209620e2b9d5",
  "parent_span_id": "d6f3f306d0171076",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283487461726803,
  "time_end": 1728283487500532517,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "8d05d1b149348a7c",
  "parent_span_id": "d6f3f306d0171076",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283487822657295,
  "time_end": 1728283487857559502,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "feed064cc9cc6a25",
  "parent_span_id": "d6f3f306d0171076",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283487923786997,
  "time_end": 1728283487956951414,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "f5fd6df8d98796d7",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488401000000,
  "time_end": 1728283488442940765,
  "attributes": {
    "http.url": "https://pypi.org/pypi/requests/json",
    "http.method": "GET",
    "http.target": "/pypi/requests/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "1dafa463ea9e1e5d",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488402000000,
  "time_end": 1728283488446354089,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-sdk/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-sdk/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "cac0ccad0390803e",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488407000000,
  "time_end": 1728283488448963418,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "4a03246bd6261ee3",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488405000000,
  "time_end": 1728283488449363507,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-docker/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-docker/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "920822caedbed72a",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488404000000,
  "time_end": 1728283488452347502,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "4e43b99e47a5b8da",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488398000000,
  "time_end": 1728283488505027572,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "e5861bdc64e087c3",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488396000000,
  "time_end": 1728283488510208773,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.30.34",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "287b365de5f9583b",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488375000000,
  "time_end": 1728283488511240255,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "2eac4bd0a4a919fd",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488381000000,
  "time_end": 1728283488521575048,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "c2cda89147628736",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488383000000,
  "time_end": 1728283488546201007,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "ef2c904509c38e06",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488377000000,
  "time_end": 1728283488546211349,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "b524284ce3c86023",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488384000000,
  "time_end": 1728283488547600998,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "277b97134786f2a3",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488393000000,
  "time_end": 1728283488566143015,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.1.35",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "b20dcaa974a21d9e",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488379000000,
  "time_end": 1728283488568271025,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "9fb04a96316d0ea8",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488390000000,
  "time_end": 1728283488601142483,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.30.34",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "6b4fd81760815898",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488395000000,
  "time_end": 1728283488642987609,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "5290f0465d8a9053",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488598000000,
  "time_end": 1728283488658194482,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.1.35",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "67232fa148ec775d",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488629000000,
  "time_end": 1728283488678653816,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.30.34",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "7a45e15a5d66dc31",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488574000000,
  "time_end": 1728283488703589996,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "2e70e4f1fab28e6e",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488386000000,
  "time_end": 1728283488705700358,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "ae8b2a384c833690",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488604000000,
  "time_end": 1728283488714452564,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "164c6632f1f0b974",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488600000000,
  "time_end": 1728283488752299747,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "839cf0c322ff7ddb",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488605000000,
  "time_end": 1728283488752740110,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d32576e09de604ad",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488657000000,
  "time_end": 1728283488755249793,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "5182a9666440de1e",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488703000000,
  "time_end": 1728283488796154800,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.30.34",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "bb1a8729185bbfd7",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488632000000,
  "time_end": 1728283488925191021,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "18f9b9feaa7d7e86",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488603000000,
  "time_end": 1728283488926245909,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "8e6f8b59ce6271e1",
  "parent_span_id": "d6f3f306d0171076",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488728000000,
  "time_end": 1728283489047540555,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.1.35",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "8f0696ce4b276583",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488925000000,
  "time_end": 1728283489067095173,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "edcd406c0585d7de",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488924000000,
  "time_end": 1728283489135531535,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d487242ac5d2088b",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489042000000,
  "time_end": 1728283489171059671,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "261a70ff11ba718f",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489045000000,
  "time_end": 1728283489196954245,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "ee15064dbbb8d2d7",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283488716000000,
  "time_end": 1728283489201993881,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "a9ebf971f008f738",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489044000000,
  "time_end": 1728283489224094655,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "cb3586e116b18e09",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489094000000,
  "time_end": 1728283489229313714,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "e477451ef63c6b33",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489177000000,
  "time_end": 1728283489303675203,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "3cf5c9c27ed9b0a9",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489137000000,
  "time_end": 1728283489305728729,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "7c98b296dd2a3360",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489046000000,
  "time_end": 1728283489317876765,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "8a8cdc3b8c1730c6",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489231000000,
  "time_end": 1728283489355561284,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "bcc0aa90e6214664",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489203000000,
  "time_end": 1728283489382237706,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "7b206111986267cf",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489325000000,
  "time_end": 1728283489462705793,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d42ad30df76553a9",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489322000000,
  "time_end": 1728283489543221086,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "c3c34d55db01f998",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489546000000,
  "time_end": 1728283489664819888,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d1aea51635a75e04",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489206000000,
  "time_end": 1728283489703642287,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "24c0dc88e47047d4",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283489707000000,
  "time_end": 1728283490220676413,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "9a7c28b5b96c298e",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283490224000000,
  "time_end": 1728283490650556858,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "77ac58a9dfe93a22",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283490654000000,
  "time_end": 1728283491094524951,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "aa0092044a85767e",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283491098000000,
  "time_end": 1728283491456436151,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "db097077a37f9e65",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283491459000000,
  "time_end": 1728283491918862768,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d76c555ebdf0ad93",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283491922000000,
  "time_end": 1728283492366276781,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "1d5868efb83daa31",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283492369000000,
  "time_end": 1728283492823523272,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "45466fc05d94e141",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283492826000000,
  "time_end": 1728283493290739801,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "4bbe04a61d4c4a16",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283493294000000,
  "time_end": 1728283493750778976,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "89897dbee4cb54e0",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283493754000000,
  "time_end": 1728283494103141907,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "a6fef59716a68ca9",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283494106000000,
  "time_end": 1728283494679519232,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "53acd3c77b26a67c",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283494682000000,
  "time_end": 1728283494896709943,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d828bfb3f5b54467",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283494916000000,
  "time_end": 1728283495103361370,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "f05f4fbb8ed6e116",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283495108000000,
  "time_end": 1728283495388662420,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "953635d7477f96b9",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283495391000000,
  "time_end": 1728283495570291029,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "237785e26a0e441c",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283495573000000,
  "time_end": 1728283495740862400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "ddd69129830d3669",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283495743000000,
  "time_end": 1728283495991561777,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "fba8214acd8c2d6a",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283495993000000,
  "time_end": 1728283496226604471,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "eaef7db905d55645",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283496229000000,
  "time_end": 1728283496491916037,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "7df3d1256b9ec227",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283496494000000,
  "time_end": 1728283496729458612,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "f519ffc6907cf41d",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283496731000000,
  "time_end": 1728283496982789374,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "84a795c3da1f979d",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283496985000000,
  "time_end": 1728283497193704499,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "6e2a42617db1ab93",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283497196000000,
  "time_end": 1728283497426540211,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "31461645d8346329",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283497429000000,
  "time_end": 1728283497608151829,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "a4b0c9ac333f9d21",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283497611000000,
  "time_end": 1728283497830548826,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "3a95255ac0484f93",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283497832000000,
  "time_end": 1728283498039347729,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "b2ceb290f1b3df06",
  "parent_span_id": "d6f3f306d0171076",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728283498042000000,
  "time_end": 1728283498147875132,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.110.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d6f3f306d0171076",
  "parent_span_id": "d52909dae77766cd",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283487097000000,
  "time_end": 1728283498750165594,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "eebacecd67cbdc3c",
  "parent_span_id": "d52909dae77766cd",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283498750000000,
  "time_end": 1728283498750423817,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "589191a33912e20c",
  "parent_span_id": "d52909dae77766cd",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283498751000000,
  "time_end": 1728283498751518815,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "d52909dae77766cd",
  "parent_span_id": "b1cef8b483f0c099",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283482678000000,
  "time_end": 1728283498770454799,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "b1cef8b483f0c099",
  "parent_span_id": "f3b5ffa0fe67f54f",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283482053000000,
  "time_end": 1728283498833442017,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.110.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "fc82003c2da908ce",
  "parent_span_id": "d6f3f306d0171076",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283498711107608,
  "time_end": 1728283498748951310,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "f3b5ffa0fe67f54f",
  "parent_span_id": "fbf975e5d6342a6f",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283479141353253,
  "time_end": 1728283498876349706,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "fbf975e5d6342a6f",
  "parent_span_id": "1b27a1c7c42576a2",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283478262735338,
  "time_end": 1728283498879287633,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "1b27a1c7c42576a2",
  "parent_span_id": "90258dbb4892ff8b",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283477921829883,
  "time_end": 1728283498880933984,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "1cf7c337fe5677d7",
  "parent_span_id": "b0408e3b76ecbebb",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283477182827034,
  "time_end": 1728283498882296341,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "b0408e3b76ecbebb",
  "parent_span_id": "84dfb6f2577e90ae",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283454315407994,
  "time_end": 1728283498958305980,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3539,
    "process.parent_pid": 3538,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "84dfb6f2577e90ae",
  "parent_span_id": "dbbf62762a81b3fb",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728283453709308093,
  "time_end": 1728283498994077751,
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
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2851,
    "process.parent_pid": 2753,
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
  "trace_id": "12a65add982844eba52654eb63f6419d",
  "span_id": "dbbf62762a81b3fb",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1728283453696722705,
  "time_end": 1728283498994228324,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.32.0",
    "service.name": "unknown_service",
    "github.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11209364906",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "f9b703d9ffe3aabd2beba9e85c1fd79fa356f055",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2851,
    "process.parent_pid": 2753,
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
