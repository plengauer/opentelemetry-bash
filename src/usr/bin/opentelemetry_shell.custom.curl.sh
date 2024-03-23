#!/bin/false

# curl -v https://www.google.at => curl -v https://www.google.at -H 'traceparent: 00-XXXXXX-01'

_otel_propagate_curl() {
  local command="$(_otel_dollar_star "$@" | \sed 's/^_otel_observe //')"
  local url=$(\printf '%s' "$command" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local scheme=http # TODO
  local target=$(\printf '%s' /${url#*//*/})
  local host=$(\printf '%s' ${url} | \awk -F/ '{print $3}')
  local method=$(\printf '%s' "$command" | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')
  if \[ -z "$method" ]; then
    local method=GET
  fi
  OTEL_SHELL_SPAN_NAME_OVERRIDE="$command" OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT OTEL_SHELL_COMMANDLINE_OVERRIDE="$command" \
    OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE="http.url=$url,http.scheme=$scheme,http.host=$host,http.target=$target,http.method=$method,$OTEL_SHELL_SPAN_ATTRIBUTES_OVERRIDE" \
    OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_0='-H' OTEL_SHELL_ADDITIONAL_ARGUMENTS_POST_1='traceparent: $OTEL_TRACEPARENT' \
    "$@"
}

_otel_alias_prepend curl _otel_propagate_curl
