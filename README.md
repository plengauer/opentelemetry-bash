This project delivers [OpenTelemetry](https://opentelemetry.io/) traces, metrics and logs from shell scripts (sh, ash, dash, bash, and all POSIX compliant shells). Compared to similar projects, it delivers not just a command-line SDK to create spans manually, but also provides context propagation via HTTP (wget and curl), auto-instrumentation, auto-injection into child scripts and into commands using shebangs, as well as automatic log collection from stderr. Its installable via a debian package from the releases in this repository, or from the apt-repository below. This project is not officially affiliated with the CNCF project [OpenTelemetry](https://opentelemetry.io/).

Use it to manually create spans and metrics (see automatic below):
```bash
#!/bin/bash

# configure SDK according to https://opentelemetry.io/docs/languages/sdk-configuration/
export OTEL_SERVICE_NAME=Test
# currently, only 'otlp' and 'console' are supported as exporters
# currently, only 'tracecontext' is supported as propagator

# import API
. otelapi.sh

# initialize the sdk
otel_init

# create a default span for the command
# all lines written to stderr will be collected as logs
otel_observe echo "hello world"

# create a manual span with a custom attribute
span_handle=$(otel_span_start INTERNAL myspan)
otel_span_attribute $span_handle key=value
echo "hello world again"
otel_span_end $span_handle

# write a metric data point with custom attributes
metric_handle=$(otel_metric_create my.metric)
otel_metric_attribute $metric_handle foo=bar
otel_metric_add $metric_handle 42

# flush and shutdown the sdk
otel_shutdown
```

Use it to automatically instrument and inject into child scripts:
```bash
#!/bin/bash

# configure SDK according to https://opentelemetry.io/docs/languages/sdk-configuration/
export OTEL_SERVICE_NAME=Test

# init automatic instrumentation, automatic context propagation, and automatic log collection
. otel.sh

echo "hello world" # this will create a span
echo "hello world again" # this as well

curl http://www.google.com # this will create a http client span and inject w3c tracecontext

# the following script (and all its direct and indirect children) will be auto-injected without the init code being necessary
bash ./print_hello_world.sh
```

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
        "server.port": "",
        "url.full": "http://www.google.at",
        "url.path": "/",
        "url.query": "",
        "url.scheme": "http",
        "network.peer.address": "172.217.18.3",
        "network.peer.port": "80",
        "http.request.header.host": "www.google.at",
        "user_agent.original": "curl/8.2.1",
        "http.request.header.user-agent": "curl/8.2.1",
        "http.request.header.accept": "*/*",
        "http.request.header.traceparent": "00-fecf2bf60c1433a33fc3b3715100f44a-0441d068e0d7d83a-01",
        "http.response.status_code": "200",
        "http.response.header.date": "Sun, 07 Apr 2024 15:27:35 GMT",
        "http.response.header.expires": "-1",
        "http.response.header.cache-control": "private, max-age=0",
        "http.response.header.content-type": "text/html; charset=ISO-8859-1",
        "http.response.header.content-security-policy-report-only": "object-src 'none';base-uri 'self';script-src 'nonce-Z06PcaKXtGYEozZ8RwkRlA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp",
        "http.response.header.server": "gws",
        "http.response.header.x-xss-protection": "0",
        "http.response.header.x-frame-options": "SAMEORIGIN",
        "http.response.header.set-cookie": "AEC=AQTF6HxUMJNiGOP4fGxONroFJ61uidlU9uiGQsHcvRug4cz-d5iOLWCN7Q; expires=Fri, 04-Oct-2024 15:27:35 GMT; path=/; domain=.google.at; Secure; HttpOnly; SameSite=lax",
        "http.response.header.accept-ranges": "none",
        "http.response.header.vary": "Accept-Encoding",
        "http.response.header.transfer-encoding": "chunked",
        "http.response.body.size": "11984",
        "pipe.stdin.bytes": "0",
        "pipe.stdin.lines": "0",
        "pipe.stdout.bytes": "18750",
        "pipe.stdout.lines": "16",
        "pipe.stderr.bytes": "391",
        "pipe.stderr.lines": "4",
        "shell.command.exit_code": "0",
        "code.filepath": "./otel_demo_curl.sh",
        "code.lineno": "2",
        "code.function": ""
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
            "process.pid": "798293",
            "process.parent_pid": "786902",
            "process.executable.name": "bash",
            "process.executable.path": "/usr/bin/bash",
            "process.command_line": "bash ./otel_demo_curl.sh",
            "process.command": "bash",
            "process.owner": "ubuntu",
            "process.runtime.name": "bash",
            "process.runtime.description": "Bourne Again Shell",
            "process.runtime.version": "5.2.15-2ubuntu1",
            "process.runtime.options": "hB",
            "service.version": "1.0",
            "service.namespace": "Demo",
            "service.instance.id": ""
        },
        "schema_url": ""
    }
}
```

Install either via
```bash
wget -O - https://raw.githubusercontent.com/plengauer/opentelemetry-bash/main/INSTALL.sh | sh -E
```
or via
```bash
echo "deb [arch=all] https://3.73.14.87:8000/ stable main" | sudo tee /etc/apt/sources.list.d/example.list
sudo apt-get update
sudo apt-get install opentelemetry-shell
```

