#!/bin/bash

assert_equals() {
  if [ "$1" != "$2" ]; then
    \echo "$1 != $2"
    exit 1
  fi
}

assert_not_equals() {
  if [ "$1" = "$2" ]; then
    \echo "$1 == $2"
    exit 1
  fi
}

resolve_span() {
  local selector="$1"
  if [ -n "$selector" ]; then
    local selector=' | select('"$selector"')'
  fi
  \sleep 5
  \cat $OTEL_TRACES_LOCATION | jq ".$selector"
}
