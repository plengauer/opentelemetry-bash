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
                      POST
                      POST
                      POST
                      POST
                      GET
                      POST
                      GET
                      GET
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
                      POST
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "92002ecbfaf57683",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1730795469772984000,
  "time_end": 1730795517058207200,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2710,
    "process.parent_pid": 2617,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "876c8a691c7c1ab5",
  "parent_span_id": "92002ecbfaf57683",
  "name": "sudo -E docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795469786045400,
  "time_end": 1730795517058077000,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 2710,
    "process.parent_pid": 2617,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "9826202bc1cf4d26",
  "parent_span_id": "876c8a691c7c1ab5",
  "name": "docker run --env RENOVATE_TOKEN --network=host renovate/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795470514365000,
  "time_end": 1730795517027465000,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "2eb6943f48a82f7c",
  "parent_span_id": "9826202bc1cf4d26",
  "name": "/bin/bash /usr/local/sbin/renovate-entrypoint.sh --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795493317114400,
  "time_end": 1730795516958751700,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "92b7cd3948424acc",
  "parent_span_id": "2eb6943f48a82f7c",
  "name": "exec",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795493824194000,
  "time_end": 1730795493833405200,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "ed455fae7661c111",
  "parent_span_id": "92b7cd3948424acc",
  "name": "dumb-init -- renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795494188627500,
  "time_end": 1730795516957022200,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "be10021a3122ba70",
  "parent_span_id": "ed455fae7661c111",
  "name": "/bin/bash /usr/local/sbin/renovate --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795494571077400,
  "time_end": 1730795516955545600,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "2729a484ba044675",
  "parent_span_id": "be10021a3122ba70",
  "name": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795495653418800,
  "time_end": 1730795516952865800,
  "attributes": {
    "shell.command_line": "node --use-openssl-ca /usr/local/renovate/dist/renovate.js --dry-run plengauer/opentelemetry-bash",
    "shell.command": "node",
    "shell.command.type": "file",
    "shell.command.name": "node",
    "subprocess.executable.path": "/usr/local/renovate/node",
    "subprocess.executable.name": "node",
    "shell.command.exit_code": 0,
    "code.filepath": "/usr/bin/otel.sh",
    "code.lineno": 421,
    "code.function": "_otel_inject"
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "6fe1fcf37478b7d2",
  "parent_span_id": "2729a484ba044675",
  "name": "run",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795498940000000,
  "time_end": 1730795516911844000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "fc3b27cffbb4e2e7",
  "parent_span_id": "6fe1fcf37478b7d2",
  "name": "config",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795498941000000,
  "time_end": 1730795499629751300,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "adc8e8b6fd89816f",
  "parent_span_id": "fc3b27cffbb4e2e7",
  "name": "git --version",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795499421708000,
  "time_end": 1730795499452884200,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "987bf93f48249a57",
  "parent_span_id": "fc3b27cffbb4e2e7",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795499468000000,
  "time_end": 1730795499563913700,
  "attributes": {
    "http.url": "https://api.github.com/user",
    "http.method": "GET",
    "http.target": "/user",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b982c2d327b51fac",
  "parent_span_id": "fc3b27cffbb4e2e7",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1730795499573000000,
  "time_end": 1730795499607919000,
  "attributes": {
    "http.url": "https://api.github.com/user/emails",
    "http.method": "GET",
    "http.target": "/user/emails",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "cc839ca5dda5dc6d",
  "parent_span_id": "6fe1fcf37478b7d2",
  "name": "discover",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795499631000000,
  "time_end": 1730795499631228400,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "63e58ce58100bc7e",
  "parent_span_id": "6fe1fcf37478b7d2",
  "name": "repository",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795499632000000,
  "time_end": 1730795516863885000,
  "attributes": {
    "repository": "plengauer/opentelemetry-bash"
  },
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "5e97937876ee2552",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795499644000000,
  "time_end": 1730795499783265300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "e31a89a2bbf101bb",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false ls-remote --heads https://***@github.com/plengauer/opentelemetry-bash.git",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795500169878500,
  "time_end": 1730795500326044400,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "8b9c1347333c7d9c",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795500331000000,
  "time_end": 1730795501018848300,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/pulls?per_page=100&state=all&sort=updated&direction=desc&page=1",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "fdebd88aba83b6e8",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501050000000,
  "time_end": 1730795501762605300,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=2",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "910cdbac4e7ce8cb",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501051000000,
  "time_end": 1730795501649560300,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=3",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "ba6f74ca48b37979",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501053000000,
  "time_end": 1730795501612062500,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=4",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "436e9f63f7c53df8",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501054000000,
  "time_end": 1730795501977362200,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=5",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "a1b6562a4f7f4a32",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501055000000,
  "time_end": 1730795501485685500,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=6",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "07377dd3d5d2513b",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501506000000,
  "time_end": 1730795501958082600,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=7",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "d4d4f00c492f6890",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795501632000000,
  "time_end": 1730795501808354800,
  "attributes": {
    "http.url": "https://api.github.com/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "http.method": "GET",
    "http.target": "/repositories/692042935/pulls?per_page=100&state=all&sort=updated&direction=desc&page=8",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "819c858d2c506daf",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false clone -b main --filter=blob:none https://***@github.com/plengauer/opentelemetry-bash.git .",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795502219786000,
  "time_end": 1730795502707581700,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "badd68bca4f775c0",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795502763955500,
  "time_end": 1730795502794612200,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "697d4c484b6bef94",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795502851262500,
  "time_end": 1730795502887766300,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "77a25eced3a35b58",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795502943775500,
  "time_end": 1730795502975087900,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "3ffbe805d16e88a1",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795503032911000,
  "time_end": 1730795503064622300,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "12a98444aa00cfb3",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795503123017700,
  "time_end": 1730795503155550500,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "063b9b374630a812",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795503158000000,
  "time_end": 1730795503304008700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "3cd855eb036ef478",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795503363174700,
  "time_end": 1730795503395009500,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "dd44bb3ad5a5349d",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795503967000000,
  "time_end": 1730795504040831500,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/dependabot/alerts?state=open&direction=asc&per_page=100",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "fbf8d7e6092d024e",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "extract",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795504042000000,
  "time_end": 1730795516674988000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b6db0790d0052db4",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "git -c core.quotePath=false checkout -f main --",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795504177539300,
  "time_end": 1730795504234423600,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "533275bad3afabf1",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "git -c core.quotePath=false rev-parse HEAD",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795504290960100,
  "time_end": 1730795504327469600,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "30f82bec935aecac",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %H ò %aI ò %s ò %D ò %b ò %aN ò %aE òò --max-count=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795504385617200,
  "time_end": 1730795504423114500,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b6b0878fcbfbc1bc",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "git -c core.quotePath=false reset --hard",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795504771618300,
  "time_end": 1730795504805894100,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "747664595c25353a",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "git -c core.quotePath=false ls-tree -r main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795504863402800,
  "time_end": 1730795504895562800,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "af3916bb9214dc68",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505341000000,
  "time_end": 1730795505416751600,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-distro/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-distro/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "1e3f7646b0727478",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505343000000,
  "time_end": 1730795505412139000,
  "attributes": {
    "http.url": "https://pypi.org/pypi/opentelemetry-exporter-otlp/json",
    "http.method": "GET",
    "http.target": "/pypi/opentelemetry-exporter-otlp/json",
    "net.peer.name": "pypi.org",
    "http.host": "pypi.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "c6666cd0cf49ab72",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505346000000,
  "time_end": 1730795505560963800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "646a46da56e2f5fb",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505347000000,
  "time_end": 1730795505521245200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "4a50e0f12b1e506f",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505349000000,
  "time_end": 1730795505520837600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "cc849743e9b41ae7",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505350000000,
  "time_end": 1730795505482493700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "6b43369c79f609f6",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505352000000,
  "time_end": 1730795505734938600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "e1dfb1e681412e32",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505353000000,
  "time_end": 1730795505605685800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "dd79797b5207821c",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505356000000,
  "time_end": 1730795505683738400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "9a12d22a7c8c3d69",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505362000000,
  "time_end": 1730795505472938200,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresources",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresources",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "83a938ca8f74b4e0",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505364000000,
  "time_end": 1730795505474679300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fapi",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fapi",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "9f842f26c1229ba3",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505366000000,
  "time_end": 1730795505476594400,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fsdk-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fsdk-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "6869dc6d3aa43b27",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505368000000,
  "time_end": 1730795505471137500,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fauto-instrumentations-node",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fauto-instrumentations-node",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "5e92ae1858e17679",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505370000000,
  "time_end": 1730795505461267000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/opentelemetry-resource-detector-git",
    "http.method": "GET",
    "http.target": "/opentelemetry-resource-detector-git",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
    "net.peer.ip": "104.16.24.34",
    "net.peer.port": 443,
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "a97f3121dba9db08",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505519000000,
  "time_end": 1730795505563145500,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-github",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-github",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "89d18859de4531f1",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505562000000,
  "time_end": 1730795505673846300,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-container",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-container",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "f49d61465fe7d2ea",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505566000000,
  "time_end": 1730795505748017700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "07727f7e37f430f8",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505604000000,
  "time_end": 1730795505642792400,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-aws",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-aws",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "767ddaf55b479de5",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505611000000,
  "time_end": 1730795505732648200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "15de2e8b8223c739",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505613000000,
  "time_end": 1730795505762303000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "8b953c3840261293",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505630000000,
  "time_end": 1730795505675702500,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-gcp",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-gcp",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "87ab6298deebc032",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505673000000,
  "time_end": 1730795505706719000,
  "attributes": {
    "http.url": "https://registry.npmjs.org/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "http.method": "GET",
    "http.target": "/@opentelemetry%2Fresource-detector-alibaba-cloud",
    "net.peer.name": "registry.npmjs.org",
    "http.host": "registry.npmjs.org:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "3dde482bc880c007",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505680000000,
  "time_end": 1730795505918767000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "f4575c68327fa284",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505711000000,
  "time_end": 1730795505919911700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "7c1d6383bdcb95db",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505750000000,
  "time_end": 1730795506182273300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "c778fdf7c52f1c05",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505782000000,
  "time_end": 1730795505994217200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b00648f76fdd3500",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505915000000,
  "time_end": 1730795506251332400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "9e46da837a7cab17",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795505917000000,
  "time_end": 1730795506183249200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "348ea40f0655b340",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506178000000,
  "time_end": 1730795506337021000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "6f187ebbc5dc9559",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506179000000,
  "time_end": 1730795506324627500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "d5c6dcfed6e1f38d",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506180000000,
  "time_end": 1730795506358052400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "c404b58e4c5c60bd",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506181000000,
  "time_end": 1730795506409418800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "db9baaa70b565339",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506188000000,
  "time_end": 1730795506578071300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "6b44b738f3c1d910",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506193000000,
  "time_end": 1730795506320587300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "7f8d5fce28709948",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506255000000,
  "time_end": 1730795506473314000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "0dc1e2d2edd0ade1",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506341000000,
  "time_end": 1730795506468892000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "2dda08007e272f27",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506344000000,
  "time_end": 1730795506471944700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "75a8eb98ee34c681",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506364000000,
  "time_end": 1730795506568943600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "24cdfebdb320a6b9",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506416000000,
  "time_end": 1730795506600794600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "8cc5fd369907f411",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506577000000,
  "time_end": 1730795506826399000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "a950e7793bb94a17",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506581000000,
  "time_end": 1730795506988963300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "551f5dcc4c00fb0f",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506830000000,
  "time_end": 1730795506949436000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "642b873e9626fda7",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795506992000000,
  "time_end": 1730795507615440000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "0f8ad5fb0766133d",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795507618000000,
  "time_end": 1730795508036298500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "bd314d6bae998629",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795508039000000,
  "time_end": 1730795508536359200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "c31717a175488a31",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795508539000000,
  "time_end": 1730795509009384700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "25050726ce34a73c",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795509013000000,
  "time_end": 1730795509586490000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "a437ae9e1ec492e9",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795509589000000,
  "time_end": 1730795510095016000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "868ca4788129a032",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795510098000000,
  "time_end": 1730795510496800000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "2deac254bd663023",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795510499000000,
  "time_end": 1730795510962795500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "a63efa6d0e142e2a",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795510966000000,
  "time_end": 1730795511560117500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "8c66784844cfd78d",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795511563000000,
  "time_end": 1730795512123965400,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "0088e990623a2c4c",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795512126000000,
  "time_end": 1730795512377750000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "75bd085626abe8fb",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795512397000000,
  "time_end": 1730795512680122600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b32751c082fef22e",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795512685000000,
  "time_end": 1730795512937851600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "56a4f4ceed378a72",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795512940000000,
  "time_end": 1730795513216572200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "c74028f9c5147fde",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795513220000000,
  "time_end": 1730795513496924200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "943a552c86dc93af",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795513499000000,
  "time_end": 1730795513832226000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "82403b2144a2b080",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795513835000000,
  "time_end": 1730795514053517000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "cbab601adcfd22a7",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795514057000000,
  "time_end": 1730795514357430500,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "29c0d87df0ebac0b",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795514360000000,
  "time_end": 1730795514563966000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "1c3fa78a7cc8a120",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795514567000000,
  "time_end": 1730795514758097700,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "0e50f2dd33704083",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795514761000000,
  "time_end": 1730795515009389000,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "07da7a75d981bbda",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795515012000000,
  "time_end": 1730795515217953800,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "5cfbf905ee71aed6",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795515221000000,
  "time_end": 1730795515532558600,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "39a1691616234183",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795515535000000,
  "time_end": 1730795515773308200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b4e3c93622ad0500",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795515776000000,
  "time_end": 1730795516003220200,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "3b0f4b5a046d5a3b",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "POST",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795516006000000,
  "time_end": 1730795516117453300,
  "attributes": {
    "http.url": "https://api.github.com/graphql",
    "http.method": "POST",
    "http.target": "/graphql",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "b628851bbc1224f5",
  "parent_span_id": "fbf8d7e6092d024e",
  "name": "git -c core.quotePath=false log --pretty=format:òòòòòò %s òò --max-count=20",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795516636627700,
  "time_end": 1730795516673945000,
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
    "telemetry.sdk.version": "4.37.2",
    "service.name": "unknown_service",
    "github.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.repository.id": "692042935",
    "github.repository.name": "plengauer/opentelemetry-bash",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.event.ref": "refs/heads/main",
    "github.event.ref.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.event.ref.name": "main",
    "github.event.actor.id": "100447901",
    "github.event.actor.name": "plengauer",
    "github.event.name": "push",
    "github.workflow.run.id": "11679018075",
    "github.workflow.run.attempt": "1",
    "github.workflow.ref": "plengauer/opentelemetry-bash/.github/workflows/publish_main.yaml@refs/heads/main",
    "github.workflow.sha": "37a696c41f99f79f664623e6ccbd41da0b6fbba4",
    "github.workflow.name": "Publish",
    "github.job.name": "demo-generate",
    "github.step.name": "",
    "github.action.name": "demo",
    "process.pid": 3541,
    "process.parent_pid": 3540,
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
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "247032b67c24a11b",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "onboarding",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795516676000000,
  "time_end": 1730795516676390700,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "17c339d746fb6e94",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "update",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1730795516676000000,
  "time_end": 1730795516676578000,
  "attributes": {},
  "resource_attributes": {
    "service.name": "renovate",
    "telemetry.sdk.language": "nodejs",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "bcac510b3f392a72594b76a1caa422a8",
  "span_id": "ba4945d6c9f2206a",
  "parent_span_id": "63e58ce58100bc7e",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1730795516678000000,
  "time_end": 1730795516844921000,
  "attributes": {
    "http.url": "https://api.github.com/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "http.method": "GET",
    "http.target": "/repos/plengauer/opentelemetry-bash/contents/.github/renovate.json",
    "net.peer.name": "api.github.com",
    "http.host": "api.github.com:443",
    "http.user_agent": "RenovateBot/39.0.3 (https://github.com/renovatebot/renovate)",
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
    "telemetry.sdk.version": "1.27.0",
    "service.namespace": "renovatebot.com",
    "service.version": "39.0.3"
  },
  "links": [],
  "events": []
}
```
