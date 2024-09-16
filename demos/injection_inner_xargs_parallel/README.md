# Demo "Injection into inner commands of xargs and parallel"
This script shows injection into inner commands with xargs and parallel to continue tracing.
## Script
```sh
. otel.sh
echo foo bar baz | xargs parallel echo :::
```
## Trace Structure Overview
```
```
## Full Trace
```
```
