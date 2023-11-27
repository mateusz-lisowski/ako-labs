#include <stdio.h>

extern float func(float x);


int main()
{   
    float result = func(2.0f);
    printf("Result equals: %f\n", result);
}
