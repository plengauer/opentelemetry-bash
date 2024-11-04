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
                      GET
                      POST
                      POST
                      GET
                      GET
                      GET
                      POST
                      POST
                      POST
                      GET
                      GET
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "546f2b69029abb70",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1730721468053973800,
  "time_end": 1730721515577820000,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2707,
    "process.parent_pid": 2612,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ae630ce08efa9c39",
  "parent_span_id": "546f2b69029abb70",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721468066820000,
  "time_end": 1730721515577684700,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2707,
    "process.parent_pid": 2612,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "795c5156c60b6df1",
  "parent_span_id": "ae630ce08efa9c39",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721468773352700,
  "time_end": 1730721515546541000,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "cbaa66c6efc40866",
  "parent_span_id": "795c5156c60b6df1",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721491219020500,
  "time_end": 1730721515483583700,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "43035e2e04bdb2ab",
  "parent_span_id": "cbaa66c6efc40866",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721491891679200,
  "time_end": 1730721491900345900,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "cd97bba221cedbd4",
  "parent_span_id": "43035e2e04bdb2ab",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721492272451600,
  "time_end": 1730721515482256000,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3d2581dc066aba30",
  "parent_span_id": "cd97bba221cedbd4",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721492687902500,
  "time_end": 1730721515480644400,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "2e1cb3a72a6ce381",
  "parent_span_id": "3d2581dc066aba30",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721493831202800,
  "time_end": 1730721515477587200,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "07063609e354fd70",
  "parent_span_id": "2e1cb3a72a6ce381",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721496788000000,
  "time_end": 1730721515433375200,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "4321094ef83bcab0",
  "parent_span_id": "07063609e354fd70",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721496789000000,
  "time_end": 1730721497637669000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "7c9f9a84b4752523",
  "parent_span_id": "4321094ef83bcab0",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721497363500000,
  "time_end": 1730721497404336600,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "d0e82ad7d0a1a5f0",
  "parent_span_id": "4321094ef83bcab0",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721497421000000,
  "time_end": 1730721497551039200,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "9136d3223d760ef9",
  "parent_span_id": "4321094ef83bcab0",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1730721497558000000,
  "time_end": 1730721497616582400,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "55d7f3f37e14842d",
  "parent_span_id": "07063609e354fd70",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721497639000000,
  "time_end": 1730721497639243000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "c5a80fdcd1de30d4",
  "parent_span_id": "07063609e354fd70",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721497639000000,
  "time_end": 1730721515383647700,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ee2979f4c702ebf1",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721497650000000,
  "time_end": 1730721497775108900,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "b8f726bcb63c8794",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721498195700200,
  "time_end": 1730721498546491600,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "1d67c268d79dae1b",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721498551000000,
  "time_end": 1730721499305390600,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "f88e9c64ec33fb86",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499333000000,
  "time_end": 1730721500046531300,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "05c0b822ba463ca7",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499333000000,
  "time_end": 1730721500137161200,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "e31f18b9c1b78131",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499335000000,
  "time_end": 1730721500189931800,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ea7a0991ea94cb82",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499336000000,
  "time_end": 1730721499932361200,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "8c261b19d007176d",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499337000000,
  "time_end": 1730721499767027200,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ea2d796c3b98b803",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499784000000,
  "time_end": 1730721500293772000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ed354079d12b1c0f",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721499953000000,
  "time_end": 1730721500157655000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "6ee1ac5e517610ab",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721500540258300,
  "time_end": 1730721500966148400,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "825c4d4e5ea2ecb1",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721501033439500,
  "time_end": 1730721501064638700,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "fdff4012206d5875",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721501133624300,
  "time_end": 1730721501172397300,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "56204601b811a136",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721501240958500,
  "time_end": 1730721501273556000,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "6a9b464374875ae4",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721501341019600,
  "time_end": 1730721501373321200,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "bd76bccd47cb35bf",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721501440998700,
  "time_end": 1730721501473523000,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "1be9544f7177d777",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721501476000000,
  "time_end": 1730721501580447200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "1ee05ad99ef371e6",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721501649184500,
  "time_end": 1730721501683360500,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "713c3a377ae447f3",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721502414000000,
  "time_end": 1730721502490774000,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "1db6df0b56ecda63",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721502492000000,
  "time_end": 1730721515269679400,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "2c1448232e897277",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721502635463200,
  "time_end": 1730721502693129200,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "be97fe54f9936a12",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721502760521700,
  "time_end": 1730721502791734000,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "4cebbfe2b475fc55",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721502858418700,
  "time_end": 1730721502896917500,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "162104a8dbfc019b",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721503289488400,
  "time_end": 1730721503324289300,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "305b2efde7741914",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721503391689000,
  "time_end": 1730721503424355000,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "e7cc87592700e72c",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503891000000,
  "time_end": 1730721503944060400,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-distro/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-distro/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.0.223",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "71aadf623d58f4d7",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503893000000,
  "time_end": 1730721503945400800,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "db105b2feeca5c11",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503895000000,
  "time_end": 1730721504104150500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "04d47a62eae76401",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503897000000,
  "time_end": 1730721504126696700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "696d850e2a807f52",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503898000000,
  "time_end": 1730721504018112800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "9c0ccfbfd1b75ace",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503899000000,
  "time_end": 1730721504013747500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "838e9b9cbef0f9d9",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503900000000,
  "time_end": 1730721504365617700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "bce76f03f7a1c7eb",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503901000000,
  "time_end": 1730721504127988500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "b13aabf4c2ce7308",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503903000000,
  "time_end": 1730721504192085200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "707f7807d59b0ace",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503907000000,
  "time_end": 1730721504062942200,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "12df836edc7f2036",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503909000000,
  "time_end": 1730721504019981600,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "95b3c6b6346e62fb",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503910000000,
  "time_end": 1730721504093597700,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "11d8b160a1fae308",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503912000000,
  "time_end": 1730721504008431600,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "545065c84119fd69",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721503913000000,
  "time_end": 1730721503999374000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "a6eedd0e38e11bd7",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504053000000,
  "time_end": 1730721504140794000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "13f89c8e08b71741",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504088000000,
  "time_end": 1730721504131088000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "38165a463ed1a41c",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504091000000,
  "time_end": 1730721504212364000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "abf0695afc5cd0d2",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504093000000,
  "time_end": 1730721504214632700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "f208934b9d546326",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504125000000,
  "time_end": 1730721504418281000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "4190d9f4813bb4b4",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504171000000,
  "time_end": 1730721504261270000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "75f69ea49394db9e",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504213000000,
  "time_end": 1730721504254315300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ae06476ea4967cc7",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504251000000,
  "time_end": 1730721504417194500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "5b8af8a285adc0f5",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504252000000,
  "time_end": 1730721504444367000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "607f0b7c7485e122",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504254000000,
  "time_end": 1730721504444154000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3a51ffdd923f6c48",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504264000000,
  "time_end": 1730721504462690600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "35d106990208d3b9",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504370000000,
  "time_end": 1730721504918828500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3c42686c9be8b0ad",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504569000000,
  "time_end": 1730721504776937000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "75c59da4306dbbbc",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504570000000,
  "time_end": 1730721504755716400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "02fa348e94eb9f4c",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504752000000,
  "time_end": 1730721504877064200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "5a6c11981b5a73ab",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504753000000,
  "time_end": 1730721504878077200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "54e8cc2b72d8467a",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504754000000,
  "time_end": 1730721504945973500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "00c0544d5e103c58",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504755000000,
  "time_end": 1730721504968861000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "4cd489c04cf40deb",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504762000000,
  "time_end": 1730721504865537000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "485ec8906d1d88d3",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504779000000,
  "time_end": 1730721504943624400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3ea17ae91af7d223",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504886000000,
  "time_end": 1730721505162374700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "0fad805731ace249",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504888000000,
  "time_end": 1730721505066997200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "dbc025cb8a6d34c0",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504923000000,
  "time_end": 1730721505483884000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "1f4b765961edadde",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504953000000,
  "time_end": 1730721505164280600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "e2bc2d38e7fb228c",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504954000000,
  "time_end": 1730721505168702200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "d40a025da771aaea",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721504975000000,
  "time_end": 1730721505190769400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ca78a158c280b3ba",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721505172000000,
  "time_end": 1730721505304918000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "0f1c195232a51636",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721505487000000,
  "time_end": 1730721505958343400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "ce9771e606d8b7f5",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721505962000000,
  "time_end": 1730721506529917700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3ea277ede143a3b2",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721506534000000,
  "time_end": 1730721506896706000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "eb9d80689788713a",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721506902000000,
  "time_end": 1730721507452146400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "5e3ff24422455fd7",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721507456000000,
  "time_end": 1730721507851424500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3133949ac06371a6",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721507854000000,
  "time_end": 1730721508383535000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "94ec6ecbd8513b19",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721508387000000,
  "time_end": 1730721509036050000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "d1f3473a9e7e9b2f",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721509039000000,
  "time_end": 1730721509592936700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "3b3d42e97f0963b4",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721509596000000,
  "time_end": 1730721510045474800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "35bca8e3742ff87d",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721510049000000,
  "time_end": 1730721510703659500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "52d820262851841d",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721510707000000,
  "time_end": 1730721511075099400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "835e6bf3da7158e2",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721511079000000,
  "time_end": 1730721511272852500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "570c1cf7c304d152",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721511291000000,
  "time_end": 1730721511604713500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "370fc346855aa8e2",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721511611000000,
  "time_end": 1730721511817076500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "931788420479c824",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721511820000000,
  "time_end": 1730721512053323800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "564a5f8258e4a815",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721512055000000,
  "time_end": 1730721512255843600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "46e1d29046b29eb1",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721512259000000,
  "time_end": 1730721512501902000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "686d50d0c24101d9",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721512504000000,
  "time_end": 1730721512683034000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "5802abe4701c47d4",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721512685000000,
  "time_end": 1730721512954495000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "bd6b772a35928df1",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721512957000000,
  "time_end": 1730721513174481700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "18cd5120052d0a50",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721513177000000,
  "time_end": 1730721513421878000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "9492fb12be36e65f",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721513425000000,
  "time_end": 1730721513603339000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "e2d32990e592f54f",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721513605000000,
  "time_end": 1730721513863825200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "a5a07dfb4c9e0e19",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721513866000000,
  "time_end": 1730721514062417700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "e3784c14be0e8023",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721514065000000,
  "time_end": 1730721514287860000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "34fe44d3784f9be5",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721514290000000,
  "time_end": 1730721514563265000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "529d6a3cd32129f3",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721514566000000,
  "time_end": 1730721514680587800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "7e7f36c09959ba13",
  "parent_span_id": "1db6df0b56ecda63",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721515231096800,
  "time_end": 1730721515268998100,
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
    "telemetry.sdk.version": "4.37.1",
    "service.name": "unknown_service",
    "github.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11661899394",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "29dcbac513e7eeb56b9f077a255fffb854989a4a",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3537,
    "process.parent_pid": 3536,
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
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "20c12b4eb085d471",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721515271000000,
  "time_end": 1730721515271402800,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "16c4230d46670dc0",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730721515271000000,
  "time_end": 1730721515271509200,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "6b96d8ee857bde20f3d7a70310c51ba0",
  "span_id": "b23939c5d9b93e5b",
  "parent_span_id": "c5a80fdcd1de30d4",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730721515273000000,
  "time_end": 1730721515364421600,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/38.142.6 (https://github.com/renovatebot/renovate)",
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
    "service.version": "38.142.6"
  },
  "links": [],
  "events": []
}
```
