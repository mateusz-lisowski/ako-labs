#include <stdio.h>

#define SIZE 4


extern void convert_int_to_float(int* source, float* result);


int main()
{
    int integers[SIZE] = { 2, -69 };
    float floats[SIZE] = { 0, 0 };

    convert_int_to_float(integers, floats);

    for (int i = 0; i < SIZE / 2; i++)
    {
        printf("%d %f\n", integers[i], floats[i]);
    }

}