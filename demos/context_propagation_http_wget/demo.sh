. otel.sh
printf 'HTTP/1.1 418 I'\''m a teapot\r\n\r\n' | netcat -l 12345 &
sleep 5
wget http://127.0.0.1:12345
