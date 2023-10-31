.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main

.data
eax_val dd 0                ; Declare the eaz_val chunk of the memory

.code

read_hex_num_to_eax PROC
   ; wczytywanie liczby szesnastkowej z klawiatury – liczba po
; konwersji na postać binarną zostaje wpisana do rejestru EAX
; po wprowadzeniu ostatniej cyfry należy nacisnąć klawisz
; Enter
push ebx
push ecx
push edx
push esi
push edi
push ebp
; rezerwacja 12 bajtów na stosie przeznaczonych na tymczasowe
; przechowanie cyfr szesnastkowych wyświetlanej liczby
sub esp, 12 ; rezerwacja poprzez zmniejszenie ESP
mov esi, esp ; adres zarezerwowanego obszaru pamięci
push dword PTR 10 ; max ilość znaków wczytyw. liczby
push esi ; adres obszaru pamięci
push dword PTR 0; numer urządzenia (0 dla klawiatury)
call __read ; odczytywanie znaków z klawiatury
; (dwa znaki podkreślenia przed read)
add esp, 12 ; usunięcie parametrów ze stosu
mov eax, 0 ; dotychczas uzyskany wynik
pocz_konw:
mov dl, [esi] ; pobranie kolejnego bajtu
inc esi ; inkrementacja indeksu
cmp dl, 10 ; sprawdzenie czy naciśnięto Enter
je gotowe ; skok do końca podprogramu
; sprawdzenie czy wprowadzony znak jest cyfrą 0, 1, 2 , ..., 9
cmp dl, '0'
jb pocz_konw ; inny znak jest ignorowany
cmp dl, '9'
ja sprawdzaj_dalej
sub dl, '0' ; zamiana kodu ASCII na wartość cyfry
dopisz:
shl eax, 4 ; przesunięcie logiczne w lewo o 4 bity
or al, dl ; dopisanie utworzonego kodu 4-bitowego
 ; na 4 ostatnie bity rejestru EAX
jmp pocz_konw ; skok na początek pętli konwersji
; sprawdzenie czy wprowadzony znak jest cyfrą A, B, ..., F
sprawdzaj_dalej:
cmp dl, 'A'
jb pocz_konw ; inny znak jest ignorowany
cmp dl, 'F'
ja sprawdzaj_dalej2
sub dl, 'A' - 10 ; wyznaczenie kodu binarnego
jmp dopisz
; sprawdzenie czy wprowadzony znak jest cyfrą a, b, ..., f
sprawdzaj_dalej2:
cmp dl, 'a'
jb pocz_konw ; inny znak jest ignorowany
cmp dl, 'f'
ja pocz_konw ; inny znak jest ignorowany
sub dl, 'a' - 10
jmp dopisz
gotowe:
; zwolnienie zarezerwowanego obszaru pamięci
add esp, 12
pop ebp
pop edi
pop esi
pop edx
pop ecx
pop ebx
ret

read_hex_num_to_eax ENDP

print_eax PROC
    pusha                   ; Save registers state
    mov eax_val, eax        ; Save data form eax to eax_val chunk of memory
    push 8                  ; Set size of write to 8 bytes (32 bits)
    push OFFSET eax_val     ; Set eax_val label as place to start writing
    push 1                  ; Set out to stdout 
    call __write            ; Call write function from C library
    add esp, 12             ; Reset write function parameters
    popa                    ; Restore registers state
    ret                     ; Go back to executing code
print_eax ENDP

_main PROC

    call read_hex_num_to_eax
    call print_eax

    ; End of the program
    push 0
    call _ExitProcess@4

_main ENDP
END