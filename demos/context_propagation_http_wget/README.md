# Demo "Context Propagation with wget"
This script shows context propagation via HTTP from a client (wget) to a server (ncat).
## Script
```sh
otel4netcat_http ncat -l -c 'printf "HTTP/1.1 418 I'\''m a teapot\r\n\r\n"' 12345 & # fake http server
sleep 5
. otel.sh
wget http://127.0.0.1:12345
```
## Trace Structure Overview
```
bash -e demo.sh
  wget http://127.0.0.1:12345
    GET
      GET
        printf HTTP/1.1 418 I'm a teapot
send/receive
```
## Full Trace
```
```
