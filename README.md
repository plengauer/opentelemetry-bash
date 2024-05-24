This project delivers [OpenTelemetry](https://opentelemetry.io/) traces, metrics and logs from shell scripts (sh, ash, dash, bash, and all POSIX compliant shells). Compared to similar projects, it delivers not just a command-line SDK to create spans manually, but also provides context propagation via HTTP (wget and curl), auto-instrumentation of all available commands, auto-injection into child scripts and into executables using shebangs, as well as automatic log collection from stderr. Its installable via a debian package from the releases in this repository, or from the apt-repository below. This project is not officially affiliated with the CNCF project [OpenTelemetry](https://opentelemetry.io/).

[![Build](https://github.com/plengauer/opentelemetry-bash/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/plengauer/opentelemetry-bash/actions/workflows/build.yaml)
[![Tests](https://github.com/plengauer/opentelemetry-bash/actions/workflows/test.yaml/badge.svg?branch=main)](https://github.com/plengauer/opentelemetry-bash/actions/workflows/test.yaml)
[![Publish](https://github.com/plengauer/opentelemetry-bash/actions/workflows/publish.yaml/badge.svg?branch=main)](https://github.com/plengauer/opentelemetry-bash/actions/workflows/publish.yaml)

# Overview
A simple command like `curl http://www.google.at` on an AWS EC2 will produce a span like this:
```json
{
    "name": "curl http://www.google.at",
    "context": {
        "trace_id": "0xfecf2bf60c1433a33fc3b3715100f44a",
        "span_id": "0x0441d068e0d7d83a",
        "trace_state": "[]"
    },
    "kind": "SpanKind.CLIENT",
    "parent_id": "0x31877863ebe897a6",
    "start_time": "2024-04-07T15:27:35.230551Z",
    "end_time": "2024-04-07T15:27:35.790162Z",
    "status": {
        "status_code": "UNSET"
    },
    "attributes": {
        "shell.command_line": "curl http://www.google.at",
        "shell.command": "curl",
        "shell.command.type": "file",
        "shell.command.name": "curl",
        "subprocess.executable.path": "/usr/bin/curl",
        "subprocess.executable.name": "curl",
        "network.protocol.name": "http",
        "network.transport": "tcp",
        "http.request.method": "GET",
        "server.address": "www.google.at",
        "url.full": "http://www.google.at",
        "url.path": "/",
        "url.scheme": "http",
        "network.peer.address": "172.217.18.3",
        "network.peer.port": 80,
        "http.request.header.host": [ "www.google.at" ],
        "user_agent.original": "curl/8.2.1",
        "http.request.header.user-agent": [ "curl/8.2.1" ],
        "http.request.header.accept": [ "*/*" ],
        "http.request.header.traceparent": [ "00-fecf2bf60c1433a33fc3b3715100f44a-0441d068e0d7d83a-01" ],
        "http.response.status_code": 200,
        "http.response.header.date": [ "Sun, 07 Apr 2024 15:27:35 GMT" ],
        "http.response.header.expires": [ "-1" ],
        "http.response.header.cache-control": [ "private, max-age=0" ],
        "http.response.header.content-type": [ "text/html; charset=ISO-8859-1" ],
        "http.response.header.content-security-policy-report-only": [ "object-src 'none';base-uri 'self';script-src 'nonce-Z06PcaKXtGYEozZ8RwkRlA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp" ],
        "http.response.header.server": [ "gws" ],
        "http.response.header.x-xss-protection": [ "0" ],
        "http.response.header.x-frame-options": [ "SAMEORIGIN" ],
        "http.response.header.set-cookie": [ "AEC=AQTF6HxUMJNiGOP4fGxONroFJ61uidlU9uiGQsHcvRug4cz-d5iOLWCN7Q; expires=Fri, 04-Oct-2024 15:27:35 GMT; path=/; domain=.google.at; Secure; HttpOnly; SameSite=lax" ],
        "http.response.header.accept-ranges": [ "none" ],
        "http.response.header.vary": [ "Accept-Encoding" ],
        "http.response.header.transfer-encoding": [ "chunked" ],
        "http.response.body.size": 11984,
        "pipe.stdin.bytes": 0,
        "pipe.stdin.lines": 0,
        "pipe.stdout.bytes": 18750,
        "pipe.stdout.lines": 16,
        "pipe.stderr.bytes": 391,
        "pipe.stderr.lines": 4,
        "shell.command.exit_code": 0,
        "code.filepath": "./otel_demo_curl.sh",
        "code.lineno": 2,
    },
    "events": [],
    "links": [],
    "resource": {
        "attributes": {
            "telemetry.sdk.language": "shell",
            "telemetry.sdk.name": "opentelemetry",
            "telemetry.sdk.version": "4.2.1",
            "deployment.environment": "development",
            "service.name": "DemoService",
            "cloud.provider": "aws",
            "cloud.platform": "aws_ec2",
            "cloud.account.id": "785162395342",
            "cloud.region": "eu-central-1",
            "cloud.availability_zone": "eu-central-1b",
            "host.id": "i-099942b18fe209756",
            "host.type": "t3.small",
            "host.name": "ip-172-31-41-64.eu-central-1.compute.internal",
            "process.pid": 798293,
            "process.parent_pid": 786902,
            "process.executable.name": "bash",
            "process.executable.path": "/usr/bin/bash",
            "process.command_line": "bash ./otel_demo_curl.sh",
            "process.command": "bash",
            "process.owner": "ubuntu",
            "process.runtime.name": "bash",
            "process.runtime.description": "Bourne Again Shell",
            "process.runtime.version": "5.2.15-2ubuntu1",
            "process.runtime.options": "hB",
            "service.version": "1.0.0",
            "service.namespace": "Demo",
            "service.instance.id": ""
        },
        "schema_url": ""
    }
}
```

## Try For Yourself
Install as described below. Put the following code at the start of an arbitrary script:
```bash
export OTEL_METRICS_EXPORTER=console
export OTEL_LOGS_EXPORTER=console
export OTEL_TRACES_EXPORTER=console
. otel.sh
```
Finally, run your script and see traces, metrics, and logs printed to stderr.

# Installation
Install either via
```bash
wget -O - https://raw.githubusercontent.com/plengauer/opentelemetry-bash/main/INSTALL.sh | sh
```
or via
```bash
echo "deb [arch=all] https://3.73.14.87:8000/ stable main" | sudo tee /etc/apt/sources.list.d/otel.list
sudo apt-get update
sudo apt-get install opentelemetry-shell
```

# Documentation
You can either use the fully automatic instrumentation (recommended) or just import the API to do everything manually. In both cases, you can use the API to manually create customized spans and metrics. However, the automatic approach creates rich spans and logs fully automatically. We recommend to use the manual approach only to augment the automatic approach where necessary.

## Automatic Instrumentation
Import the OpenTelemetry auto instrumentation as well as the API by sourcing the `otel.sh` file. This will both import the API described below (in case you need or want to extend manually) as well as initialize the SDK and the auto instrumentation. No explicit calls to `otel_init` at the start or to `otel_shutdown` at the end of the script are necessary. You can configure the SDK as described <a href="https://opentelemetry.io/docs/languages/sdk-configuration/">here</a>. We recommend not just setting configuration variables, but also exporting them so that automatically injected children inherit the same configuration.
```bash
export OTEL_SERVICE_NAME=Test
export OTEL_RESOURCE_ATTRIBUTES=foo=bar,baz=foo
# TODO more config
. otel.sh
# ...
```

All commands are automatically instrumented to create spans. This includes commands on the `PATH`, as well as all aliases and built-ins. Current limitations are shell functions as well as commands that are called via an absolute or relative path (`/bin/cat` rather than `cat`). For these cases, you can use `otel_observe` described below.
For all commands, attributes of the `shell.*` (describing the command being run), `pipe.*` (describing behavior of stdin, stdout, and stderr), `subprocess.executable.*` (describing the executable being run if any), and `code.*` (describing the location in the script) families are recorded. Additionally, all lines written to stderr are recorded as logs.

If the command is a shell or an executable with a shebang (meaning it itself is script rather a than a binary), OpenTelemetry will be automatically injected into it to continue observation. No setup code or configuration is necessary in these children.
If the command is just a wrapper for another command (e.g., `sudo`, `find`, `xargs`, `parallel`, ...), OpenTelemetry will automatically be injected into the inner command to continue observation as well.
If the command represents communication to a third party service (like a HTTP request via `curl` or `wget`), relevant attributes from the `http.*`, `server.*`, `url.*`, and `network.*` families are added. Additionally, a W3C traceparent header is injected.

Finally, a single root span will be created and activated that represents the script. This span will automatically be deactivated and ended when the script ends.

## Automatic Instrumentation of Github Actions
To automatically monitor your Github Workflows on job level and to auto-inject into all `run` steps, add the following step as first in every job you want to observe. You can configure the SDK as described <a href="https://opentelemetry.io/docs/languages/sdk-configuration/">here</a> by adding environment variables to the setup step.
```yaml
- uses: plengauer/opentelemetry-bash/actions/instrument/job@main
  env:
    OTEL_SERVICE_NAME: 'Test'
    # ...
- run: ...
```

Optionally, setup a dedicted job that is used to collect all jobs under a single root span representing the entire workflow. The job has to have exactly the name below and must neither depend on any other job nor being depent on.
```yaml
observe:
  runs-on: ubuntu-latest
  steps:
    - uses: plengauer/opentelemetry-bash/actions/instrument/workflow@main
      env:
        OTEL_SERVICE_NAME: ${{ secrets.SERVICE_NAME }}
        # ...
```
If you define that job to create a single root span for all other jobs, only the step in this root job has to be configured. The configuration will be propagated to the other jobs. The only exception to that are OpenTelemetry SDK Header configurations because they often contain API tokens and we cannot securely propagate these between jobs.

## Manual Instrumentation
Import the API by referencing the `otelapi.sh` file. This is only necessary if you do not choose a fully automatic approach described above. In case you use automatic instrumentation, the API will be imported automatically for you.
The SDK needs to be initialized and shut down manually at the start and at the end of your script respectively. All config must be set before the call to `otel_init`. You can configure the underlying SDK with the same variables as any other OpenTelemetry SDK as described <a href="https://opentelemetry.io/docs/languages/sdk-configuration/">here</a>. We recommend not just setting the environment variables, but also exporting them so that automatically injected children inherit the same configuration.
```bash
export OTEL_SERVICE_NAME=Test
export OTEL_RESOURCE_ATTRIBUTES=foo=bar,baz=foo
# TODO more config
. otelapi.sh

otel_init
# ... 
otel_shutdown
```

## Configuration
You can configure the underlying SDK with the same variables as any other OpenTelemetry SDK as described <a href="https://opentelemetry.io/docs/languages/sdk-configuration/">here</a>. In addition to that, use the following environment variables to further configure behavior of this project:
| Variable                                     | Values          | Default | Description                                                                                 |
| -------------------------------------------- | --------------- | ------- | ------------------------------------------------------------------------------------------- |
| OTEL_SHELL_EXPERIMENTAL_OBSERVE_PIPES        | `TRUE`, `FALSE` | `FALSE` | Count bytes and lines on stdin, stdout, and stderr and add counts as attributes on spans.   |
| OTEL_SHELL_EXPERIMENTAL_INSTRUMENT_MINIMALLY | `TRUE`, `FALSE` | `FALSE` | Only create `SERVER`, `CONSUMER`, `CLIENT` and `PRODUCER` spans, mute all `INTERNAL` spans. |

## Traces
The API described below is for manually creating and customizing spans. We recommend to do this only if the automatic instrumentation is not sufficient.

### Spans
Create spans with a span kind (`SERVER`, `CONSUMER`, `CLIENT`, `PRODUCER`, `INTERNAL`) and an arbitrary name. The returned span handle is used to end the span and to customize it (see below). The span handle is similar to a file descriptor. It is only valid within this process and used for subsequent calls for customization. It is not the actual span ID.
```bash
span_handle="$(otel_span_start INTERNAL my span)"
# ... 
otel_span_end "$span_handle"
```

Creating a span alone will not make new spans its children (see span activation below). Start and end time of the span as well as its parent (if another span is currently active) is automatically recorded.

### Span Attributes
Customize your spans by manually setting span attributes with the span handle. This is only possible between `otel_span_start` and `otel_span_end` for the respective span handle. Valid types are `string`, `int`, `float`, and `auto`. The `auto` type will try to guess the type based on the value.
```bash
otel_span_attribute "$span_handle" key=value
otel_span_attribute_typed "$span_handle" string foo=bar
otel_span_attribute_typed "$span_handle" int numberkey=0
```

### Span Events
Customize your spans by manually adding span events with the span handle. This is only possible between `otel_span_start` and `otel_span_end` for the respective span handle. Valid types for event attributes `string`, `int`, `float`, and `auto`. The `auto` type will try to guess the type based on the value.
```bash
event_handle="$(otel_event_create "my event")"
otel_event_attribute "$event_handle" key=value
otel_event_attribute_typed "$event_handle" string foo=bar
otel_event_add "$event_handle" "$span_handle"
```

### Span Error
Customize your spans by marking them as failed. This is only possible between `otel_span_start` and `otel_span_end` for the respective span handle.
```bash
otel_span_error "$span_handle"
```

### Span Activation
Customize your spans by marking them as failed. This is only possible between `otel_span_start` and `otel_span_end` for the respective span handle. Please note, that `span_start` does not automatically activate a span, nor does `span_end` automatically deactivate it.
```bash
otel_span_activate "$span_handle"
# ... all spans created here will be children of the activated span
otel_span_deactivate
```

### Semi-automatic Spans 
The easiest way to create a span manually and fill it with some simple default attributes is to use the command `otel_observe`. This command acts as a wrapper for the given command. It first starts an `INTERNAL` span with the command as name, records some default attributes, activates the span (in case the command in turn creates spans), and then runs the command. After the command terminates, it deactivates the span and ends it. The automatically recorded attributes are of the `shell.*`, `pipe.*`, and `subprocess.executable.*` families. All lines, written to stderr will be recorded as logs. The command is fully transparent in its behavior, i.e., stdin, stdout, and stderr of the wrapped command are piped to the caller accordingly, and the command exits with the same exit code as the wrapped command does.
```bash
otel_observe cat file.txt
```

Please note, that this command will not perform injection or context propagation. This can only be done via the fully automatic approach described above.

## Metrics
To record metrics, first create a new metric with a key to get a metric handle. The returned metric handle is used to customize the metric data point and record its value. Valid types are `string`, `int`, `float`, and `auto`. The `auto` type will try to guess the type based on the value.
```bash
metric_handle="$(otel_metric_create my.metric)"
otel_metric_attribute "$metric_handle" key=value
otel_metric_attribute_typed "$metric_handle" string foo=bar
otel_metric_add "$metric_handle" 42
```

## Logs
As of now, there is no way to manually record logs. Logs, i.e., lines that are written to stderr, are recorded automatically when using auto-instrumentation and when using `otel_observe` as described above.

# Performance
Every command executed in an automatically instrumented script produces a small amount of constant overhead. This is usually not a problem, especially in traditional scripts where the heavy lifting is done within external processes and not in the script itself.

When a script is instrumented for the first time, instrumenting will cause some additional overhead. To speed up subsequent invocations of the same script, an instrumentation cache is created. The cache will be invalidated if the script changes or additional executables are installed on the system and will be automatically rebuilt on the next invocation of the script.

# Extension to Semantic Conventions
This projects adheres to the <a href="https://opentelemetry.io/docs/specs/semconv">OpenTelemetry Semantic Conventions</a>, but it also defines a number of shell-specifc extensions.

## Shell Commands
| Attribute               | Type   | Description                                                                                     | Examples                                          |
| ----------------------- | ------ | ----------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| shell.command_line      | string | The full command line as it appears in the script, with all variables resolved to their values. | `echo hello world`, `/bin/cat file.txt`           |
| shell.command           | string | The 0-th string of the command line.                                                            | `echo`, `/bin/cat`                                |
| shell.command.name      | string | The 0-th string of the command line resolved to its name only.                                  | `echo`, `cat`                                     |
| shell.command.type      | string | The type of the command.                                                                        | `file`, `builtin`, `function`, `alias`, `keyword` |
| shell.command.exit_code | int    | The exit code of the command.                                                                   | `0`, `1`, `127`                                   |

## Pipes
| Attribute         | Type | Description                                   | Examples |
| ----------------- | ---- | --------------------------------------------- | -------- |
| pipe.stdin.bytes  | int  | The number of bytes read from stdin (fd 0).   | `0`      |
| pipe.stdin.lines  | int  | The number of lines read from stdin (fd 0).   | `0`      |
| pipe.stdout.bytes | int  | The number of bytes written to stdout (fd 1). | `0`      |
| pipe.stdout.lines | int  | The number of lines written to stdout (fd 1). | `0`      |
| pipe.stderr.bytes | int  | The number of bytes written to stderr (fd 2). | `0`      |
| pipe.stderr.lines | int  | The number of lines written to stderr (fd 2). | `0`      |


## SSH
These attributes are set when the script is called via an SSH connection.
| Attribute | Type   | Description                                           | Examples  |
| --------- | ------ | ----------------------------------------------------- | --------- |
| ssh.ip    | string | The IP address of the ssh deamon used for connecting. | `1.1.1.1` |
| ssh.port  | int    | The port of the ssh deamon used for connecting.       | `1.1.1.1` |

## Debian
These attributes are set when the script is a debian package maintainer script (`preinst`, `postinst`, `prerm`, `postrm`)
| Attribute              | Type   | Description                 | Examples              |
| ---------------------- | ------ | --------------------------- | --------------------- |
| debian.package.name    | string | The name of the package.    | `opentelemetry-shell` |
| debian.package.version | string | The version of the package. | `1.2.3`               |
