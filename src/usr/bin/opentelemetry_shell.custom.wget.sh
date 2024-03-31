#!/bin/false

# wget -O - https://www.google.at => wget -O - https://www.google.at '--header=traceparent: 00-XXXXXX-01'

_otel_propagate_wget() {
  # TODO drop all the overrides, set attributes directly (span should be already active), set kind directly, and modify commandline directly (do the same in wget, and similar things in all others in terms of override)
  local url=$(_otel_dollar_star "$@" | \awk '{for(i=1;i<=NF;i++) if ($i ~ /^http/) print $i}')
  local span_id="$(otel_span_current)"
  otel_span_attribute "$span_id" "http.url=$url"
  otel_span_attribute "$span_id" "http.scheme=http" # TODO
  otel_span_attribute "$span_id" "http.host=$(\printf '%s' "$url" | \cut -d / -f 3)"
  otel_span_attribute "$span_id" "http.target=/${url#*//*/}"
  otel_span_attribute "$span_id" "http.method=GET" # TODO
  # TODO response because we can read whats written to stderr
  # pseudo code from here on
  _otel_call "$@" --header="traceparent: $OTEL_TRACEPARENT"
}

_otel_alias_prepend wget 'OTEL_SHELL_SPAN_KIND_OVERRIDE=CLIENT _otel_propagate_wget'
