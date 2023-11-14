# Zadanie

Napisać podprogram w 32-bitowym assemblerze, który wskazuje podany *znak (kodowanie UTF-16 BMP) w obszarze *tablica. 
Obszar *tablica zawiera ciąg znaków UTF-16, zakończony znakiem zerowym. 

Podprogram powinien być przystosowany do wywoływania z poziomu języka C,
a jego prototyp ma postać:

`unsigned int szukaj(wchar_t, tablica[], wchar_t znak, wchar_t** wynik);`

Wyznaczony adres pierwszego znalezionego znaku w obszarze *tablica pewien zostać wpisany do zmiennej, której adres podaje trzeci parametr.
Jeśli znak nie został odnaleziony, to wpisuje się wartość zero, (null). 

Jako wynik funkcja zwraca liczbę znalezionych wszystkich wystąpień szukanego znaku.
Zademonstrować działanie w przykładowym kodzie w języku C.
