#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>

ssize_t (*original_send)(int sockfd, const void *buf, size_t len, int flags);

ssize_t send(int sockfd, const void *buf, size_t len, int flags) {
/*
    const char *header = "Custom-Header: MyValue\r\n";
    if (strncmp(buf, "GET ", 4) == 0 || strncmp(buf, "POST ", 5) == 0) {
        // Find the end of the headers
        const char *end = strstr(buf, "\r\n\r\n");
        if (end) {
            char new_buf[4096];
            int header_len = (end - (char *)buf) + 4;
            snprintf(new_buf, sizeof(new_buf), "%.*s%s%.*s", header_len, (char *)buf, header, (int) len - header_len, end + 4);
            return original_send(sockfd, new_buf, strlen(new_buf), flags);
        }
    }
*/
    fprintf(stderr, 'DEBUG\n');
    return original_send(sockfd, buf, len, flags);
}

__attribute__ ((constructor))
void init() {
    original_send = dlsym(RTLD_NEXT, "send");
}
