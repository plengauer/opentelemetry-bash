#!/opt/opentelemetry_shell/venv/bin/python
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
from opentelemetry.sdk.trace.export import SimpleSpanProcessor, BatchSpanProcessor, ConsoleSpanExporter
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.trace.propagation.tracecontext import TraceContextTextMapPropagator

from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader, ConsoleMetricExporter
from opentelemetry.exporter.otlp.proto.http.metric_exporter import OTLPMetricExporter

from opentelemetry.sdk._logs import LoggerProvider, LoggingHandler, LogRecord
from opentelemetry.sdk._logs._internal import SeverityNumber
from opentelemetry.sdk._logs.export import BatchLogRecordProcessor, ConsoleLogExporter
from opentelemetry.exporter.otlp.proto.http._log_exporter import OTLPLogExporter

class GithubActionResourceDetector(ResourceDetector):
    def detect(self) -> Resource:
        try:
            if not 'GITHUB_RUN_ID' in os.environ:
                return Resource.create({});
            return Resource.create({
                'github.repository.id': os.environ.get('GITHUB_REPOSITORY_ID', ''),
                'github.repository.name': os.environ.get('GITHUB_REPOSITORY', ''),
                'github.repository.owner.id': os.environ.get('GITHUB_REPOSITORY_OWNER_ID', ''),
                'github.repository.owner.name': os.environ.get('GITHUB_REPOSITORY_OWNER', ''),
                'github.event.ref': os.environ.get('GITHUB_REF', ''),
                'github.event.actor.id': os.environ.get('GITHUB_ACTOR_ID', ''),
                'github.event.actor.name': os.environ.get('GITHUB_ACTOR', ''),
                'github.event.name': os.environ.get('GITHUB_EVENT_NAME', ''),
                'github.workflow.run.id': os.environ.get('GITHUB_RUN_ID', ''),
                'github.workflow.ref': os.environ.get('GITHUB_WORKFLOW_REF', ''),
                'github.workflow.name': os.environ.get('GITHUB_WORKFLOW', ''),
                'github.job.name': os.environ.get('GITHUB_JOB', ''),
                'github.action.name': os.environ.get('GITHUB_ACTION', ''),
            })
        except:
            return Resource.create({})

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

class OracleResourceDetector(ResourceDetector):
    def detect(self) -> Resource:
        try:
            metadata = self.fetch_metadata()
            resource = Resource.create({
                "cloud.provider": "oracle",
                "cloud.region": metadata['region'],
                "cloud.availability_zone": metadata['availabilityDomain'],
                "cloud.account_id": metadata['tenantId'],
                "host.type": metadata['shape'],
                "host.name": metadata['hostname'],
                "host.id": metadata['id'],
                "host.image_id": metadata['image']
            })
            return resource
        except Exception:
            return Resource({})

    def fetch_metadata(self):
        response = requests.get('http://169.254.169.254/opc/v1/instance/', headers={'Authorization': 'Bearer Oracle'})
        response.raise_for_status()  # Raise an exception for 4xx or 5xx status codes
        return response.json()

resource = {}
spans = {}
next_span_id = 0
events = {}
next_event_id = 0
metrics = {}
next_metric_id = 0

auto_end = False

def main():
    scope = sys.argv[1]
    version = sys.argv[2]
    for line in sys.stdin:
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
            print('SDK Error: ' + line, file=sys.stderr)
            traceback.print_exc()
    try:
        handle(scope, version, 'SHUTDOWN', None)
    except EOFError:
        sys.exit(0)

def handle(scope, version, command, arguments):
    global auto_end
    if command == 'RESOURCE_ATTRIBUTE':
        tokens = arguments.split(' ', 1)
        type = tokens[0]
        arguments = tokens[1]
        tokens = arguments.split('=', 1)
        key = tokens[0]
        value = tokens[1]
        resource[key] = convert_type(type, value)
    elif command == 'INIT':
        final_resources = get_aggregated_resources([
                AwsEC2ResourceDetector(),
                OracleResourceDetector(),
                KubernetesResourceDetector(),
                DockerResourceDetector(),
                GithubActionResourceDetector(),
                OTELResourceDetector(),
            ]).merge(Resource.create(resource))

        traces_exporters = os.environ.get('OTEL_TRACES_EXPORTER', 'otlp')
        metrics_exporters = os.environ.get('OTEL_METRICS_EXPORTER', 'otlp')
        logs_exporters = os.environ.get('OTEL_LOGS_EXPORTER', 'otlp')
        propagator = os.environ.get('OTEL_PROPAGATORS', 'tracecontext');

        if propagator != 'tracecontext':
          raise Exception('Unsupported propagator: ' + propagator);

        if traces_exporters:
            tracer_provider = TracerProvider(sampler=sampling.DEFAULT_ON, resource=final_resources)
            for traces_exporter in traces_exporters.split(','):
                if traces_exporter == '':
                    pass
                elif traces_exporter == 'console':
                    tracer_provider.add_span_processor(SimpleSpanProcessor(ConsoleSpanExporter()))
                elif traces_exporter == 'otlp':
                    tracer_provider.add_span_processor(BatchSpanProcessor(OTLPSpanExporter()))
                else:
                    raise Exception('Unknown exporter: ' + traces_exporter)
            opentelemetry.trace.set_tracer_provider(tracer_provider)

        if metrics_exporters:
            metric_readers = []
            for metrics_exporter in metrics_exporters.split(','):
                if metrics_exporter == '':
                    pass
                elif metrics_exporter == 'console':
                    metric_readers.append(PeriodicExportingMetricReader(ConsoleMetricExporter()))
                elif metrics_exporter == 'otlp':
                    metric_readers.append(PeriodicExportingMetricReader(OTLPMetricExporter()))
                else:
                    raise Exception('Unknown exporter: ' + metrics_exporter)
            opentelemetry.metrics.set_meter_provider(MeterProvider(metric_readers = metric_readers, resource=final_resources))

        if logs_exporters:
            logger_provider = LoggerProvider(resource=final_resources)
            for logger_exporter in logs_exporters.split(','):
                if logger_exporter == '':
                    pass
                elif logger_exporter == 'console':
                    logger_provider.add_log_record_processor(BatchLogRecordProcessor(ConsoleLogExporter()))
                elif logger_exporter == 'otlp':
                    logger_provider.add_log_record_processor(BatchLogRecordProcessor(OTLPLogExporter()))
                else:
                    raise Exception('Unknown exporter: ' + logger_exporter)
            opentelemetry._logs.set_logger_provider(logger_provider)

    elif command == 'SHUTDOWN':
        if auto_end:
            for span in spans.values():
                span.end()
        opentelemetry.trace.get_tracer_provider().shutdown()
        opentelemetry.metrics.get_meter_provider().shutdown()
        opentelemetry._logs.get_logger_provider().shutdown()
        raise EOFError
    elif command == 'SPAN_START':
        global next_span_id
        tokens = arguments.split(' ', 3)
        response_path = tokens[0]
        traceparent = tokens[1]
        kind = tokens[2]
        name = tokens[3]
        span_id = next_span_id
        next_span_id = next_span_id + 1
        span = opentelemetry.trace.get_tracer(scope, version).start_span(name, kind=SpanKind[kind.upper()], context=TraceContextTextMapPropagator().extract({'traceparent': traceparent}))
        spans[str(span_id)] = span
        with open(response_path, 'w') as response:
            response.write(str(span_id))
        auto_end = False
    elif command == 'SPAN_END':
        span_id = arguments
        span : Span = spans[span_id]
        span.end()
        del spans[span_id]
    elif command == 'SPAN_HANDLE':
        tokens = arguments.split(' ', 1)
        response_path = tokens[0]
        traceparent = tokens[1]
        context = opentelemetry.trace.get_current_span(TraceContextTextMapPropagator().extract({'traceparent': traceparent})).get_span_context()
        for span_id, span in spans.items():
            if span.context.span_id == context.span_id:
                with open(response_path, 'w') as response:
                    response.write(str(span_id))
                    return
    elif command == 'SPAN_AUTO_END':
        auto_end = True
    elif command == 'SPAN_ERROR':
        span : Span = spans[arguments]
        span.set_status(StatusCode.ERROR)
    elif command == 'SPAN_ATTRIBUTE':
        tokens = arguments.split(' ', 2)
        span_id = tokens[0]
        type = tokens[1]
        keyvaluepair = tokens[2]
        tokens = keyvaluepair.split('=', 1)
        key = tokens[0]
        value = tokens[1]
        if value == '':
            return
        span : Span = spans[span_id]
        span.set_attribute(key, convert_type(type, value))
    elif command == 'SPAN_TRACEPARENT':
        tokens = arguments.split(' ', 1)
        response_path = tokens[0]
        span_id = tokens[1]
        span : Span = spans[span_id]
        carrier = {}
        TraceContextTextMapPropagator().inject(carrier, opentelemetry.trace.set_span_in_context(span, None))
        with open(response_path, 'w') as response:
            response.write(carrier.get('traceparent', ''))
    elif command == 'EVENT_CREATE':
        global next_event_id
        tokens = arguments.split(' ', 1)
        response_path = tokens[0]
        event_name = tokens[1]
        event_id = str(next_event_id)
        next_event_id = next_event_id + 1
        events[event_id] = { 'name': event_name, 'attributes': {} }
        with open(response_path, 'w') as response:
            response.write(event_id)
    elif command == 'EVENT_ATTRIBUTE':
        tokens = arguments.split(' ', 2)
        event_id = tokens[0]
        type = tokens[1]
        keyvaluepair = tokens[2]
        tokens = keyvaluepair.split('=', 1)
        key = tokens[0]
        value = tokens[1]
        if value == '':
            return
        events[event_id]['attributes'][key] = convert_type(type, value)
    elif command == 'EVENT_ADD':
        tokens = arguments.split(' ', 2)
        event_id = tokens[0]
        span_id = tokens[1]
        event = events[event_id]
        spans[span_id].add_event(event['name'], event['attributes'])
        del events[event_id]
    elif command == 'METRIC_CREATE':
        global next_metric_id
        tokens = arguments.split(' ', 1)
        response_path = tokens[0]
        metric_name = tokens[1]
        metric_id = str(next_metric_id)
        next_metric_id = next_metric_id + 1
        metrics[metric_id] = { 'name': metric_name, 'attributes': {} }
        with open(response_path, 'w') as response:
            response.write(metric_id)
    elif command == 'METRIC_ATTRIBUTE':
        tokens = arguments.split(' ', 2)
        metric_id = tokens[0]
        type = tokens[1]
        keyvaluepair = tokens[2]
        tokens = keyvaluepair.split('=', 1)
        key = tokens[0]
        value = tokens[1]
        if value == '':
            return
        metrics[metric_id]['attributes'][key] = convert_type(type, value)
    elif command == 'METRIC_ADD':
        tokens = arguments.split(' ', 1)
        metric_id = tokens[0]
        value = float(tokens[1])
        metric = metrics[metric_id]
        opentelemetry.metrics.get_meter(scope, version).create_counter(metric['name']).add(value, metric['attributes'])
        del metrics[metric_id]
    elif command == 'LOG_RECORD':
        tokens = arguments.split(' ', 1)
        traceparent = tokens[0]
        line = tokens[1] if len(tokens) > 1 else ""
        if len(line) == 0:
            return
        context = opentelemetry.trace.get_current_span(TraceContextTextMapPropagator().extract({'traceparent': traceparent})).get_span_context()
        logger = opentelemetry._logs.get_logger(scope, version)
        record = LogRecord(
            timestamp=int(time.time() * 1e9),
            trace_id=context.trace_id,
            span_id=context.span_id,
            trace_flags=context.trace_flags,
            severity_text='unspecified',
            severity_number=SeverityNumber.UNSPECIFIED,
            body=line,
            resource=logger.resource if hasattr(logger, "resource") else Resource.create({}),
        )
        logger.emit(record)
    else:
        return

def convert_type(type, value):
    if type == 'string':
        return value
    elif type == 'int':
        return int(value)
    elif type == 'float':
        return float(value)
    elif type == 'string[1]':
        return [ value ];
    elif type == 'auto':
        try:
            return int(value)
        except:
            pass
        try:
            return float(value)
        except:
            pass
        return value
    else:
        raise Exception('Unknown type: ' + type)

if __name__ == "__main__":
    main()

