#include <stdio.h>

const int NUMBER_OF_CALCULATIONS = 20;


extern float func(float x);


int main()
{
    
    float sum = 1.0f;

    for (int i = 0; i < NUMBER_OF_CALCULATIONS; i++) 
    {
        float result = func(i);
        sum += result;
    }
    
    printf("sum = %f\n", sum);
}
