#include <stdio.h>

#define SIZE 4


extern void add_sub_one(float* floats);


int main()
{
    float floats[SIZE] = { -69, 69, 1, 2 };

    add_sub_one(floats);

    for (int i = 0; i < SIZE; i++)
    {
        printf("%f\n", floats[i]);
    }

}