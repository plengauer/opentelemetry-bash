# Demo "Context Propagation with wget"
This script shows context propagation via HTTP from a client (wget) to a server (netcat).
## Script
```sh
. otel.sh
printf 'HTTP/1.1 418 I'\''m a teapot\r\ncontent-length: 0\r\n\r\n' | netcat -l 12345 &
sleep 5
wget http://127.0.0.1:12345
```
## Trace Structure Overview
```
```
## Full Trace
```
```