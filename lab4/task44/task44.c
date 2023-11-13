#include <stdio.h>


extern void swap_elements(int* numbers, int size);


int main()
{
    int numbers[] = { 0, 0, 10, -10, 87, 1568, -933, -8, 0 };
    int size = sizeof(numbers) / sizeof(int);

    for (int i = 0; i < size; i++) {
        swap_elements(numbers, size);
    }

    printf("\nSorted array:\n");
    for (int i = 0; i < size; i++) {
        printf("%d, ", numbers[i]);
    }

    return 0;
}
