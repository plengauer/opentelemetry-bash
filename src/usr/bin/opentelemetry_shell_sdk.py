import sys
import os
import time
import traceback
import json
import requests
import opentelemetry

from opentelemetry.sdk.resources import Resource, ResourceDetector, OTELResourceDetector, get_aggregated_resources
from opentelemetry_resourcedetector_docker import DockerResourceDetector
from opentelemetry_resourcedetector_kubernetes import KubernetesResourceDetector

from opentelemetry.trace import SpanKind
from opentelemetry.sdk.trace import Span, StatusCode, TracerProvider, sampling
from opentelemetry.sdk.trace.export import BatchSpanProcessor, ConsoleSpanExporter
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.trace.propagation.tracecontext import TraceContextTextMapPropagator

from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader, ConsoleMetricExporter
from opentelemetry.exporter.otlp.proto.http.metric_exporter import OTLPMetricExporter

from opentelemetry.sdk._logs import LoggerProvider, LoggingHandler, LogRecord
from opentelemetry.sdk._logs._internal import SeverityNumber
from opentelemetry.sdk._logs.export import BatchLogRecordProcessor, ConsoleLogExporter
from opentelemetry.exporter.otlp.proto.http._log_exporter import OTLPLogExporter

class AwsEC2ResourceDetector(ResourceDetector):
    def detect(self) -> Resource:
        try:
            token = requests.put('http://169.254.169.254/latest/api/token', headers={ 'X-aws-ec2-metadata-token-ttl-seconds': '60' }, timeout=5).text
            identity = requests.get('http://169.254.169.254/latest/dynamic/instance-identity/document', headers={ 'X-aws-ec2-metadata-token': token }, timeout=5).json()
            hostname = requests.get('http://169.254.169.254/latest/meta-data/hostname', headers={ 'X-aws-ec2-metadata-token': token }, timeout=5).text
            return Resource.create({
                'cloud.provider': 'aws',
                'cloud.platform': 'aws_ec2',
                'cloud.account.id': identity['accountId'],
                'cloud.region': identity['region'],
                'cloud.availability_zone': identity['availabilityZone'],
                'host.id': identity['instanceId'],
                'host.type': identity['instanceType'],
                'host.name': hostname
            })
        except:
            return Resource.create({})

resource = {}
spans = {}
metrics = {}

def main():
    fifo_path = sys.argv[1]
    scope = sys.argv[2]
    version = sys.argv[3]
    with open(fifo_path, 'r') as fifo:
        for line in fifo:
            line = line.strip()
            if len(line) == 0:
                continue
            tokens = line.split(' ', 1)
            tokens = [token for token in tokens if token]
            try:
                handle(scope, version, tokens[0], tokens[1] if len(tokens) > 1 else None)
            except EOFError:
                sys.exit(0)
            except:
                traceback.print_exc()

def handle(scope, version, command, arguments):
    if command == 'RESOURCE_ATTRIBUTE':
        key = arguments.split('=', 1)[0]
        value = arguments.split('=', 1)[1]
        resource[key] = value
    elif command == 'INIT':
        final_resources = get_aggregated_resources([
                AwsEC2ResourceDetector(),
                KubernetesResourceDetector(),
                DockerResourceDetector(),
                OTELResourceDetector(),
            ]).merge(Resource.create(resource))

        if os.environ.get('OTEL_SHELL_TRACES_ENABLE') == 'TRUE':
            tracer_provider = TracerProvider(sampler=sampling.DEFAULT_ON, resource=final_resources)
            tracer_provider.add_span_processor(BatchSpanProcessor(ConsoleSpanExporter() if os.environ.get('OTEL_TRACES_CONSOLE_EXPORTER') == 'TRUE' else OTLPSpanExporter()))
            opentelemetry.trace.set_tracer_provider(tracer_provider)

        if os.environ.get('OTEL_SHELL_METRICS_ENABLE') == 'TRUE':
            os.environ['OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE'] = 'delta'
            meter_provider = MeterProvider(metric_readers = [ PeriodicExportingMetricReader(ConsoleMetricExporter() if os.environ.get('OTEL_METRICS_CONSOLE_EXPORTER') == 'TRUE' else OTLPMetricExporter()) ], resource=final_resources)
            opentelemetry.metrics.set_meter_provider(meter_provider)

        if os.environ.get('OTEL_SHELL_LOGS_ENABLE') == 'TRUE':
            logger_provider = LoggerProvider(resource=final_resources)
            logger_provider.add_log_record_processor(BatchLogRecordProcessor(ConsoleLogExporter() if os.environ.get('OTEL_LOGS_CONSOLE_EXPORTER') == 'TRUE' else OTLPLogExporter()))
            opentelemetry._logs.set_logger_provider(logger_provider)
    elif command == 'SHUTDOWN':
        if os.environ.get('OTEL_SHELL_TRACES_ENABLE') == 'TRUE':
            opentelemetry.trace.get_tracer_provider().shutdown()
        if os.environ.get('OTEL_SHELL_METRICS_ENABLE') == 'TRUE':
            opentelemetry.metrics.get_meter_provider().shutdown()
        if os.environ.get('OTEL_SHELL_LOGS_ENABLE') == 'TRUE':
            opentelemetry._logs.get_logger_provider().shutdown()
        raise EOFError
    elif command == 'SPAN_START':
        tokens = arguments.split(' ', 3)
        response_path = tokens[0]
        trace_parent = tokens[1]
        kind = tokens[2]
        name = tokens[3]
        span = opentelemetry.trace.get_tracer(scope, version).start_span(name, kind=SpanKind[kind.upper()], context=TraceContextTextMapPropagator().extract({'traceparent': trace_parent}))
        spans[str(span.context.span_id)] = span
        with open(response_path, 'w') as response:
            response.write(str(span.context.span_id))
    elif command == 'SPAN_END':
        span_id = arguments
        span : Span = spans[span_id]
        span.end()
        del spans[span_id]
    elif command == 'SPAN_ERROR':
        span : Span = spans[arguments]
        span.set_status(StatusCode.ERROR)
    elif command == 'SPAN_ATTRIBUTE':
        tokens = arguments.split(' ', 1)
        span_id = tokens[0]
        keyvaluepair = tokens[1]
        tokens = keyvaluepair.split('=', 1)
        key = tokens[0]
        value = tokens[1]
        span : Span = spans[span_id]
        span.set_attribute(key, value)
    elif command == 'SPAN_TRACEPARENT':
        tokens = arguments.split(' ', 1)
        response_path = tokens[0]
        span_id = tokens[1]
        span : Span = spans[span_id]
        carrier = {}
        TraceContextTextMapPropagator().inject(carrier, opentelemetry.trace.set_span_in_context(span, None))
        with open(response_path, 'w') as response:
            response.write(carrier.get('traceparent', ''))
    elif command == 'METRIC_CREATE':
        tokens = arguments.split(' ', 1)
        response_path = tokens[0]
        metric_name = tokens[1]
        metric_id = "0"
        metrics[metric_id] = { 'name': metric_name, 'attributes': {} }
        with open(response_path, 'w') as response:
            response.write(metric_id)
    elif command == 'METRIC_ATTRIBUTE':
        tokens = arguments.split(' ', 1)
        metric_id = tokens[0]
        keyvaluepair = tokens[1]
        tokens = keyvaluepair.split('=', 1)
        key = tokens[0]
        value = tokens[1]
        metrics[metric_id]['attributes'][key] = value
    elif command == 'METRIC_ADD':
        tokens = arguments.split(' ', 1)
        metric_id = tokens[0]
        value = float(tokens[1])
        metric = metrics[metric_id]
        opentelemetry.metrics.get_meter(scope, version).create_counter(metric['name']).add(value, metric['attributes'])
        del metrics[metric_id]
    elif command == 'LOG_RECORD':
        tokens = arguments.split(' ', 1)
        span_id = tokens[0]
        line = tokens[1] if len(tokens) > 1 else ""
        if len(line) == 0:
            return
        span : Span = spans[span_id]
        logger = opentelemetry._logs.get_logger(scope, version)
        record = LogRecord(
            timestamp=int(time.time() * 1e9),
            trace_id=span.get_span_context().trace_id,
            span_id=span.get_span_context().span_id,
            trace_flags=span.get_span_context().trace_flags,
            severity_text='unspecified',
            severity_number=SeverityNumber.UNSPECIFIED,
            body=line,
            resource=logger.resource if hasattr(logger, "resource") else Resource.create({}),
        )
        logger.emit(record)
    else:
        return

if __name__ == "__main__":
    main()

