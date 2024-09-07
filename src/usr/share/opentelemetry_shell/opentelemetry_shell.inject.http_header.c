#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dlfcn.h>
#include <sys/types.h> // TODO do we need this?
#include <sys/stat.h>
#include <sys/socket.h> // TODO do we need this?

int otel_span_start(FILE *sdk, const char *type, const char *name) {
  size_t buffer_size = 1024 * 4;
  char *buffer = (char*) calloc(buffer_size, sizeof(char));
  if (!buffer) return -1;
  
  char *sdk_response = tmpnam(NULL); // this is unsafe, i know
  if (mkfifo(sdk_response, 0666) != 0) { free(buffer); return -1; }
  
  memset(buffer, 0, buffer_size);
  sprintf(buffer, "SPAN_START %s %s %s %s %s", sdk_response, getenv("TRACEPARENT"), getenv("TRACESTATE"), type, name);
  fwrite(buffer, sizeof(char), strlen(buffer), sdk);
  fflush(sdk);
  
fprintf(stderr, "DEBUG %s\n sent to SDK", buffer);  
  memset(buffer, 0, buffer_size);  
fprintf(stderr, "DEBUG %s\n", "opening ...");
  FILE *response_file = fopen(sdk_response, "r");
fprintf(stderr, "DEBUG %s\n", "reading ...");
  fread(buffer, sizeof(char), strlen(buffer), response_file);
  fclose(response_file);
  int span_handle = atoi(buffer);
  
  remove(sdk_response);
  free(buffer);
  return span_handle;
}

char * otel_traceparent(FILE *sdk, int span_handle) {
  size_t buffer_size = 1024 * 4;
  char *buffer = (char*) calloc(buffer_size, sizeof(char));
  if (!buffer) return NULL;
  
  char *sdk_response = tmpnam(NULL); // this is unsafe, i know
  if (mkfifo(sdk_response, 0666) != 0) { free(buffer); return NULL; }

  memset(buffer, 0, buffer_size);
  sprintf(buffer, "SPAN_TRACEPARENT %s %d", sdk_response, span_handle);
  fwrite(buffer, sizeof(char), strlen(buffer), sdk);
  fflush(sdk);

  memset(buffer, 0, buffer_size);
  FILE *response_file = fopen(sdk_response, "r");
  fread(buffer, sizeof(char), strlen(buffer), response_file);
  fclose(response_file);

  remove(sdk_response);
  return buffer;
}

int inject(char *buffer, size_t length) {
  char *line_end = strchr(buffer, '\n');
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
      FILE *sdk = fopen(getenv("OTEL_SHELL_INJECT_HTTP_SDK_PIPE"), "a+");
      if (!sdk) return 4;
      int span_handle = otel_span_start(sdk, "CLIENT", "HTTP");
      if (span_handle < 0) return 5;
      {
        char span_handle_string[16];
        memset(span_handle_string, 0, 16);
        sprintf(span_handle_string, "%d", span_handle);
        FILE *storage = fopen(getenv("OTEL_SHELL_INJECT_HTTP_HANDLE_FILE"), "w");
        if (!storage) return 6;
        fwrite(span_handle_string, sizeof(char), strlen(span_handle_string), storage); // TODO this could fail, what then?
        fclose(storage);
      }
      char *traceparent = otel_traceparent(sdk, span_handle);
      if (!traceparent) return 7;
      if (strlen("traceparent: ") + strlen(traceparent) + 1 != strlen(buffer)) { free(traceparent); return 8; }
      sprintf(buffer, "traceparent: %s\r", traceparent);
      free(traceparent);
      fclose(sdk); // this will leak on some early aborts, process terminate will clean it up
      *line_end = '\n';
      return 0;
    }
    *line_end = '\n';
    buffer = line_end + 1;
    line_end = strchr(buffer, '\n');
  }
  
  return 3;
}

int inject_safely(char *buffer, size_t length) {
  char last = buffer[length - 1];
  buffer[length - 1] = '\0';
  int result = inject(buffer, length);
  buffer[length - 1] = last;
  return result;
}

ssize_t (*original_send)(int sockfd, const void *buf, size_t len, int flags);
ssize_t send(int sockfd, const void *buf, size_t len, int flags) {
    int result = inject_safely((char *) buf, len);
    fprintf(stderr, "DEBUG %d\n", result);
    return original_send(sockfd, buf, len, flags);
}

int (*original_SSL_write)(void *ssl, const void *buf, int num);
int SSL_write(void *ssl, const void *buf, int num) {
    int result = inject_safely((char *) buf, (size_t) num);
    fprintf(stderr, "DEBUG %d\n", result);
    return original_SSL_write(ssl, buf, num);
}

__attribute__ ((constructor))
void init() {
    original_send = dlsym(RTLD_NEXT, "send");
    original_SSL_write = dlsym(RTLD_NEXT, "SSL_write");
}
