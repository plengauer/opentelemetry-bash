#!/bin/false

# curl -v https://www.google.at => curl -v https://www.google.at -H 'traceparent: 00-XXXXXX-01'

_otel_propagate_curl() {
  local url=$(_otel_dollar_star "$@" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local span_id="$(otel_span_current)"
  otel_span_attribute "$span_id" "http.url=$url"
  otel_span_attribute "$span_id" "http.scheme=http" # TODO
  otel_span_attribute "$span_id" "http.host=$(\printf '%s' "$url" | \cut -d / -f 3)"
  otel_span_attribute "$span_id" "http.target=/${url#*//*/}"
  local method="$(\printf '%s' "$command" | \awk '{for(i=1;i<=NF;i++) if ($i == "-X") print $(i+1)}')" # TODO could also be a -d to imply post, or --head"
  otel_span_attribute "$span_id" "http.method=${method:-GET}"
  # TODO lets check if we can read the output and parse something
  _otel_call "$@" -H "traceparent: $OTEL_TRACEPARENT"
}

_otel_alias_prepend curl 'OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT _otel_propagate_curl'
