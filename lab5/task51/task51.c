#include <stdio.h>


extern float harmonic_avg(float* array, unsigned int size);


int main()
{
    float numbers[] = { 1.5f, 3.4f, 0.69f }

    float result = harmonic_avg(numbers, sizeof(numbers)/sizeof(numbers[0]));

    printf("\nHarmonic avg equals: %f\n", numb);

    return 0;
}
