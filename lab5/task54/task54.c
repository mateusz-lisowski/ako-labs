#include <stdio.h>


extern void convert_int_to_float(int* source, float* result);


int main()
{
    int integers[2] = { 2, -69 };
    float floats[2] = { 0, 0 };

    convert_int_to_float(integers, floats);

    for (int i = 0; i < 2; i++)
    {
        printf("%d %d\n", integers[i], floats[i]);
    }

}