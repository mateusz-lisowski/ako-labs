#include <stdio.h>


extern void sum_in_parallel(int* array_a, int* array_b, int* result);


int main()
{
    char numbers_a[16] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
    char numbers_b[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
    char result[16] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

    sum_in_parallel(numbers_a, numbers_b, result);

    for (int i = 0; i < 16; i++)
    {
        printf("%d %d %d\n", numbers_a[i], numbers_b[i], result[i]);
    }

}