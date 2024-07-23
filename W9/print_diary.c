// prints out contents of $HOME/.diary

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *filename = ".diary";

int main(void) {
    // Create path $HOME/.diary

    // Get the environment variable for home
    char *home_pathname = getenv("HOME");

    if (home_pathname == NULL) {
        home_pathname = ".";
    }

    // add 1 for '/' and 1 for '\0'
    int size_pathname = strlen(home_pathname) + strlen(filename) + 2;

    char *full_pathname = malloc(size_pathname * sizeof(char));

    snprintf(full_pathname, size_pathname, "%s/%s", home_pathname, filename);

    FILE *input = fopen(full_pathname, "r");

    if (input == NULL) {
        perror("");
        exit(1);
    }

    int curr_char;

    while ((curr_char = fgetc(input)) != EOF) {
        fputc(curr_char, stdout);
    }

    fclose(input);
    free(full_pathname);
    return 0;
}