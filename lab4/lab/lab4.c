#include <stdio.h>


extern unsigned int find_char(wchar_t* chars_array, wchar_t character, wchar_t** result);


int main()
{
    wchar_t chars_array[] = L"aaAAAAbb";
    wchar_t char_to_find = L'k';
    
    wchar_t** result_pointer = &chars_array;

    int result = find_char(chars_array, char_to_find, result_pointer);
    
    printf("\nResult is: %d\n", result);
    printf("\nResult is: %ls\n", *result_pointer);


    return 0;
}
