# Demo "Context Propagation with netcat"
This script shows context propagation via HTTP from a client (netcat) to a server (ncat).
## Script
```sh
. otel.sh
\otel4netcat_http ncat -l -c 'printf "HTTP/1.1 418 I'\''m a teapot\r\n\r\n"' 12345 & # inject with special command
sleep 5
printf 'GET / HTTP/1.1\r\n\r\n' | ncat --no-shutdown 127.0.0.1 12345
```
## Trace Structure Overview
```
bash -e demo.sh
  send/receive
  sleep 5
  printf GET / HTTP/1.1\r\n\r\n
  ncat --no-shutdown 127.0.0.1 12345
    send/receive
      GET
        GET
```
## Full Trace
```
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "f7dc7eda3e2b13ef",
  "parent_span_id": "de8269e0fe5529c2",
  "name": "GET",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726822885337205500,
  "time_end": 1726822885422060300,
  "attributes": {
    "network.transport": "TCP",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 37310,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "client.address": "127.0.0.1",
    "client.port": 37310,
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
      "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
      "span_id": "e858d57775227907",
      "attributes": {}
    }
  ],
  "events": []
}
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "e858d57775227907",
  "parent_span_id": "68626c994579f413",
  "name": "send/receive",
  "kind": "CONSUMER",
  "status": "UNSET",
  "time_start": 1726822885262603500,
  "time_end": 1726822885424417800,
  "attributes": {
    "network.transport": "TCP",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 37310,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "client.address": "127.0.0.1",
    "client.port": 37310
  },
  "resource_attributes": {},
  "links": [
    {
      "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
      "span_id": "f7dc7eda3e2b13ef",
      "attributes": {}
    }
  ],
  "events": []
}
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "3023d02c6d05e069",
  "parent_span_id": "68626c994579f413",
  "name": "sleep 5",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726822879705810400,
  "time_end": 1726822884727191000,
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
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "e4b60634e93dba27",
  "parent_span_id": "68626c994579f413",
  "name": "printf GET / HTTP/1.1\\r\\n\\r\\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726822884732540400,
  "time_end": 1726822884748291600,
  "attributes": {
    "shell.command_line": "printf GET / HTTP/1.1\\r\\n\\r\\n",
    "shell.command": "printf",
    "shell.command.type": "builtin",
    "shell.command.name": "printf",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 4
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "de8269e0fe5529c2",
  "parent_span_id": "8df92d87429d9a98",
  "name": "GET",
  "kind": "CLIENT",
  "status": "ERROR",
  "time_start": 1726822884891526000,
  "time_end": 1726822885517188900,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 12345,
    "server.address": "127.0.0.1",
    "server.port": 12345,
    "network.protocol.name": "http",
    "network.protocol.version": "1.1",
    "url.full": "http://127.0.0.1:12345/",
    "url.path": "/",
    "url.scheme": "http",
    "http.request.method": "GET",
    "http.request.body.size": 0,
    "user_agent.original": "netcat",
    "http.response.status_code": 418,
    "http.response.body.size": 0
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "8df92d87429d9a98",
  "parent_span_id": "e246c7212d2b70af",
  "name": "send/receive",
  "kind": "PRODUCER",
  "status": "UNSET",
  "time_start": 1726822884757133800,
  "time_end": 1726822885517649200,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.address": "127.0.0.1",
    "network.peer.port": 12345,
    "server.address": "127.0.0.1",
    "server.port": 12345
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "e246c7212d2b70af",
  "parent_span_id": "68626c994579f413",
  "name": "ncat --no-shutdown 127.0.0.1 12345",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726822884733620200,
  "time_end": 1726822885522293800,
  "attributes": {
    "shell.command_line": "ncat --no-shutdown 127.0.0.1 12345",
    "shell.command": "ncat",
    "shell.command.type": "file",
    "shell.command.name": "ncat",
    "subprocess.executable.path": "/usr/bin/ncat",
    "subprocess.executable.name": "ncat",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 4
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "c0321e7cd238b99213eb3001a8b0a295",
  "span_id": "68626c994579f413",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726822879691997400,
  "time_end": 1726822885522895400,
  "attributes": {},
  "resource_attributes": {},
  "links": [],
  "events": []
}
```
