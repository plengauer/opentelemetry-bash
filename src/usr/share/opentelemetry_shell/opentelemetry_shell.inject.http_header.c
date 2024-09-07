#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>

int inject(char *buffer, size_t length) {
  char* line_end = strchr(buffer, '\n');
  if (!line_end) {
    return 1;
  }
  *line_end = '\0';
  if (!strstr(buffer, " HTTP/")) {
    *line_end = '\n';
    return 2;
  }
  *line_end = '\n';

  buffer = line_end + 1;
  line_end = strchr(buffer, '\n');
  while (!!line_end && line_end - buffer > 1) {
    *line_end = '\0';
    if (strstr(buffer, "traceparent: ") == buffer) {
      // open pipe and
      // start span CLIENT HTTP
      // store the span handle in a predefined spot
      // get the trace parent header
      // replace the traceparent
      fprintf(stderr, "%s %s\n", "DEBUG inject into", buffer);
      *line_end = '\n';
      return 0;
    }
    *line_end = '\n';
    buffer = line_end + 1;
    line_end = strchr(buffer, '\n');
  }
  return 3;
}


ssize_t (*original_send)(int sockfd, const void *buf, size_t len, int flags);
ssize_t send(int sockfd, const void *buf, size_t len, int flags) {
    int result = inject((char *) buf, len);
    fprintf(stderr, "DEBUG %d\n", result);
    return original_send(sockfd, buf, len, flags);
}

int (*original_SSL_write)(void *ssl, const void *buf, int num);
int SSL_write(void *ssl, const void *buf, int num) {
    int result = inject((char *) buf, (size_t) num);
    fprintf(stderr, "DEBUG %d\n", result);
    return original_SSL_write(ssl, buf, num);
}

__attribute__ ((constructor))
void init() {
    original_send = dlsym(RTLD_NEXT, "send");
    original_SSL_write = dlsym(RTLD_NEXT, "SSL_write");
}
