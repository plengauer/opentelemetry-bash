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
```
## Full Trace
```
{
  "trace_id": "a42372f8fd13efc9d509074971419fa3",
  "span_id": "05f6e644152824bf",
  "parent_span_id": "07d063694cc0c4be",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1743514114155628949,
  "time_end": 1743514114333498472,
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
    "host.name": "fv-az1704-417",
    "os.description": "Linux 6.8.0-1021-azure",
    "os.type": "linux",
    "process.command_args": [
      "/usr/lib/jvm/temurin-17-jdk-amd64/bin/java",
      "Main"
    ],
    "process.executable.path": "/usr/lib/jvm/temurin-17-jdk-amd64/bin/java",
    "process.pid": 4669,
    "process.runtime.description": "Eclipse Adoptium OpenJDK 64-Bit Server VM 17.0.14+7",
    "process.runtime.name": "OpenJDK Runtime Environment",
    "process.runtime.version": "17.0.14+7",
    "service.instance.id": "d64e04e6-32e7-485f-a534-35fea08764f0",
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
```
