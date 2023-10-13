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

assert_ends_with() {
  reverse_string=$(\echo "$2" | \rev)
  reverse_suffix=$(\echo "$1" | \rev)
  if [ "${reverse_string#"$reverse_suffix"}" == "$reverse_string" ] ; then
    \echo "$1 !~= $2"
    exit 1
  fi
}

resolve_span() {
  local selector="$1"
  if [ -n "$selector" ]; then
    local selector=' | select('"$selector"')'
  fi
  for i in 1 2 4 8 16 32; do
    local span="$(\cat $OTEL_TRACES_LOCATION | \jq ". | select(.name != null)$selector")"
    if [ -n "$span" ]; then
      \echo "$span"
      return 0
    fi
    \sleep $i
  done
  \echo "could not resolve span!" 1>&2
  exit 1
}
