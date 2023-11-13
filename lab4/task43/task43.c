#include <stdio.h>


extern void decrement(int** number);


int main()
{
    int number;
    int* ptr = &number;

    printf("Enter number to decrease: ");
    scanf_s("%d", ptr, 32);

    decrement(&ptr);

    printf("\nDecreased is %d\n", number);

    return 0;
}
