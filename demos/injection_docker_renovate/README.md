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
                    git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .
                    git -c core.quotePath=false rev-parse HEAD
                    git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1
                    POST
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    POST
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    GET
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
                      POST
                      POST
                      POST
                      GET
                      GET
                      POST
                      GET
                      POST
                      GET
                      GET
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
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
                      git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20
                    onboarding
                    update
```
## Full Trace
```
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "509acea4273769af",
  "parent_span_id": "707025152bf03f49",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781353346918771,
  "time_end": 1728781353355585360,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "bd8a993e758c28e6",
  "parent_span_id": "deacfce6e9daff1e",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781358742294088,
  "time_end": 1728781358771223498,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "7b8e4b34bd8bfdcd",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781359675667693,
  "time_end": 1728781360055101744,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "f59d28fc53d58ccd",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781362042935584,
  "time_end": 1728781363184854762,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "47114ea460e0237b",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781363260973790,
  "time_end": 1728781363296099951,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "b9907c0b38eb2ce8",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781363371347787,
  "time_end": 1728781363414138298,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "3d47cc14c2c5e82c",
  "parent_span_id": "deacfce6e9daff1e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781358784000000,
  "time_end": 1728781359032214264,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "354931950eda03f2",
  "parent_span_id": "deacfce6e9daff1e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1728781359036000000,
  "time_end": 1728781359123606044,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "f05e24133c6a5ee4",
  "parent_span_id": "478da0b0be038ef2",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781359153000000,
  "time_end": 1728781359301856578,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "df4f8a26e84d4816",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781360060000000,
  "time_end": 1728781360754608592,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "cf62410f50ddcbab",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781360789000000,
  "time_end": 1728781361452485866,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "c25d29eac6ef3dd9",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781360784000000,
  "time_end": 1728781361547145991,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "22d975dc6a569477",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781360788000000,
  "time_end": 1728781361582738740,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "348a9e600c10a9fc",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781360785000000,
  "time_end": 1728781361657508473,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "debc23d20188d71f",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781361466000000,
  "time_end": 1728781361737820420,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "bfc2310e734c6381",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781360787000000,
  "time_end": 1728781361810553319,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "42c1853bd8364136",
  "parent_span_id": "478da0b0be038ef2",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781363750000000,
  "time_end": 1728781363892395992,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "deacfce6e9daff1e",
  "parent_span_id": "15d24f6cb8087ecd",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781358239000000,
  "time_end": 1728781359144049856,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "9f440f4980e71022",
  "parent_span_id": "15d24f6cb8087ecd",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781359144000000,
  "time_end": 1728781359144194362,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "dbc7e27fff21eb3a",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781363490656368,
  "time_end": 1728781363526927188,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "926e98db1285e440",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781363600566236,
  "time_end": 1728781363637972411,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "9b26f1c9a831b885",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781363709908948,
  "time_end": 1728781363746421586,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "f68fd3f94446f62a",
  "parent_span_id": "478da0b0be038ef2",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781363963810973,
  "time_end": 1728781363999481540,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "923deca1c3477708",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781365038139042,
  "time_end": 1728781365088859660,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "94ddd5eee77efb4e",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781365155666272,
  "time_end": 1728781365186520943,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "3ed62827252c0f62",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781365250956258,
  "time_end": 1728781365289161965,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "5ac5779764d4d8d9",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781365664306449,
  "time_end": 1728781365698606385,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "9f38b19b6264b963",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781365764617463,
  "time_end": 1728781365798088418,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "576dfd9b5f02c7a0",
  "parent_span_id": "478da0b0be038ef2",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781364766000000,
  "time_end": 1728781364889933164,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "1ea132f5aa775d07",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366266000000,
  "time_end": 1728781366380207326,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "532cca323774c63b",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366264000000,
  "time_end": 1728781366384269207,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-distro/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-distro/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.128.223",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "3c7df918532744bd",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366286000000,
  "time_end": 1728781366391468901,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.29.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "81dc9be131b87f86",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366284000000,
  "time_end": 1728781366433279236,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "05f2861c557fc112",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366270000000,
  "time_end": 1728781366433961350,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "a3bc8fe6cf522073",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366272000000,
  "time_end": 1728781366444559213,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "27f083267594f9f0",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366268000000,
  "time_end": 1728781366474501685,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "8fc0b6ecd75e096c",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366281000000,
  "time_end": 1728781366477530500,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "17784bfeeeb3f7a3",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366279000000,
  "time_end": 1728781366491540903,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.29.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "d229e500d9a6e2fc",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366269000000,
  "time_end": 1728781366525027915,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "6f57f48706a45dd7",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366473000000,
  "time_end": 1728781366564878754,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "02a35cdcb9edf4e8",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366273000000,
  "time_end": 1728781366614609071,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "493005c5c7c67cfb",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366524000000,
  "time_end": 1728781366631681915,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.29.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "d4f3157b992a9d95",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366564000000,
  "time_end": 1728781366636802695,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "1ee015f899e78d91",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366490000000,
  "time_end": 1728781366644271656,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "ad212f084f856e0a",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366482000000,
  "time_end": 1728781366645522877,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "c05df44128458e9d",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366276000000,
  "time_end": 1728781366656052944,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "4611cffaa6afd6b2",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366274000000,
  "time_end": 1728781366703880997,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "bd5a1e67ee2d7129",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366528000000,
  "time_end": 1728781366721382752,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "1d509f144bc8a0b9",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366598000000,
  "time_end": 1728781366794346188,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "023162b5734b3f4c",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366283000000,
  "time_end": 1728781366797481571,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "068d58a956e1dad9",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366707000000,
  "time_end": 1728781366913786273,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "3b8fb768d73db66b",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366712000000,
  "time_end": 1728781366914305452,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "9d0445160a279cfe",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366596000000,
  "time_end": 1728781366946103862,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "88b4d9bce484004f",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366613000000,
  "time_end": 1728781367146286527,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.29.34",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "bf2358c3882b0b9a",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366911000000,
  "time_end": 1728781367146151080,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "12bf8efd47c45763",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366617000000,
  "time_end": 1728781367163525180,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "24b1125bfa5df2a2",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781366910000000,
  "time_end": 1728781367255310856,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "43e705e147963c93",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367139000000,
  "time_end": 1728781367333012243,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "fece685a4df72570",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367138000000,
  "time_end": 1728781367334923869,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "d8812ac60b083f59",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367137000000,
  "time_end": 1728781367344117956,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "0535cd9aa5ca68df",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367198000000,
  "time_end": 1728781367368637155,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "36ece06599e0a9d1",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367140000000,
  "time_end": 1728781367386559139,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "673bdaa2ef6baded",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367350000000,
  "time_end": 1728781367509264301,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "4f4fabdfb2294eb1",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367258000000,
  "time_end": 1728781367605855459,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "895349e5a339816a",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367343000000,
  "time_end": 1728781367605903474,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "e4c647719f584303",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367341000000,
  "time_end": 1728781367606464355,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "0afbd88e7e6351b5",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367168000000,
  "time_end": 1728781367607128244,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "bf4f7ca765595a38",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367392000000,
  "time_end": 1728781367607780621,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "7f4b5ed72cc3c549",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367629000000,
  "time_end": 1728781367873173172,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "11f7753fb79605de",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367613000000,
  "time_end": 1728781368019429223,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "b6b34bcaf68482d9",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781367876000000,
  "time_end": 1728781368032870669,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "24180cc8347e17cd",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781368023000000,
  "time_end": 1728781368496388036,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "9a176390aa968aa2",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781368500000000,
  "time_end": 1728781369055020043,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "30f2620040f187b5",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781369058000000,
  "time_end": 1728781369504596305,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "e2297524f20ab6a1",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781369508000000,
  "time_end": 1728781369939947172,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "4e97cabd3057df19",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781369945000000,
  "time_end": 1728781370471327277,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "d2431f59071f05ca",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781370474000000,
  "time_end": 1728781370921025708,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "988a1e9b875ce231",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781370924000000,
  "time_end": 1728781371354694871,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "8b516f2993f6833f",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781371358000000,
  "time_end": 1728781371810923019,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "00473c31c9c5b0b4",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781371814000000,
  "time_end": 1728781372226181419,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "255659d9ba4168ad",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781372229000000,
  "time_end": 1728781372740892245,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "4ed6a1a3f5afda02",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781372744000000,
  "time_end": 1728781372980916388,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "20ff3fdaffd26817",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781373001000000,
  "time_end": 1728781373290979423,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "3d57bbc4e0ec9a44",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781373296000000,
  "time_end": 1728781373560619242,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "c1226e390f250a5d",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781373563000000,
  "time_end": 1728781373871616248,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "99e374af7616efc1",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781373873000000,
  "time_end": 1728781374117803729,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "aaeabe8a6678a775",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781374120000000,
  "time_end": 1728781374382892264,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "aa4f0acd18bae5a9",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781374386000000,
  "time_end": 1728781374856719209,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "4f9777fafe080d52",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781374859000000,
  "time_end": 1728781375087600062,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "e85340b34682e254",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781375089000000,
  "time_end": 1728781375409114883,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "dd8c7ac61f9ad309",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781375412000000,
  "time_end": 1728781375686642315,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "6623eb48d669bd5f",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781375689000000,
  "time_end": 1728781375929765848,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "a4b0e229ca77a371",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781375934000000,
  "time_end": 1728781376185703501,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "dad8e968a533db6b",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781376189000000,
  "time_end": 1728781376431975081,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "e64287330b82c891",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781376434000000,
  "time_end": 1728781376669248710,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "1fe9cfe4469ca6a5",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781376672000000,
  "time_end": 1728781376946582803,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "3245b6d60e5f00f5",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1728781376949000000,
  "time_end": 1728781377099563853,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.120.0 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.112.6",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "33f6e87779f2c62a",
  "parent_span_id": "478da0b0be038ef2",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781364891000000,
  "time_end": 1728781377717585624,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "56d17a4a297e3ce2",
  "parent_span_id": "478da0b0be038ef2",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781377718000000,
  "time_end": 1728781377718378025,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "679a9030360ceaf1",
  "parent_span_id": "478da0b0be038ef2",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781377719000000,
  "time_end": 1728781377719570203,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "478da0b0be038ef2",
  "parent_span_id": "15d24f6cb8087ecd",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781359144000000,
  "time_end": 1728781377736867920,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "15d24f6cb8087ecd",
  "parent_span_id": "fc5d7af5a7109fb6",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781358237000000,
  "time_end": 1728781377794061153,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.26.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.120.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "fa10a1787b87604d",
  "parent_span_id": "33f6e87779f2c62a",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781377677984506,
  "time_end": 1728781377716701413,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "fc5d7af5a7109fb6",
  "parent_span_id": "1ab96a5b6cec7f12",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781355260139635,
  "time_end": 1728781377837727460,
  "attributes": {
    "shell.command_line": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel.sh",
    "code.lineno": 423,
    "code.function": "_otel_inject"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "1ab96a5b6cec7f12",
  "parent_span_id": "edc9b969e2028d2f",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781354133005775,
  "time_end": 1728781377840720008,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "edc9b969e2028d2f",
  "parent_span_id": "509acea4273769af",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781353727116845,
  "time_end": 1728781377842526448,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "707025152bf03f49",
  "parent_span_id": "766856cc09f649a1",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781352823348346,
  "time_end": 1728781377843766439,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "766856cc09f649a1",
  "parent_span_id": "314b070d9b1e8f7d",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781328428915714,
  "time_end": 1728781377919128744,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3650,
    "process.parent_pid": 3649,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "314b070d9b1e8f7d",
  "parent_span_id": "2fe3cf4aeca1f30a",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1728781327728439600,
  "time_end": 1728781377959839254,
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
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2820,
    "process.parent_pid": 2722,
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
  "trace_id": "f24857c1cb83412e1d7dc89049487dda",
  "span_id": "2fe3cf4aeca1f30a",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1728781327715562691,
  "time_end": 1728781377960006736,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.33.0",
    "service.name": "unknown_service",
    "github.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11309490439",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "dffa5fbd2adad80570ea4f2918913939a98fc807",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2820,
    "process.parent_pid": 2722,
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
