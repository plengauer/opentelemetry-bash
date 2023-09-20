This project delivers OpenTelemetry traces from bash scripts. Compared to other similar projects, it delivers not just an SDK to create spans manually, but also provides context propagation via HTTP (wget and curl), auto-instrumentation for selected commands, custom instrumentations, and auto-injection into child bash scripts. Its installable via a debian package from the releases in this repository, or from the apt-repository below.

Use it to manually create spans:
```bash
#!/bin/bash
export OTEL_SERVICE_NAME=Test
export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=...
export OTEL_EXPORTER_OTLP_TRACES_HEADERS=...
. /usr/bin/opentelemetry_bash_sdk.sh
# initialize the sdk
otel_init

# create a default span for the job
otel_observe echo "hello world"

# create a manual span for the job with a custom attribute
otel_span_start
otel_span_attrbibute key=value
echo "hello world again"
otel_span_end

# flush and shutdown the sdk
otel_shutdown
```

Use it to automatically instrument and inject into child scripts:
```bash
#!/bin/bash
export OTEL_SERVICE_NAME=Test
export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=...
export OTEL_EXPORTER_OTLP_TRACES_HEADERS=...
. /usr/bin/opentelemetry_bash.sh

# create spans for all echo's, both in this script and all child scripts
otel_instrument echo

echo "hello world" # this will create a span
echo "hello world again" # this as well

curl http://www.google.com # this will create a http client span and inject w3c tracecontext

bash ./print_hello_world.sh # this will create a span for the script
# it will also auto-instrument all jobs just like in this script,
# auto-inject into its childen, even without the init code at the start
```

Install either from https://github.com/plengauer/opentelemetry-bash/releases/latest or via
```bash
echo "deb [arch=all] https://3.73.14.87:8000/ stable main" | sudo tee /etc/apt/sources.list.d/example.list
sudo apt-get update
sudo apt-get install opentelemetry-bash
```
