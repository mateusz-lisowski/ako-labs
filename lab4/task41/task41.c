#include <stdio.h>


int find_max (int x, int y, int z);


int main()
{
    int x, y, z;

    printf("Enter any three signed numbers: ");
    scanf_s("%d %d %d", &x, &y, &z, 32);

    int result = find_max(x, y, z);
    printf("\nNumber %d is the biggest\n", result);
    
    return 0;
}
