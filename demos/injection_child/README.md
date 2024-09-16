# Demo "Injection into shild scripts"
This script shows automatic injection into child scripts to continue tracing effortlessly.
## Script
```sh
. otel.sh
sh ./child.sh hello world from child
printf 'echo hello world from stdin' | sh
sh -c 'echo "$@"' sh hello world from -c
```
## Trace Structure Overview
```
```
## Full Trace
```
```
