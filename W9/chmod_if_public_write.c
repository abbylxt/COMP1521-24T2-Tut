// removes public write from all files

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>


void chmod_if_public_write(char *pathname) {
    struct stat file_stat;

    if (stat(pathname, &file_stat) != 0) {
        perror("error: ");
        exit(1);
    }

    mode_t file_mode = file_stat.st_mode;

    if ((S_IWOTH & file_mode) == 0) {
        // case that file is not publicly writeable
        return;
    }

    file_mode = file_mode & ~S_IWOTH;

    // Example
    // S_IWOTH = 0b0000000010
    // mode =     0b1111111111
    // ~S_IWOTH = 0b1111111101
    //  mode & ~S_IWOTH = 0b1111111101

    if (chmod(pathname, file_mode) != 0) {
        perror(pathname);
        exit(2);
    }

}

int main(int argc, char *argv[]) {
    for (int arg = 1; arg < argc; arg++) {
        chmod_if_public_write(argv[arg]);
    }
    return 0;
}