import sys
import json
import requests
import opentelemetry
from opentelemetry.sdk.resources import Resource, ResourceDetector, OTELResourceDetector, get_aggregated_resources
from opentelemetry.sdk.trace import TracerProvider, sampling
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry_resourcedetector_docker import DockerResourceDetector
from opentelemetry_resourcedetector_kubernetes import KubernetesResourceDetector
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.trace import SpanKind
from opentelemetry.sdk.trace import Span, StatusCode
from opentelemetry.sdk.resources import Resource
from opentelemetry.trace.propagation.tracecontext import TraceContextTextMapPropagator

class AwsEC2ResourceDetector(ResourceDetector):
    def detect(self) -> Resource:
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

def main():
    fifo_path = sys.argv[1]
    scope = sys.argv[2]
    version = sys.argv[3]
    processor = BatchSpanProcessor(OTLPSpanExporter())
    resource = get_aggregated_resources([
        AwsEC2ResourceDetector(),
        KubernetesResourceDetector(),
        DockerResourceDetector(),
        OTELResourceDetector(),
    ])
    resource = {}
    spans : [Span] = []
    while True:
        with open(fifo_path, 'r') as fifo:
            for line in fifo:
                line = line.strip()
                if len(line) == 0:
                    continue
                tokens = line.split(' ', 1)
                tokens = [token for token in tokens if token]
                match tokens[0]:
                    case 'RESOURCE_ATTRIBUTE':
                        key = tokens[1].split('=', 1)[0]
                        value = tokens[1].split('=', 1)[1]
                        resource[key] = value
                    case 'INIT':
                        tracer_provider = TracerProvider(sampler=sampling.ALWAYS_ON, resource=Resource.create(resource))
                        tracer_provider.add_span_processor(processor)
                        opentelemetry.trace.set_tracer_provider(tracer_provider)
                    case 'SHUTDOWN':
                        processor.shutdown()
                        return
                    case 'SPAN_START':
                        tokens = tokens[1].split(' ', 3)
                        response_fifo = tokens[0]
                        trace_parent = tokens[1]
                        kind = tokens[2]
                        name = tokens[3]
                        span = opentelemetry.trace.get_tracer(scope, version).start_span(name, kind=SpanKind[kind.upper()], context=TraceContextTextMapPropagator().extract({'traceparent': trace_parent}))
                        spans.append(span)
                        carrier = {}
                        TraceContextTextMapPropagator().inject(carrier, opentelemetry.trace.set_span_in_context(span, None))
                        with open(response_fifo, 'w') as response:
                            response.write(carrier['traceparent'])
                    case 'SPAN_END':
                        span : Span = spans.pop()
                        if not span:
                            break
                        span.end()
                    case 'SPAN_ERROR':
                        span : Span = spans.pop()
                        if not span:
                            break
                        if len(tokens) > 1:
                            key = tokens[1].split('=', 1)[0]
                            value = tokens[1].split('=', 1)[1]
                            span.add_event("exception", { key: value })
                        span.set_status(StatusCode.ERROR)
                        spans.append(span)
                        pass
                    case 'SPAN_ATTRIBUTE':
                        span : Span = spans.pop()
                        if not span:
                            break
                        key = tokens[1].split('=', 1)[0]
                        value = tokens[1].split('=', 1)[1]
                        span.set_attribute(key, value)
                        spans.append(span)
                    case '_':
                        pass

if __name__ == "__main__":
    main()
