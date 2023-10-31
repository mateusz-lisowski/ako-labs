; program przykładowy (wersja 32-bitowa)
.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)

public _main
.data
tekst db 10, 'Nazywam sie . . . ' , 10
db 'Moj pierwszy 32-bitowy program '
db 'asemblerowy dziala juz poprawnie!', 10

.code
_main PROC

    mov ecx, 85 ; liczba znaków wyświetlanego tekstu
    ; wywołanie funkcji ”write” z biblioteki języka C
    push ecx ; liczba znaków wyświetlanego tekstu
    push dword PTR OFFSET tekst ; położenie obszaru
    ; ze znakami
    push dword PTR 1 ; uchwyt urządzenia wyjściowego
    call __write ; wyświetlenie znaków
    ; (dwa znaki podkreślenia _ )
    add esp, 12 ; usunięcie parametrów ze stosu
    ; zakończenie wykonywania programu
    push dword PTR 0 ; kod powrotu programu
    call _ExitProcess@4

_main ENDP
END