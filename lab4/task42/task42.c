#include <stdio.h>


extern void inverse(int* number);


int main()
{
    int number;

    printf("Enter number to inverse: ");
    scanf_s("%d", &number, 32);

    inverse(&number);

    printf("\nInverse is %d\n", number);

    return 0;
}
