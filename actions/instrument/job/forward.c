#include <stdlib.h>

#ifndef EXECUTBALE
#error must define executable
#endif

int main(int argc, char **argv) {
    int new_argc = argc;
#ifdef ARG1
    new_argc++;
#endif
#ifdef ARG2
    new_argc++;
#endif
    
    char **new_argv = (char**) calloc((size_t) new_argc, sizeof(char*) + 1);
    int i = 0;
    new_argv[i++] = EXECUTABLE;
#ifdef ARG1
    new_argv[i++] = ARG1;
#endif
#ifdef ARG2
    new_argv[i++] = ARG2;
#endif
    for (int j = 1; j < argc; j++) {
        new_argv[i++] = argv[j];
    }
    new_argv[i++] = NULL;
    
    execv(EXECUTABLE, new_argv);
    perror("execv failed");
    free(new_argv);
    return 1;
}
