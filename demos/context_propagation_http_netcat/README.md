# Demo "Context Propagation with netcat"
This script shows context propagation via HTTP from a client (netcat) to a server (ncat).
## Script
```sh
otel4netcat_http ncat -l -c 'printf "HTTP/1.1 418 I'\''m a teapot\r\n\r\n"' 12345 & # inject with special command
sleep 5
. otel.sh
printf 'GET / HTTP/1.1\r\n\r\n' | ncat --no-shutdown 127.0.0.1 12345
```
## Trace Structure Overview
```
bash -e demo.sh
  printf GET / HTTP/1.1\r\n\r\n
  ncat --no-shutdown 127.0.0.1 12345
    send/receive
      GET
        GET
          printf HTTP/1.1 418 I'm a teapot
send/receive
```
## Full Trace
```
```
