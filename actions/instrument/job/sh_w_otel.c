#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define OTEL_INJECT_COMMAND ". otel.sh\n"

char* find_command_in_path(const char *command) {
    char *path = getenv("PATH");
    if (!path) return NULL;
    char *path_copy = strdup(path);
    char *directory = strtok(path_copy, ":");
    while (directory != NULL) {
        char *fullpath = malloc(strlen(directory) + strlen(command) + 2);
        if (!fullpath) continue;
        sprintf(fullpath, "%s/%s", directory, command);
        if (access(fullpath, X_OK) == 0) {
            free(path_copy);
            return fullpath; // Caller should free this memory
        }
        free(fullpath);
        directory = strtok(NULL, ":");
    }
    free(path_copy);
    return NULL;
}

int modify_script(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Failed to open file");
        return -1;
    }
    
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);

    char *content = malloc(size + 1);
    if (!content) {
        fclose(file);
        perror("Memory allocation failed for content");
        return -1;
    }

    fread(content, 1, size, file);
    content[size] = '\0';
    fclose(file);
    // Check for shebang and adjust accordingly
    char *new_content;
    char *shebang = strstr(content, "#!");
    if (shebang && shebang == content) {
        // Shebang present, find end of line
        char *end_of_line = strchr(shebang, '\n');
        if (!end_of_line) {
            // Corrupted or abnormal script file
            free(content);
            return -1;
        }
        size_t shebang_length = end_of_line - content + 1; // Include newline
        new_content = malloc(size + strlen(OTEL_INJECT_COMMAND) + 1);
        strncpy(new_content, content, shebang_length); 
        strcpy(new_content + shebang_length, OTEL_INJECT_COMMAND);
        strcpy(new_content + shebang_length + strlen(OTEL_INJECT_COMMAND), content + shebang_length);
    } else {
        // No shebang, prepend directly
        new_content = malloc(size + strlen(OTEL_INJECT_COMMAND) + 1);
        strcpy(new_content, OTEL_INJECT_COMMAND);
        strcat(new_content, content);
    }

    file = fopen(filename, "w");
    if (!file) {
        free(content);
        free(new_content);
        perror("Failed to open file for writing");
        return -1;
    }
    
    fwrite(new_content, 1, strlen(new_content), file);
    fclose(file);
    free(content);
    free(new_content);
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s [-option] script.sh [script arguments]\n", argv[0]);
        return 1;
    }

    int script_index = 1;
    for (; script_index < argc; script_index++) {
        if (argv[script_index][0] != '-') {
            break;
        }
    }

    if (script_index == argc) {
        fprintf(stderr, "No script file provided.\n");
        return 1;
    }

    if (modify_script(argv[script_index]) != 0) {
        return 1;
    }

    char *bash_path = find_command_in_path("bash"); // TODO find all kind of shells (also sh, ash dash)
    if (!bash_path) {
        fprintf(stderr, "Bash executable not found in PATH.\n");
        return 1;
    }
    char **exec_args = malloc((argc + 1) * sizeof(char *));
    if (!exec_args) {
        perror("Failed to allocate memory for exec arguments");
        free(bash_path);
        return 1;
    }

    exec_args[0] = bash_path;
    for (int i = 1; i < argc; i++) {
        exec_args[i] = argv[i];
    }
    exec_args[argc] = NULL;

    execv(bash_path, exec_args);
    perror("Failed to exec bash");

    free(bash_path);
    free(exec_args);
    return 1; // execv returns only on error
}
