#!/bin/bash

function assert_equals {
  if [ "$1" != "$2" ]; then
    \echo "$1 != $2"
    exit 1
  fi
}

function assert_not_equals {
  if [ "$1" == "$2" ]; then
    \echo "$1 == $2"
    exit 1
  fi
}
