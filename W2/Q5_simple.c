// Squares a number, unless its square is too big for a 32-bit integer.
// If it is too big, prints an error message instead.

#include <stdio.h>

#define SQUARE_MAX 46340

int main(void) {
    int x;
    int y;

    printf("Enter a number: ");
    scanf("%d", &x);

    if (x <= SQUARE_MAX) goto else_statement;
    printf("square too big for 32 bits\n");

    goto if_end;
    else_statement:

    y = x * x;
    printf("%d", y);
    printf("\n");

    if_end:

    return 0;

}