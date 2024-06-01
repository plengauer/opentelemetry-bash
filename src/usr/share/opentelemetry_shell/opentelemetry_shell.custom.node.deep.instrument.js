const opentelemetry_api = require('@opentelemetry/api');
const opentelemetry_sdk = require('@opentelemetry/sdk-node');
const opentelemetry_metrics = require('@opentelemetry/sdk-metrics');
const opentelemetry_tracing = require('@opentelemetry/sdk-trace-base');
const opentelemetry_semantic_conventions = require('@opentelemetry/semantic-conventions');
const opentelemetry_metrics_otlp = require('@opentelemetry/exporter-metrics-otlp-proto');
const opentelemetry_traces_otlp = require('@opentelemetry/exporter-trace-otlp-proto');
const opentelemetry_auto_instrumentations = require('@opentelemetry/auto-instrumentations-node');
const opentelemetry_resources_git = require('opentelemetry-resource-detector-git');
const opentelemetry_resources_github = require('@opentelemetry/resource-detector-github');
const opentelemetry_resources_container = require('@opentelemetry/resource-detector-container');
const opentelemetry_resources_aws = require('@opentelemetry/resource-detector-aws');
const opentelemetry_resources_gcp = require('@opentelemetry/resource-detector-gcp');
const opentelemetry_resources_alibaba_cloud = require('@opentelemetry/resource-detector-alibaba-cloud');

if (!process.env.OTEL_TRACES_EXPORTER) process.env.OTEL_TRACES_EXPORTER = 'otlp';

let exporter = null;
switch (process.env.OTEL_TRACES_EXPORTER) {
  case 'otlp': exporter = opentelemetry_traces_otlp.OTLPTraceExporter(); break;
  case 'console': exporter = opentelemetry_tracing.ConsoleSpanExporter(); break;
  default: return;
}
let sdk = new opentelemetry_sdk.NodeSDK({
  spanProcessor: new opentelemetry_tracing.BatchSpanProcessor(exporter),
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
process.on('exit', () => sdk.shutdown());
process.on('SIGINT', () => sdk.shutdown());
process.on('SIGQUIT', () => sdk.shutdown());
sdk.start();
