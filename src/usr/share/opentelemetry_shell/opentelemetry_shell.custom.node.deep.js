import opentelemetry_api from '@opentelemetry/api';
import opentelemetry_sdk from '@opentelemetry/sdk-node';
import opentelemetry_metrics from '@opentelemetry/sdk-metrics';
import opentelemetry_tracing from '@opentelemetry/sdk-trace-base';
import opentelemetry_semantic_conventions from '@opentelemetry/semantic-conventions';
import opentelemetry_metrics_otlp from '@opentelemetry/exporter-metrics-otlp-proto';
import opentelemetry_traces_otlp from '@opentelemetry/exporter-trace-otlp-proto';
import opentelemetry_auto_instrumentations from "@opentelemetry/auto-instrumentations-node";
import opentelemetry_resources_git from 'opentelemetry-resource-detector-git';
import opentelemetry_resources_github from '@opentelemetry/resource-detector-github';
import opentelemetry_resources_container from '@opentelemetry/resource-detector-container';
import opentelemetry_resources_aws from '@opentelemetry/resource-detector-aws';
import opentelemetry_resources_gcp from '@opentelemetry/resource-detector-gcp';
import opentelemetry_resources_alibaba_cloud from '@opentelemetry/resource-detector-alibaba-cloud';

async function init() {
  let sdk = create();
  process.on('exit', () => sdk.shutdown());
  process.on('SIGINT', () => sdk.shutdown());
  process.on('SIGQUIT', () => sdk.shutdown());
  await sdk.start();
}

function create() {
  // TODO select right exporter depending on OTEL_TRACES_EXPORTER
  return new opentelemetry_sdk.NodeSDK({
    spanProcessor: new opentelemetry_tracing.BatchSpanProcessor(new opentelemetry_traces_otlp.OTLPTraceExporter()),
    instrumentations: [ opentelemetry_auto_instrumentations.getNodeAutoInstrumentations() ],
    resourceDetectors: [
      opentelemetry_resources_alibaba_cloud.alibabaCloudEcsDetector,
      // opentelemetry_resources_gcp.gcpDetector, // TODO makes noisy spans!
      opentelemetry_resources_aws.awsBeanstalkDetector,
      opentelemetry_resources_aws.awsEc2Detector,
      opentelemetry_resources_aws.awsEcsDetector,
      opentelemetry_resources_aws.awsEksDetector,
      // TODO k8s detector
      opentelemetry_resources_container.containerDetector,
      opentelemetry_resources_git.gitSyncDetector,
      opentelemetry_resources_github.gitHubDetector,
      opentelemetry_resources.processDetector,
      opentelemetry_resources.envDetector
    ],
  });
}

await init();

let span_context = opentelemetry_api.propagation.extract(opentelemetry_api.trace.ROOT_CONTEXT, { traceparent: process.env.OTEL_TRACEPARENT });
let context = opentelemetry_api.trace.setSpan(opentelemetry_api.trace.ROOT_CONTEXT, opentelemetry_api.trace.wrapSpanContext(span_context.span));
opentelemetry_api.trace.context.setGlobalContextManager({
  active() {
    return context;
  },
});
