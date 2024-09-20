# Demo "Context Propagation with curl"
This script shows context propagation via HTTP from a client (curl) to a server (ncat).
## Script
```sh
. otel.sh
\otel4netcat_http ncat -l -c 'printf "HTTP/1.1 418 I'\''m a teapot\r\n\r\n"' 12345 & # fake http server
sleep 5
curl http://127.0.0.1:12345
```
## Trace Structure Overview
```
bash -e demo.sh
  send/receive
  sleep 5
  curl http://127.0.0.1:12345
    GET
      GET
```
## Full Trace
```
{
  "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
  "span_id": "7a71974552f63a02",
  "parent_span_id": "795083d5e0b9a96c",
  "name": "GET",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726821242781309700,
  "time_end": 1726821242864268800,
  "attributes": {
    "network.transport": "TCP",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 56218,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "client.address": "127.0.0.1",
    "client.port": 56218,
    "network.protocol.name": "http",
    "network.protocol.version": "1.1",
    "url.full": "http://:12345/",
    "url.path": "/",
    "url.scheme": "http",
    "http.request.method": "GET",
    "http.request.body.size": 0,
    "http.response.status_code": 418,
    "http.response.body.size": 0
  },
  "resource_attributes": {},
  "links": [
    {
      "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
      "span_id": "bc140803cbc9994f",
      "attributes": {}
    }
  ],
  "events": []
}
{
  "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
  "span_id": "bc140803cbc9994f",
  "parent_span_id": "fa615c82c0fd9603",
  "name": "send/receive",
  "kind": "CONSUMER",
  "status": "UNSET",
  "time_start": 1726821242676522500,
  "time_end": 1726821242866504700,
  "attributes": {
    "network.transport": "TCP",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 56218,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "client.address": "127.0.0.1",
    "client.port": 56218
  },
  "resource_attributes": {},
  "links": [
    {
      "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
      "span_id": "7a71974552f63a02",
      "attributes": {}
    }
  ],
  "events": []
}
{
  "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
  "span_id": "c6525744a2b2c44c",
  "parent_span_id": "fa615c82c0fd9603",
  "name": "sleep 5",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726821237166593300,
  "time_end": 1726821242187541500,
  "attributes": {
    "shell.command_line": "sleep 5",
    "shell.command": "sleep",
    "shell.command.type": "file",
    "shell.command.name": "sleep",
    "subprocess.executable.path": "/usr/bin/sleep",
    "subprocess.executable.name": "sleep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 3
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
  "span_id": "795083d5e0b9a96c",
  "parent_span_id": "f996ce7c7bc98577",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1726821242225785900,
  "time_end": 1726821242907443500,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "http",
    "network.protocol.version": "1.1",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 12345,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "url.full": "http://127.0.0.1:12345/",
    "url.path": "/",
    "url.scheme": "http",
    "http.request.method": "GET"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
  "span_id": "f996ce7c7bc98577",
  "parent_span_id": "fa615c82c0fd9603",
  "name": "curl http://127.0.0.1:12345",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726821242192103000,
  "time_end": 1726821242910885600,
  "attributes": {
    "shell.command_line": "curl http://127.0.0.1:12345",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 4
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "b7145da0e7a18e63e7a210fa4bb934df",
  "span_id": "fa615c82c0fd9603",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726821237153157000,
  "time_end": 1726821242911037400,
  "attributes": {},
  "resource_attributes": {},
  "links": [],
  "events": []
}
```
