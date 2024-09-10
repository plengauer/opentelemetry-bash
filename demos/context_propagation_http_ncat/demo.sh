. otel.sh
ncat -l -c 'printf "HTTP/1.1 418 I'\''m a teapot\r\n\r\n"' 12345 &
sleep 5
printf 'GET / HTTP/1.1\r\n\r\n' | ncat 127.0.0.1 12345
