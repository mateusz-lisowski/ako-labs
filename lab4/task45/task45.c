#include <stdio.h>


extern __int64 sum_seven(__int64 a, __int64 b, __int64 c, __int64 d, __int64 e, __int64 f, __int64 g);


int main()
{
    __int64 a, b, c, d, e, f, g;

    printf("Enter any seven signed numbers: ");
    scanf_s("%lld %lld %lld %lld %lld %lld %lld", &a, &b, &c, &d, &e, &f, &g, 64);

    __int64 result = sum_seven(a, b, c, d, e, f, g);

    printf("\nSum is: %d\n", result);

    return 0;
}
