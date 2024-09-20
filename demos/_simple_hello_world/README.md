# Demo "Hello world"
This is a script as easy as it gets, i.e., a simple hello world. It shows some very simple span with the default attributes.
## Script
```sh
. otel.sh
echo hello world
```
## Trace Structure Overview
```
bash -e demo.sh
  echo hello world
```
## Full Trace
```
{
  "trace_id": "011d730d0839c58af003bdb687c4e1be",
  "span_id": "499ee58b91636536",
  "parent_span_id": "acf0c4879a37d4f2",
  "name": "echo hello world",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726814481407381500,
  "time_end": 1726814481422989600,
  "attributes": {
    "shell.command_line": "echo hello world",
    "shell.command": "echo",
    "shell.command.type": "builtin",
    "shell.command.name": "echo",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "011d730d0839c58af003bdb687c4e1be",
  "span_id": "acf0c4879a37d4f2",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726814481394718200,
  "time_end": 1726814481423125200,
  "attributes": {},
  "resource_attributes": {},
  "links": [],
  "events": []
}
```
