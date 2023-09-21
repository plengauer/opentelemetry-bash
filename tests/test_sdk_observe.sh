#!/bin/bash
. ./assert.sh
. /usr/bin/opentelemetry_bash_sdk.sh

otel_init
otel_observe echo "hello world"
otel_shutdown
