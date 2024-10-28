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
bash -e demo.sh
  sh ./child.sh hello world from child
    echo hello world from child
  sh
    echo hello world from stdin
  printf echo hello world from stdin
  sh -c echo "$@" sh hello world from -c
    echo hello world from -c
```
## Full Trace
```
```
