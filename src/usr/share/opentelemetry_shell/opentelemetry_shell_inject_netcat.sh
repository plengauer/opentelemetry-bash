#!/bin/sh -e
export OTEL_SHELL_AUTO_INJECTED=TRUE
. otel.sh
\unalias -a
_otel_inject_netcat "$@"
