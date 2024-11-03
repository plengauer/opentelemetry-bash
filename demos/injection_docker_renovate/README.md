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
                    git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    GET
                    git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .
                    git -c core.quotePath=false rev-parse HEAD
                    git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    git -c core.quotePath=false ls-tree -r main
                    POST
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
                      POST
                      GET
                      POST
                      GET
                      POST
                      POST
                      POST
                      POST
                      POST
                      POST
                      GET
                      POST
                      GET
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
                      git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20
                    onboarding
                    update
                    GET
```
## Full Trace
```
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "984345d1ac69ad06",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1730634716291006000,
  "time_end": 1730634761369708000,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2713,
    "process.parent_pid": 2618,
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "f7e1dbaa7af118ce",
  "parent_span_id": "984345d1ac69ad06",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634716304110300,
  "time_end": 1730634761369542400,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2713,
    "process.parent_pid": 2618,
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "070c558f5fcd09b7",
  "parent_span_id": "f7e1dbaa7af118ce",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634717019757300,
  "time_end": 1730634761337382100,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "c4a9339e53d69866",
  "parent_span_id": "070c558f5fcd09b7",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634739343238000,
  "time_end": 1730634761262888700,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "d4422a143ecc6380",
  "parent_span_id": "c4a9339e53d69866",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634739914373600,
  "time_end": 1730634739923288800,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "d5acbfbf4ffd7245",
  "parent_span_id": "d4422a143ecc6380",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634740298870000,
  "time_end": 1730634761261528300,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "5c719c55aedcee7f",
  "parent_span_id": "d5acbfbf4ffd7245",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634740706400000,
  "time_end": 1730634761259948300,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "71f151ff3bc500e6",
  "parent_span_id": "5c719c55aedcee7f",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634741842811400,
  "time_end": 1730634761257074000,
  "attributes": {
    "shell.command_line": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/bin/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel.sh",
    "code.lineno": 420,
    "code.function": "_otel_inject"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "26fb2c3011007634",
  "parent_span_id": "71f151ff3bc500e6",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634744850000000,
  "time_end": 1730634761220970500,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "e46851a7066d41e6",
  "parent_span_id": "26fb2c3011007634",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634744851000000,
  "time_end": 1730634745617932300,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "bdfea3feb60a4d14",
  "parent_span_id": "e46851a7066d41e6",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634745424133400,
  "time_end": 1730634745455385900,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "4cfbd55def7ddb4b",
  "parent_span_id": "e46851a7066d41e6",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634745468000000,
  "time_end": 1730634745553353000,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "60ef8186ffc05ee0",
  "parent_span_id": "e46851a7066d41e6",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1730634745561000000,
  "time_end": 1730634745597117000,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "15a535158304eed2",
  "parent_span_id": "26fb2c3011007634",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634745619000000,
  "time_end": 1730634745619260400,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "3e7c35519fee1a45",
  "parent_span_id": "26fb2c3011007634",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634745620000000,
  "time_end": 1730634761169923000,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "fb5e38b574b36a20",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634745630000000,
  "time_end": 1730634745725800200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "0e2117eacf9fe947",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634746104317000,
  "time_end": 1730634746252666000,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "a9219a4d2ff8fbe4",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634746257000000,
  "time_end": 1730634746743102500,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "b72224632a8dc564",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634746773000000,
  "time_end": 1730634747365612300,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "641831f3735cec7b",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634746774000000,
  "time_end": 1730634747432593000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "c88ea7bf314fcb15",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634746776000000,
  "time_end": 1730634747461731000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "e4d9d43a634b616d",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634746777000000,
  "time_end": 1730634747367736600,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "7063ebef8445f52e",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634746779000000,
  "time_end": 1730634747201817600,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "1ab18ddde9a33aee",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634747219000000,
  "time_end": 1730634747577405200,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "2b9badb131a33fe7",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634747387000000,
  "time_end": 1730634747510022400,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "1dbace2fa10fda73",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634747810931000,
  "time_end": 1730634748205057500,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "e7a1c3ba78a41bb1",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634748273173200,
  "time_end": 1730634748305105200,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "55485995a575acde",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634748390920200,
  "time_end": 1730634748429291000,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "72d8588a1aee5330",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634748496924200,
  "time_end": 1730634748531271200,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "237eb8161f2c36d5",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634748598232000,
  "time_end": 1730634748630481700,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "f86b709dbfaacbc9",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634748697851600,
  "time_end": 1730634748730808800,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "c8c8c3a5a3f23cb5",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634748733000000,
  "time_end": 1730634748811545600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "69512a8dc5163a0c",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634748884211200,
  "time_end": 1730634748916284700,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "127504f2bd331219",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634749623000000,
  "time_end": 1730634749691736600,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "a962c60c7489f6c1",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634749693000000,
  "time_end": 1730634761025298000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "52c9e1fcef62df18",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634749837837800,
  "time_end": 1730634749891041300,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "a0c454bdb0768d68",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634749957804800,
  "time_end": 1730634749989225700,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "11cc5a3695f5dd3f",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634750056592600,
  "time_end": 1730634750095376000,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "69f94fbef24bb992",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634750492684300,
  "time_end": 1730634750527504400,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "7b1cf77ff1f36cd4",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634750594753300,
  "time_end": 1730634750628354300,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "d336461dcc4616d7",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751095000000,
  "time_end": 1730634751146563800,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-distro/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-distro/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.64.223",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "104ea01ed8cb3409",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751097000000,
  "time_end": 1730634751150898000,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.128.223",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "10209db15a10ad25",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751099000000,
  "time_end": 1730634751294597400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "8c7e2b8c35ca6bf2",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751100000000,
  "time_end": 1730634751291569700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "10e91286569c04e7",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751101000000,
  "time_end": 1730634751299858700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "cfc321139b1b2c04",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751102000000,
  "time_end": 1730634751200695800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "049304a00c8eb926",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751103000000,
  "time_end": 1730634751482212400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "ee0cf1cc20225585",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751104000000,
  "time_end": 1730634751320424700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "d54ab83607f65be5",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751107000000,
  "time_end": 1730634751293461800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "78c9d5543253549a",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751110000000,
  "time_end": 1730634751246928100,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "835097934dd9b5f9",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751112000000,
  "time_end": 1730634751215483600,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "17b1a1b2d5cf191f",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751114000000,
  "time_end": 1730634751266433300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "1176d7a6c6a4a004",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751116000000,
  "time_end": 1730634751224220200,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "c91a943d69ec10cc",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751117000000,
  "time_end": 1730634751198008300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "ba19208b9635b46b",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751223000000,
  "time_end": 1730634751319957000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "f64113b4f603cd2c",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751246000000,
  "time_end": 1730634751354754800,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "a31e215134bb5f61",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751352000000,
  "time_end": 1730634751955366700,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "087679a6a5c19863",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751416000000,
  "time_end": 1730634752009657900,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "be322a2746bdb0ba",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751418000000,
  "time_end": 1730634751978169300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "4221010df1fe5ca7",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751457000000,
  "time_end": 1730634751501023700,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "ff63ee99aeb56f40",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751467000000,
  "time_end": 1730634751604624400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "64a1f26a73218972",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751469000000,
  "time_end": 1730634751607067100,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "a24614c6e50b45ec",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751484000000,
  "time_end": 1730634751612238000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "70491acfb11cef64",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751484000000,
  "time_end": 1730634751898566700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "fcee0177254c1318",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751489000000,
  "time_end": 1730634751967631000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "60260f038c140192",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751491000000,
  "time_end": 1730634751899575300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "5fa2d96fd416f52b",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751778000000,
  "time_end": 1730634751988401700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "9bb010207a8c5c6a",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751779000000,
  "time_end": 1730634751935661600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "912ca2e0eaecc002",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751900000000,
  "time_end": 1730634752041446400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "494e5c653178e725",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751901000000,
  "time_end": 1730634752056401000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "b91567826f0a4dce",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751902000000,
  "time_end": 1730634752051234300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "69efb77f03b8860a",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751902000000,
  "time_end": 1730634752058112500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "ad72f4841818463f",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751972000000,
  "time_end": 1730634752525538600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "9730324433d0ad79",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751974000000,
  "time_end": 1730634752163268600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "fe1784b633d59eb6",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634751991000000,
  "time_end": 1730634752117361200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "224759c31b46a3e3",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752048000000,
  "time_end": 1730634752148877600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "4551a6b9a8082e40",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752062000000,
  "time_end": 1730634752260326400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "bf379dbd97fe98ee",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752066000000,
  "time_end": 1730634752258219000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "8bda2b4617b38a17",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752067000000,
  "time_end": 1730634752258920000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "2cedbf1fd6812477",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752123000000,
  "time_end": 1730634752333293600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "84887671fe5f94e3",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752337000000,
  "time_end": 1730634752429713400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "ea1ab5325d62a782",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752529000000,
  "time_end": 1730634752889517000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "5e0f6fd283ac8f01",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634752893000000,
  "time_end": 1730634753238625500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "6879376bd549b27d",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634753242000000,
  "time_end": 1730634753660860700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "667cc5b62c7cc53e",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634753666000000,
  "time_end": 1730634754067939800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "0521e89ef21221b6",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634754072000000,
  "time_end": 1730634754605099000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "c8f9407f8ee81d68",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634754608000000,
  "time_end": 1730634754979651600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "9651a1a05e70d68d",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634754983000000,
  "time_end": 1730634755400091600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "a5063adae88e6827",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634755404000000,
  "time_end": 1730634755827633200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "b3d569fca20f33f2",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634755831000000,
  "time_end": 1730634756205259000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "17f7440c22280d2f",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634756208000000,
  "time_end": 1730634756580449500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "e9d5d5b8701b7577",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634756584000000,
  "time_end": 1730634756992400100,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "6de281e8c17f11b9",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634756995000000,
  "time_end": 1730634757195159000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "2294844cec475532",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634757214000000,
  "time_end": 1730634757477837000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "0e129381b53cb8ae",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634757483000000,
  "time_end": 1730634757723730700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "935d2e508ae18d59",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634757727000000,
  "time_end": 1730634758041081000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "acfef36a6cd46295",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634758044000000,
  "time_end": 1730634758233730600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "b4bfd2e9060313bc",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634758238000000,
  "time_end": 1730634758411672300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "aae59430426155dd",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634758414000000,
  "time_end": 1730634758750314200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "9c04f8e9d2949c19",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634758753000000,
  "time_end": 1730634758982216000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "72dce07856085bec",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634758985000000,
  "time_end": 1730634759153133800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "36c08c24620b8c05",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634759156000000,
  "time_end": 1730634759330042600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "18608299ded98b49",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634759332000000,
  "time_end": 1730634759505464600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "5879e53da1dd2a4e",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634759508000000,
  "time_end": 1730634759702755300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "ce017c6f9a0a39eb",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634759706000000,
  "time_end": 1730634759874550500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "1bcf169fbbff8874",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634759877000000,
  "time_end": 1730634760071545600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "8b54d65671823682",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634760074000000,
  "time_end": 1730634760303872800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "1ba21bc26dab780f",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634760307000000,
  "time_end": 1730634760422208500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "33308ebd7b5412e6",
  "parent_span_id": "a962c60c7489f6c1",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634760985464600,
  "time_end": 1730634761024363800,
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
    "telemetry.sdk.version": "4.37.0",
    "service.name": "unknown_service",
    "github.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11650349700",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "09a2709fd7e39a69fb9e00239add2d9a9aa1a0e0",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3545,
    "process.parent_pid": 3544,
    "process.executable.name": "bash",
    "process.executable.path": "/usr/bin/bash",
    "process.command_line": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
    "process.command": "sudo",
    "process.owner": "root",
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
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "234c5b2425c4ce5e",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634761026000000,
  "time_end": 1730634761026351000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "8237d109a97aaa1d",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730634761027000000,
  "time_end": 1730634761027518700,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "c6f19808331108d8c153e1ce19a2beb7",
  "span_id": "009ffc571cb3e76a",
  "parent_span_id": "3e7c35519fee1a45",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730634761029000000,
  "time_end": 1730634761150439400,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.4 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "140.82.114.5",
    "net.peer.port": 443,
    "http.status_code": 200,
    "http.status_text": "OK",
    "http.flavor": "1.1",
    "net.transport": "ip_tcp"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.4"
  },
  "links": [],
  "events": []
}
```
