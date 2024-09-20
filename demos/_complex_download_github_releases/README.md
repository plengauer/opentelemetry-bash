# Demo "Download GitHub releases"
This script takes a github repository (hard-coded for demo purposes), and downloads the last 3 GitHub releases of version 1.x. It showcases context propgation (via netcat, curl, and wget) and auto-injection into inner commands (via xargs and parallel). Netcat is used for an initial head request to configure pagination, curl to make the inidivdual API requests, and wget for the actual downloads.
## Script
```sh
. otel.sh
repository=plengauer/opentelemetry-bash
per_page=100
host=api.github.com
path="/repos/$repository/releases?per_page=$per_page"
url=https://"$host""$path"
printf "HEAD $path HTTP/1.1\r\nConnection: close\r\nUser-Agent: ncat\r\nHost: $host\r\n\r\n" | ncat --ssl -i 3 --no-shutdown "$host" 443 | tr '[:upper:]' '[:lower:]' \
  | grep '^link: ' | cut -d ' '  -f 2- | tr -d ' <>' | tr ',' '\n' \
  | grep 'rel="last"' | cut -d ';' -f1 | cut -d '?' -f 2- | tr '&' '\n' \
  | grep '^page=' | cut -d = -f 2 \
  | xargs seq 1 | xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors "$url"\&page={} ::: \
  | jq '.[] | .assets[] | .browser_download_url' -r | grep '.deb$' | grep '_1.' | head --lines=3 \
  | xargs wget
```
## Trace Structure Overview
```
bash -e demo.sh
  printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\r\nConnection: close\r\nUser-Agent: ncat\r\nHost: api.github.com\r\n\r\n
  ncat --ssl -i 3 --no-shutdown api.github.com 443
    send/receive
      HEAD
  tr [:upper:] [:lower:]
  grep ^link:
  cut -d   -f 2-
  tr -d  <>
  tr , \n
  grep rel="last"
  cut -d ; -f1
  cut -d ? -f 2-
  tr & \n
  grep ^page=
  cut -d = -f 2
  xargs seq 1
    seq 1 3
  head --lines=3
  xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::
    /usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2
        GET
      curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1
        GET
  jq .[] | .assets[] | .browser_download_url -r
  grep .deb$
  grep _1.
  xargs wget
    wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb
      GET
      GET
      GET
      GET
```
## Full Trace
```
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "4b9459d50ceb3a6a",
  "parent_span_id": "0dd60b795d323f50",
  "name": "seq 1 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816785732156200,
  "time_end": 1726816785750922800,
  "attributes": {
    "shell.command_line": "seq 1 3",
    "shell.command": "seq",
    "shell.command.type": "file",
    "shell.command.name": "seq",
    "subprocess.executable.path": "/usr/bin/seq",
    "subprocess.executable.name": "seq",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "2b954962ffea15f0",
  "parent_span_id": "fb94a42989a20076",
  "name": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781240692700,
  "time_end": 1726816781345183000,
  "attributes": {
    "shell.command_line": "printf HEAD /repos/plengauer/opentelemetry-bash/releases?per_page=100 HTTP/1.1\\r\\nConnection: close\\r\\nUser-Agent: ncat\\r\\nHost: api.github.com\\r\\n\\r\\n",
    "shell.command": "printf",
    "shell.command.type": "builtin",
    "shell.command.name": "printf",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 7
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "10c89f6ca094a6b7",
  "parent_span_id": "31b5c5e7e5635584",
  "name": "HEAD",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816781655910400,
  "time_end": 1726816785106667800,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "network.protocol.name": "http",
    "network.protocol.version": "1.1",
    "url.full": "http://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100",
    "url.scheme": "http",
    "http.request.method": "HEAD",
    "http.request.body.size": 0,
    "user_agent.original": "netcat"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "31b5c5e7e5635584",
  "parent_span_id": "fdf724a8305410d6",
  "name": "send/receive",
  "kind": "PRODUCER",
  "status": "UNSET",
  "time_start": 1726816781372467200,
  "time_end": 1726816785107189200,
  "attributes": {
    "network.transport": "tcp",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "fdf724a8305410d6",
  "parent_span_id": "fb94a42989a20076",
  "name": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1726816781234431500,
  "time_end": 1726816785112261400,
  "attributes": {
    "shell.command_line": "ncat --ssl -i 3 --no-shutdown api.github.com 443",
    "shell.command": "ncat",
    "shell.command.type": "file",
    "shell.command.name": "ncat",
    "subprocess.executable.path": "/usr/bin/ncat",
    "subprocess.executable.name": "ncat",
    "shell.command.exit_code": 1,
    "code.filepath": "demo.sh",
    "code.lineno": 7
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "ee897c7dc612da13",
  "parent_span_id": "fb94a42989a20076",
  "name": "tr [:upper:] [:lower:]",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781240220700,
  "time_end": 1726816785114852000,
  "attributes": {
    "shell.command_line": "tr [:upper:] [:lower:]",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 7
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "97d1f1c2f089474d",
  "parent_span_id": "fb94a42989a20076",
  "name": "grep ^link:",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781241323000,
  "time_end": 1726816785117399800,
  "attributes": {
    "shell.command_line": "grep ^link:",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "ccdc23c304e39aa0",
  "parent_span_id": "fb94a42989a20076",
  "name": "cut -d   -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781229970000,
  "time_end": 1726816785119835000,
  "attributes": {
    "shell.command_line": "cut -d   -f 2-",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "d5cf53ab4de97c3b",
  "parent_span_id": "fb94a42989a20076",
  "name": "tr -d  <>",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781253527300,
  "time_end": 1726816785122221300,
  "attributes": {
    "shell.command_line": "tr -d  <>",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "fd03a142574366c0",
  "parent_span_id": "fb94a42989a20076",
  "name": "tr , \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781241747500,
  "time_end": 1726816785124602600,
  "attributes": {
    "shell.command_line": "tr , \\n",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 8
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "34fb94fe88c35282",
  "parent_span_id": "fb94a42989a20076",
  "name": "grep rel=\"last\"",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781245262600,
  "time_end": 1726816785127045600,
  "attributes": {
    "shell.command_line": "grep rel=\"last\"",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "89876c6782bc33ff",
  "parent_span_id": "fb94a42989a20076",
  "name": "cut -d ; -f1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781252966000,
  "time_end": 1726816785129523200,
  "attributes": {
    "shell.command_line": "cut -d ; -f1",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "4fb977f262506fd5",
  "parent_span_id": "fb94a42989a20076",
  "name": "cut -d ? -f 2-",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781241019400,
  "time_end": 1726816785131897600,
  "attributes": {
    "shell.command_line": "cut -d ? -f 2-",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "864c2b62f0964464",
  "parent_span_id": "fb94a42989a20076",
  "name": "tr & \\n",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781240471000,
  "time_end": 1726816785134380500,
  "attributes": {
    "shell.command_line": "tr & \\n",
    "shell.command": "tr",
    "shell.command.type": "file",
    "shell.command.name": "tr",
    "subprocess.executable.path": "/usr/bin/tr",
    "subprocess.executable.name": "tr",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 9
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "de057f335fdc1a08",
  "parent_span_id": "fb94a42989a20076",
  "name": "grep ^page=",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781253147100,
  "time_end": 1726816785136921900,
  "attributes": {
    "shell.command_line": "grep ^page=",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 10
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "1bac85745a11df30",
  "parent_span_id": "fb94a42989a20076",
  "name": "cut -d = -f 2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781241598700,
  "time_end": 1726816785139365600,
  "attributes": {
    "shell.command_line": "cut -d = -f 2",
    "shell.command": "cut",
    "shell.command.type": "file",
    "shell.command.name": "cut",
    "subprocess.executable.path": "/usr/bin/cut",
    "subprocess.executable.name": "cut",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 10
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "0dd60b795d323f50",
  "parent_span_id": "fb94a42989a20076",
  "name": "xargs seq 1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781247042800,
  "time_end": 1726816785789124400,
  "attributes": {
    "shell.command_line": "xargs seq 1",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 11
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "74cc2f913b03b453",
  "parent_span_id": "984ae6d35604931d",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816787814432300,
  "time_end": 1726816789486012400,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.116.5",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "url.full": "https://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100&page=3",
    "url.scheme": "https",
    "http.request.method": "GET"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "984ae6d35604931d",
  "parent_span_id": "7ce27d1b5cbdd99c",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816787683352300,
  "time_end": 1726816789490714000,
  "attributes": {
    "shell.command_line": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=3",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "2b1aabdf4b7d5404",
  "parent_span_id": "9a32ac8a85d76d09",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816787913147600,
  "time_end": 1726816792122419500,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.116.5",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "url.full": "https://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100&page=2",
    "url.scheme": "https",
    "http.request.method": "GET"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "9a32ac8a85d76d09",
  "parent_span_id": "7ce27d1b5cbdd99c",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816787781356500,
  "time_end": 1726816792126632700,
  "attributes": {
    "shell.command_line": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=2",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "041e0da0cad53f94",
  "parent_span_id": "49cdcd7c4825127a",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816787899976000,
  "time_end": 1726816792175859000,
  "attributes": {
    "network.transport": "tcp",
    "network.protocol.name": "https",
    "network.protocol.version": "2",
    "network.peer.address": "140.82.116.5",
    "network.peer.port": 443,
    "server.address": "api.github.com",
    "server.port": 443,
    "url.full": "https://api.github.com:443/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
    "url.path": "/repos/plengauer/opentelemetry-bash/releases",
    "url.query": "per_page=100&page=1",
    "url.scheme": "https",
    "http.request.method": "GET"
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "49cdcd7c4825127a",
  "parent_span_id": "7ce27d1b5cbdd99c",
  "name": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816787766905900,
  "time_end": 1726816792179678500,
  "attributes": {
    "shell.command_line": "curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page=1",
    "shell.command": "curl",
    "shell.command.type": "file",
    "shell.command.name": "curl",
    "subprocess.executable.path": "/usr/bin/curl",
    "subprocess.executable.name": "curl",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "7ce27d1b5cbdd99c",
  "parent_span_id": "f656153fa5574f38",
  "name": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816786429241900,
  "time_end": 1726816792194816300,
  "attributes": {
    "shell.command_line": "/usr/bin/perl /usr/bin/parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} ::: 1 2 3",
    "shell.command": "/usr/bin/perl",
    "shell.command.type": "file",
    "shell.command.name": "perl",
    "subprocess.executable.path": "/usr/bin/perl",
    "subprocess.executable.name": "perl",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "18cfdfabce910874",
  "parent_span_id": "95aa8da826df8b43",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816792890684400,
  "time_end": 1726816793078658600,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "140.82.116.4",
    "network.peer.port": 443,
    "server.address": "github.com",
    "server.port": 443,
    "url.full": "https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb",
    "url.path": "/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 302
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "096591b10739ae4a",
  "parent_span_id": "95aa8da826df8b43",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816793065537300,
  "time_end": 1726816793390356000,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.111.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/5544a935-3cf9-4f9b-b6ed-d668fd012e99?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240920%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240920T071953Z&X-Amz-Expires=300&X-Amz-Signature=9a6d27d295e7ccffa14db3379e9b9fb5013e739a6b8f78040567975020bfb408&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.13.7.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/5544a935-3cf9-4f9b-b6ed-d668fd012e99",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240920%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240920T071953Z&X-Amz-Expires=300&X-Amz-Signature=9a6d27d295e7ccffa14db3379e9b9fb5013e739a6b8f78040567975020bfb408&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.13.7.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "f6d43b08982ff158",
  "parent_span_id": "95aa8da826df8b43",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816793563432000,
  "time_end": 1726816793939435500,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.111.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/e8091cbc-915a-4ba7-bca7-308817fe26c4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240920%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240920T071953Z&X-Amz-Expires=300&X-Amz-Signature=c453ef32e5654826eb12d1e36311806d7bce9f257ce46af7669682fe02f58b4f&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.13.6.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/e8091cbc-915a-4ba7-bca7-308817fe26c4",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240920%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240920T071953Z&X-Amz-Expires=300&X-Amz-Signature=c453ef32e5654826eb12d1e36311806d7bce9f257ce46af7669682fe02f58b4f&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.13.6.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "bf51f37b16937091",
  "parent_span_id": "95aa8da826df8b43",
  "name": "GET",
  "kind": "CLIENT",
  "status": "UNSET",
  "time_start": 1726816794094488600,
  "time_end": 1726816794484322800,
  "attributes": {
    "network.protocol.name": "https",
    "network.transport": "tcp",
    "network.peer.address": "185.199.111.133",
    "network.peer.port": 443,
    "server.address": "objects.githubusercontent.com",
    "server.port": 443,
    "url.full": "https://objects.githubusercontent.com/github-production-release-asset-2e65be/692042935/25d95ab9-56aa-4a77-8e84-d4947ecef0fc?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240920%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240920T071954Z&X-Amz-Expires=300&X-Amz-Signature=18442d8033afdd745d9add5efc0f7270f061b3c868a82c3f84b712cac21ece0c&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.13.5.deb&response-content-type=application%2Foctet-stream",
    "url.path": "/github-production-release-asset-2e65be/692042935/25d95ab9-56aa-4a77-8e84-d4947ecef0fc",
    "url.query": "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20240920%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240920T071954Z&X-Amz-Expires=300&X-Amz-Signature=18442d8033afdd745d9add5efc0f7270f061b3c868a82c3f84b712cac21ece0c&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dopentelemetry-shell_1.13.5.deb&response-content-type=application%2Foctet-stream",
    "url.scheme": "https",
    "user_agent.original": "wget",
    "http.request.method": "GET",
    "http.response.status_code": 200
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "95aa8da826df8b43",
  "parent_span_id": "d6e1b60f3b613012",
  "name": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816792821097000,
  "time_end": 1726816794489610500,
  "attributes": {
    "shell.command_line": "wget https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.7/opentelemetry-shell_1.13.7.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.6/opentelemetry-shell_1.13.6.deb https://github.com/plengauer/opentelemetry-bash/releases/download/v1.13.5/opentelemetry-shell_1.13.5.deb",
    "shell.command": "wget",
    "shell.command.type": "file",
    "shell.command.name": "wget",
    "subprocess.executable.path": "/usr/bin/wget",
    "subprocess.executable.name": "wget",
    "shell.command.exit_code": 0,
    "code.lineno": 2
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "59d350f52138eb07",
  "parent_span_id": "fb94a42989a20076",
  "name": "head --lines=3",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781259246000,
  "time_end": 1726816792192874800,
  "attributes": {
    "shell.command_line": "head --lines=3",
    "shell.command": "head",
    "shell.command.type": "file",
    "shell.command.name": "head",
    "subprocess.executable.path": "/usr/bin/head",
    "subprocess.executable.name": "head",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "f656153fa5574f38",
  "parent_span_id": "fb94a42989a20076",
  "name": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781241171000,
  "time_end": 1726816792246356200,
  "attributes": {
    "shell.command_line": "xargs parallel -q curl --no-progress-meter --fail --retry 16 --retry-all-errors https://api.github.com/repos/plengauer/opentelemetry-bash/releases?per_page=100&page={} :::",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 11
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "5266444f87cb0c11",
  "parent_span_id": "fb94a42989a20076",
  "name": "jq .[] | .assets[] | .browser_download_url -r",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781268327200,
  "time_end": 1726816792249326300,
  "attributes": {
    "shell.command_line": "jq .[] | .assets[] | .browser_download_url -r",
    "shell.command": "jq",
    "shell.command.type": "file",
    "shell.command.name": "jq",
    "subprocess.executable.path": "/usr/bin/jq",
    "subprocess.executable.name": "jq",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "aeb6daac75841ae3",
  "parent_span_id": "fb94a42989a20076",
  "name": "grep .deb$",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781253711600,
  "time_end": 1726816792252360000,
  "attributes": {
    "shell.command_line": "grep .deb$",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 12
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "da40967d40e301ee",
  "parent_span_id": "fb94a42989a20076",
  "name": "grep _1.",
  "kind": "INTERNAL",
  "status": "ERROR",
  "time_start": 1726816781241460000,
  "time_end": 1726816792256804600,
  "attributes": {
    "shell.command_line": "grep _1.",
    "shell.command": "grep",
    "shell.command.type": "file",
    "shell.command.name": "grep",
    "subprocess.executable.path": "/usr/bin/grep",
    "subprocess.executable.name": "grep",
    "shell.command.exit_code": 2,
    "code.filepath": "demo.sh",
    "code.lineno": 12
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "d6e1b60f3b613012",
  "parent_span_id": "fb94a42989a20076",
  "name": "xargs wget",
  "kind": "INTERNAL",
  "status": "UNSET",
  "time_start": 1726816781253349000,
  "time_end": 1726816794526771500,
  "attributes": {
    "shell.command_line": "xargs wget",
    "shell.command": "xargs",
    "shell.command.type": "file",
    "shell.command.name": "xargs",
    "subprocess.executable.path": "/usr/bin/xargs",
    "subprocess.executable.name": "xargs",
    "shell.command.exit_code": 0,
    "code.filepath": "demo.sh",
    "code.lineno": 13
  },
  "resource_attributes": {},
  "links": [],
  "events": []
}
{
  "trace_id": "9abbefce24cb0af265f3faaf4dc9134e",
  "span_id": "fb94a42989a20076",
  "parent_span_id": "",
  "name": "bash -e demo.sh",
  "kind": "SERVER",
  "status": "UNSET",
  "time_start": 1726816781199825400,
  "time_end": 1726816794527413800,
  "attributes": {},
  "resource_attributes": {},
  "links": [],
  "events": []
}
```
