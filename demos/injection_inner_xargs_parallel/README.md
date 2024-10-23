# Demo "Injection into inner commands of xargs and parallel"
This script shows injection into inner commands with xargs and parallel to continue tracing.
## Script
```sh
. otel.sh
echo foo bar baz | xargs parallel echo :::
```
## Trace Structure Overview
```
bash -e demo.sh
  echo foo bar baz
  xargs parallel echo :::
    /usr/bin/perl /usr/bin/parallel echo ::: foo bar baz
      echo bar
      echo baz
      echo foo
```
## Full Trace
```
```
