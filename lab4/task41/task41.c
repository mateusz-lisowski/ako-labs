#include <stdio.h>


extern int find_max (int a, int b, int c, int d);


int main()
{
    int a, b, c, d;

    printf("Enter any three signed numbers: ");
    scanf_s("%d %d %d %d", &a, &b, &c, &d, 32);

    int result = find_max(a, b, c, d);
    printf("\nNumber %d is the biggest\n", result);
    
    return 0;
}
