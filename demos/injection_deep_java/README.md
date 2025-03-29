# Demo "Deep injection into a Java app"
This script uses a java app and configures opentelemetry to inject into the app and continue tracing.
## Script
```sh
export OTEL_SHELL_CONFIG_INJECT_DEEP=TRUE
. otel.sh
javac Main.java
java Main
rm Main.class
```
## Trace Structure Overview
```
bash -e demo.sh
  javac Main.java
  java Main
    GET
  rm Main.class
```
## Full Trace
```
{
  "trace_id": "105872a0b0b0cc644bac416f51b8e005",
  "span_id": "5c16967c0f10706c",
  "parent_span_id": "25033f7137c05521",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1743240565555998599,
  "time_end": 1743240565750221085,
  "attributes": {
    "url.full": "http://example.com",
    "thread.name": "main",
    "thread.id": 1,
    "http.response.status_code": 200,
    "server.address": "example.com",
    "network.protocol.version": "1.1",
    "http.request.method": "GET"
  },
  "resource_attributes": {
    "host.arch": "amd64",
    "host.name": "fv-az1042-9",
    "os.description": "Linux 6.8.0-1021-azure",
    "os.type": "linux",
    "process.command_args": [
      "/usr/lib/jvm/temurin-17-jdk-amd64/bin/java",
      "Main"
    ],
    "process.executable.path": "/usr/lib/jvm/temurin-17-jdk-amd64/bin/java",
    "process.pid": 4709,
    "process.runtime.description": "Eclipse Adoptium OpenJDK 64-Bit Server VM 17.0.14+7",
    "process.runtime.name": "OpenJDK Runtime Environment",
    "process.runtime.version": "17.0.14+7",
    "service.instance.id": "49878c9c-80b7-46bb-96b7-100ca37536cf",
    "service.name": "unknown_service:java",
    "telemetry.distro.name": "opentelemetry-java-instrumentation",
    "telemetry.distro.version": "2.13.3",
    "telemetry.sdk.language": "java",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "1.47.0"
  },
  "links": [],
  "events": []
}
{
  "trace_id": "105872a0b0b0cc644bac416f51b8e005",
  "span_id": "ea1d168b0f910e8f",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1743240561753972224,
  "time_end": 1743240566017140992,
  "attributes": {},
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.10.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "Thoth",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/Thoth/.github/workflows/refresh_demos.yaml@refs/tags/v5.10.1",
    "github.actions.workflow.sha": "556e327a65f01eb9ac74a5e777b5d5c27f7e88ff",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 3921,
    "process.parent_pid": 2305,
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
  "trace_id": "105872a0b0b0cc644bac416f51b8e005",
  "span_id": "25033f7137c05521",
  "parent_span_id": "ea1d168b0f910e8f",
  "name": "java Main",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1743240562275514368,
  "time_end": 1743240565994636032,
  "attributes": {
    "shell.command_line": "java Main",
    "shell.command": "java",
    "shell.command.type": "file",
    "shell.command.name": "java",
    "subprocess.executable.path": "/usr/bin/java",
    "subprocess.executable.name": "java",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 4
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.10.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "Thoth",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/Thoth/.github/workflows/refresh_demos.yaml@refs/tags/v5.10.1",
    "github.actions.workflow.sha": "556e327a65f01eb9ac74a5e777b5d5c27f7e88ff",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 3921,
    "process.parent_pid": 2305,
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
  "trace_id": "105872a0b0b0cc644bac416f51b8e005",
  "span_id": "953ee3cc79d904ce",
  "parent_span_id": "ea1d168b0f910e8f",
  "name": "javac Main.java",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1743240561766324480,
  "time_end": 1743240562271021312,
  "attributes": {
    "shell.command_line": "javac Main.java",
    "shell.command": "javac",
    "shell.command.type": "file",
    "shell.command.name": "javac",
    "subprocess.executable.path": "/usr/bin/javac",
    "subprocess.executable.name": "javac",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.10.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "Thoth",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/Thoth/.github/workflows/refresh_demos.yaml@refs/tags/v5.10.1",
    "github.actions.workflow.sha": "556e327a65f01eb9ac74a5e777b5d5c27f7e88ff",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 3921,
    "process.parent_pid": 2305,
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
  "trace_id": "105872a0b0b0cc644bac416f51b8e005",
  "span_id": "04f912ec3c6af4c3",
  "parent_span_id": "ea1d168b0f910e8f",
  "name": "rm Main.class",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1743240565999172096,
  "time_end": 1743240566016994048,
  "attributes": {
    "shell.command_line": "rm Main.class",
    "shell.command": "rm",
    "shell.command.type": "file",
    "shell.command.name": "rm",
    "subprocess.executable.path": "/usr/bin/rm",
    "subprocess.executable.name": "rm",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 5
  },
  "resource_attributes": {
    "telemetry.sdk.language": "shell",
    "telemetry.sdk.name": "opentelemetry",
    "telemetry.sdk.version": "5.10.1",
    "service.name": "unknown_service",
    "github.repository.id": "692042935",
    "github.repository.name": "Thoth",
    "github.repository.owner.id": "100447901",
    "github.repository.owner.name": "plengauer",
    "github.actions.workflow.ref": "plengauer/Thoth/.github/workflows/refresh_demos.yaml@refs/tags/v5.10.1",
    "github.actions.workflow.sha": "556e327a65f01eb9ac74a5e777b5d5c27f7e88ff",
    "github.actions.workflow.name": "Refresh Demos",
    "os.type": "linux",
    "os.version": "6.8.0-1021-azure",
    "process.pid": 3921,
    "process.parent_pid": 2305,
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
