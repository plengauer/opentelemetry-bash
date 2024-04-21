#include <stdlib.h>

// forward [ forward arg1 arg2 NULL ] => EXECUTABLE [ EXECUTABLE ARG1 ARG2 arg1 arg2 NULL ]

#ifndef EXECUTABLE
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
    
    char **new_argv = (char**) calloc((size_t) new_argc + 1, sizeof(char*));
    int i = 0;
    new_argv[i++] = #EXECUTABLE;
#ifdef ARG1
    new_argv[i++] = #ARG1;
#endif
#ifdef ARG2
    new_argv[i++] = #ARG2;
#endif
    for (int j = 1; j < argc; j++) {
        new_argv[i++] = argv[j];
    }
    new_argv[i++] = NULL;
    
    execv(#EXECUTABLE, new_argv);
    perror("execv failed");
    free(new_argv);
    return 1;
}
