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
                      GET
                      GET
                      GET
                      GET
                      POST
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
                      GET
                      POST
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f2c5c2a4c2d7b845",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1731311975497620700,
  "time_end": 1731312024312708400,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2728,
    "process.parent_pid": 2632,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "43677d541b3d833c",
  "parent_span_id": "f2c5c2a4c2d7b845",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731311975511124500,
  "time_end": 1731312024312549600,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2728,
    "process.parent_pid": 2632,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "42f55fd047162cbf",
  "parent_span_id": "43677d541b3d833c",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731311976239929000,
  "time_end": 1731312024279288600,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "123009f833cc60e2",
  "parent_span_id": "42f55fd047162cbf",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731311999478907100,
  "time_end": 1731312024210779000,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "1d1c2b702c363af4",
  "parent_span_id": "123009f833cc60e2",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731311999973162200,
  "time_end": 1731311999982124300,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9ab35fe061f940c2",
  "parent_span_id": "1d1c2b702c363af4",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312000326232300,
  "time_end": 1731312024209682000,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9f4e9bce5a106c60",
  "parent_span_id": "9ab35fe061f940c2",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312000702807000,
  "time_end": 1731312024207418400,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "059d4ab180803a1c",
  "parent_span_id": "9f4e9bce5a106c60",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312001794571300,
  "time_end": 1731312024204431000,
  "attributes": {
    "shell.command_line": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/renovate/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel.sh",
    "code.lineno": 431,
    "code.function": "_otel_inject"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "b66b9b3bd8399ec3",
  "parent_span_id": "059d4ab180803a1c",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312005121000000,
  "time_end": 1731312024160558800,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "6bfed80bb3678a01",
  "parent_span_id": "b66b9b3bd8399ec3",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312005122000000,
  "time_end": 1731312005741551900,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "d972be407cd16d1d",
  "parent_span_id": "6bfed80bb3678a01",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312005534348000,
  "time_end": 1731312005562371000,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e81a2a610245b0b2",
  "parent_span_id": "6bfed80bb3678a01",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312005573000000,
  "time_end": 1731312005670808300,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "33bf0fb3bfe3671c",
  "parent_span_id": "6bfed80bb3678a01",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1731312005679000000,
  "time_end": 1731312005720009700,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "38df8969dc2f82b6",
  "parent_span_id": "b66b9b3bd8399ec3",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312005742000000,
  "time_end": 1731312005742191400,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "4f6aa5572beddd71",
  "parent_span_id": "b66b9b3bd8399ec3",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312005742000000,
  "time_end": 1731312024108136400,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "905a85e9ea99b0a2",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312005752000000,
  "time_end": 1731312005871528700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f6ed9979926d048e",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312006210775000,
  "time_end": 1731312006367838200,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "41c7c076aea5fa0b",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312006372000000,
  "time_end": 1731312006979215600,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "d1571c7c4c0b1a67",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007015000000,
  "time_end": 1731312007729878000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9cacd00379f82752",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007015000000,
  "time_end": 1731312007739672300,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "3d12a5b0dcd8f730",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007017000000,
  "time_end": 1731312007714689000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "1c821ffa5db1993b",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007019000000,
  "time_end": 1731312008482863400,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "33ddaae5951b95f6",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007020000000,
  "time_end": 1731312007708941600,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "a76d56036228e2a0",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007755000000,
  "time_end": 1731312008447918600,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "da3ece3e45d4a1fb",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312007773000000,
  "time_end": 1731312007998772000,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "202bce512be0051c",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312008738939400,
  "time_end": 1731312009180092700,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "7ab666520a070127",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312009236047000,
  "time_end": 1731312009266080800,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e3e79f37329f0424",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312009323968000,
  "time_end": 1731312009360951800,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "868715dd9f275bd2",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312009416557600,
  "time_end": 1731312009448099600,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "65a517f236a5deea",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312009506540000,
  "time_end": 1731312009538151700,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "536aafae2d01fe71",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312009594192100,
  "time_end": 1731312009626010600,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "0d8ef52433683138",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312009629000000,
  "time_end": 1731312009719223800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "762d2bef782f615a",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312009777491700,
  "time_end": 1731312009809377500,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "2de69df132c50858",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312010393000000,
  "time_end": 1731312010497636000,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9cf9ed07f2ca8ab9",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312010499000000,
  "time_end": 1731312023958959400,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f4e6197eeb6b8908",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312010632597800,
  "time_end": 1731312010689025500,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9672c63137b026ab",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312010746284300,
  "time_end": 1731312010776680400,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "7c5dd62db41c12ff",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312010834085000,
  "time_end": 1731312010870748400,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "6c66493187100740",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312011208330500,
  "time_end": 1731312011242180900,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f6a3d2edd700f996",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312011298493400,
  "time_end": 1731312011329748000,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "161228f029ea9d9a",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011790000000,
  "time_end": 1731312011872572400,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-distro/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-distro/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.128.223",
    "net.peer.port": 443,
    "http.response_content_length": 12820,
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
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "c1f96bfcee24740c",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011793000000,
  "time_end": 1731312011878093300,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.64.223",
    "net.peer.port": 443,
    "http.response_content_length": 15284,
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
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "4859b8cf765fd5a0",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011794000000,
  "time_end": 1731312011874491000,
  "attributes": {
    "http.url": "https://pypi.org/pypi/requests/json",
    "http.method": "GET",
    "http.target": "/pypi/requests/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "325d6e18c96f8f1a",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011797000000,
  "time_end": 1731312011891131100,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-sdk/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-sdk/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.192.223",
    "net.peer.port": 443,
    "http.response_content_length": 18232,
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
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "12448dd262aeaf73",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011799000000,
  "time_end": 1731312011878478600,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp-proto-http/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "151.101.0.223",
    "net.peer.port": 443,
    "http.response_content_length": 10782,
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
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "c110ad63baf84e32",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011801000000,
  "time_end": 1731312011887579600,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-docker/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-docker/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9941dfc531702425",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011803000000,
  "time_end": 1731312011885570600,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-resourcedetector-kubernetes/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "2a097304f51769dc",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011805000000,
  "time_end": 1731312011961001700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "7079ad5ed27652ae",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011806000000,
  "time_end": 1731312012101994500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "c61a58c8ddccb193",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011808000000,
  "time_end": 1731312012013498000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "508a5496bd86c461",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011809000000,
  "time_end": 1731312011975777800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "a00bfe9ad7f0f194",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011810000000,
  "time_end": 1731312012341320400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "7d658615893c9047",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011811000000,
  "time_end": 1731312012047304200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "6cff2931d74aba65",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011814000000,
  "time_end": 1731312012061545500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "6f2403a91e27214c",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011819000000,
  "time_end": 1731312011974246100,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "fda5af195589d16c",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011821000000,
  "time_end": 1731312011971031300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9ee7966dae2026ca",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011823000000,
  "time_end": 1731312011970543000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e1236fa343b9f419",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011825000000,
  "time_end": 1731312012533444400,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "b4c0102ca16934ac",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312011827000000,
  "time_end": 1731312011913745400,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e956004c8b333e28",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012029000000,
  "time_end": 1731312012220125000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "c945915668902c55",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012047000000,
  "time_end": 1731312012103724300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f6ce28ae724c53d8",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012050000000,
  "time_end": 1731312012220279300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "2df3015ccb5ac0fc",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012054000000,
  "time_end": 1731312012182010600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "0af883d652a38e6e",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012100000000,
  "time_end": 1731312012152925000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "7623165c6c06b691",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012102000000,
  "time_end": 1731312012327129000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "becbd6945eebf674",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012155000000,
  "time_end": 1731312012218348000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "b4a572f1d65acbe0",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012158000000,
  "time_end": 1731312012324553000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "87cc486cf2c38c1d",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012181000000,
  "time_end": 1731312012221310200,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "422c586eb030dc01",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012217000000,
  "time_end": 1731312012263404000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "b52699fcab6c1f75",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012231000000,
  "time_end": 1731312012531725800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f3ae48b127486306",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012346000000,
  "time_end": 1731312012755585500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "a49a087dcba1f16d",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012529000000,
  "time_end": 1731312012922545400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "27568a900d2ac9c3",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012530000000,
  "time_end": 1731312012708963300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "709914b5d0512b5b",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012531000000,
  "time_end": 1731312012672937700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "43d0a1e940d99344",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012670000000,
  "time_end": 1731312012993151200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f4f959ef5f8a43d7",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012671000000,
  "time_end": 1731312012923605800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "40dc9bd79d7e6d04",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012672000000,
  "time_end": 1731312012982990000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "bbfaf2e451d3316e",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012692000000,
  "time_end": 1731312012824330000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "490cf9eae625f6a9",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012715000000,
  "time_end": 1731312012827083000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "2213ca37c702c82d",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012760000000,
  "time_end": 1731312013362582500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "3966835b91b82f1a",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012928000000,
  "time_end": 1731312013108903200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "0f9a6f408ecda900",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012945000000,
  "time_end": 1731312013277802200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "46518c4a93af943f",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012989000000,
  "time_end": 1731312013246203100,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f8f35181f4d4afad",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312012999000000,
  "time_end": 1731312013151880200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "2dff2213d762fa38",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312013116000000,
  "time_end": 1731312013301540400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "3481bcc600e944da",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312013305000000,
  "time_end": 1731312013404642600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e4660ba044e01340",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312013365000000,
  "time_end": 1731312013735327500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "754b5f0dde6e5c51",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312013738000000,
  "time_end": 1731312014269915600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9b6c5c60e39bc54d",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312014273000000,
  "time_end": 1731312014840965600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e8e1ab20c4f80d9f",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312014844000000,
  "time_end": 1731312015346335000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "f08b79b96fd7a6b7",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312015349000000,
  "time_end": 1731312015924312300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "047d0b36d5ec7f7c",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312015928000000,
  "time_end": 1731312016320676600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "c890c23257272294",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312016323000000,
  "time_end": 1731312017333109800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "fe4b9ec381b58c51",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312017335000000,
  "time_end": 1731312017769631000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "28749aaf3cd3072a",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312017772000000,
  "time_end": 1731312018358852400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "dd363393c1c43c40",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312018363000000,
  "time_end": 1731312018856805000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "6cd2fce0d7c4c0f5",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312018860000000,
  "time_end": 1731312019300653300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "da8cf8c38037071a",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312019303000000,
  "time_end": 1731312019535567600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "60ec5be1b5158da4",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312019554000000,
  "time_end": 1731312019773620700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "1b63259d98dc0a6d",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312019780000000,
  "time_end": 1731312020050936300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "40d19a5604bfe4d0",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312020055000000,
  "time_end": 1731312020436214000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "4ec3f215161700b8",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312020439000000,
  "time_end": 1731312020741319200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "847a13b97025a3c4",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312020744000000,
  "time_end": 1731312020977905700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "7fcbd9172841224f",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312020980000000,
  "time_end": 1731312021188237300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "cfba9d30231f6189",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312021191000000,
  "time_end": 1731312021428960500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "bf497ea700576d38",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312021432000000,
  "time_end": 1731312021700165000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "52af6ddbddf43b1e",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312021702000000,
  "time_end": 1731312022086394400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "cfa332812c49b67c",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312022089000000,
  "time_end": 1731312022343697200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e3a21600bf8b3ce0",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312022347000000,
  "time_end": 1731312022662825500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "b0860dd9d62be1b2",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312022666000000,
  "time_end": 1731312022887997400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e6e97f0066a7e4ac",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312022890000000,
  "time_end": 1731312023094072300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "743341e8768e78c8",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312023097000000,
  "time_end": 1731312023277386200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "9171a127a4b29e86",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312023280000000,
  "time_end": 1731312023392116000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "94547d05eb3292d8",
  "parent_span_id": "9cf9ed07f2ca8ab9",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312023920416500,
  "time_end": 1731312023957573600,
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
    "telemetry.sdk.version": "4.38.0",
    "service.name": "unknown_service",
    "github.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.event.ref.name": "main",
    "github.event.actor.id": "170979611",
    "github.event.actor.name": "actions-bot-pl",
    "github.event.name": "push",
    "github.workflow.run.id": "11773202685",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "a2766b54edfd82fb42c72d7a097de1463329b9a5",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3542,
    "process.parent_pid": 3541,
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
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "e6aaba1aca0d44c5",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312023960000000,
  "time_end": 1731312023960445700,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "df3f0be745339aa0",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1731312023960000000,
  "time_end": 1731312023960511200,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "346eb9e5cf3668a8c4688236ba5ff3c3",
  "span_id": "20d7c77577171825",
  "parent_span_id": "4f6aa5572beddd71",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1731312023962000000,
  "time_end": 1731312024090811600,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.9.2 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.9.2"
  },
  "links": [],
  "events": []
}
```
