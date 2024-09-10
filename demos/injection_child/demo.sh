. otel.sh
sh ./child.sh hello world from child
printf 'echo hello world from stdin' | sh
sh -c 'echo "$@"' sh hello world from -c
