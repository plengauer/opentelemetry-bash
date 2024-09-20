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
  printf echo hello world from stdin
  sh
  sh -c echo "$@" sh hello world from -c
    echo hello world from -c
```
## Full Trace
```
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "7bb9b2dca8f980fd",
  "parent_span_id": "1763892706ad0ea9",
  "name": "echo hello world from child",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726825682208193500,
  "time_end": 1726825682222899000,
  "attributes": {
    "shell.command_line": "echo hello world from child",
    "shell.command": "echo",
    "shell.command.type": "builtin",
    "shell.command.name": "echo",
    "shell.command.exit_code": 0,
    "code.filepath": "./child.sh"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "9aa3679a54ec1746",
  "parent_span_id": "8b134242f227562b",
  "name": "echo hello world from -c",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726825683161693700,
  "time_end": 1726825683176462300,
  "attributes": {
    "shell.command_line": "echo hello world from -c",
    "shell.command": "echo",
    "shell.command.type": "builtin",
    "shell.command.name": "echo",
    "shell.command.exit_code": 0,
    "code.filepath": "sh"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "1763892706ad0ea9",
  "parent_span_id": "be12a735471eeca6",
  "name": "sh ./child.sh hello world from child",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726825681658139600,
  "time_end": 1726825682252055000,
  "attributes": {
    "shell.command_line": "sh ./child.sh hello world from child",
    "shell.command": "sh",
    "shell.command.type": "file",
    "shell.command.name": "sh",
    "subprocess.executable.path": "/usr/bin/sh",
    "subprocess.executable.name": "sh",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "568b530ef6f4515c",
  "parent_span_id": "be12a735471eeca6",
  "name": "printf echo hello world from stdin",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726825682257122300,
  "time_end": 1726825682272904400,
  "attributes": {
    "shell.command_line": "printf echo hello world from stdin",
    "shell.command": "printf",
    "shell.command.type": "builtin",
    "shell.command.name": "printf",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "028828b86c5fe17c",
  "parent_span_id": "be12a735471eeca6",
  "name": "sh",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726825682258073000,
  "time_end": 1726825682805944000,
  "attributes": {
    "shell.command_line": "sh",
    "shell.command": "sh",
    "shell.command.type": "file",
    "shell.command.name": "sh",
    "subprocess.executable.path": "/usr/bin/sh",
    "subprocess.executable.name": "sh",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "8b134242f227562b",
  "parent_span_id": "be12a735471eeca6",
  "name": "sh -c echo \"$@\" sh hello world from -c",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726825682810841900,
  "time_end": 1726825683205388500,
  "attributes": {
    "shell.command_line": "sh -c echo \"$@\" sh hello world from -c",
    "shell.command": "sh",
    "shell.command.type": "file",
    "shell.command.name": "sh",
    "subprocess.executable.path": "/usr/bin/sh",
    "subprocess.executable.name": "sh",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 4
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "1a01d80919bd1f7cb6934d40447b4076",
  "span_id": "be12a735471eeca6",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726825681645769500,
  "time_end": 1726825683205577700,
  "attributes": {},
  "resource_attributes": {},
  "links": [],
  "events": []
}
```
