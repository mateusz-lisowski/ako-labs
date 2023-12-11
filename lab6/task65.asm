; Program linie.asm
; Wyświetlanie znaków * w takt przerwań zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zakończenie programu po naciśnięciu dowolnego klawisza
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;

.386
rozkazy SEGMENT use16
ASSUME cs:rozkazy

linia PROC

    ; przechowanie rejestrów
    push ax
    push bx
    push es

    mov ax, 0A000H ; adres pamięci ekranu dla trybu 13H
    mov es, ax

    mov bx, cs:adres_piksela ; adres bieżący piksela
    mov al, cs:kolor
    mov es:[bx], al ; wpisanie kodu koloru do pamięci ekranu

    ; przejście do następnego wiersza na ekranie
    add bx, 321

    ; sprawdzenie czy cała linia wykreślona
    cmp bx, 320*200
    jb dalej ; skok, gdy linia jeszcze nie wykreślona

    ; kreślenie linii zostało zakończone - następna linia będzie
    ; kreślona w innym kolorze o 10 pikseli dalej
    add word PTR cs:przyrost, 10
    mov bx, 10
    add bx, cs:przyrost
    inc cs:kolor ; kolejny kod koloru

    ; zapisanie adresu bieżącego piksela
    dalej:

    mov cs:adres_piksela, bx

    ; odtworzenie rejestrów
    pop es
    pop bx
    pop ax

    ; skok do oryginalnego podprogramu obsługi przerwania
    ; zegarowego
    jmp dword PTR cs:wektor8

    ; zmienne procedury
    kolor db 1 ; bieżący numer koloru
    adres_piksela dw 10 ; bieżący adres piksela
    przyrost dw 0
    wektor8 dd ?

linia ENDP

; INT 10H, funkcja nr 0 ustawia tryb sterownika graficznego
zacznij:

mov ah, 0
mov al, 13H ; nr trybu
int 10H
mov bx, 0
mov es, bx ; zerowanie rejestru ES
mov eax, es:[32] ; odczytanie wektora nr 8
mov cs:wektor8, eax; zapamiętanie wektora nr 8

; adres procedury 'linia' w postaci segment:offset
mov ax, SEG linia
mov bx, OFFSET linia
cli ; zablokowanie przerwań

; zapisanie adresu procedury 'linia' do wektora nr 8
mov es:[32], bx
mov es:[32+2], ax
sti ; odblokowanie przerwań

czekaj:

mov ah, 1 ; sprawdzenie czy jest jakiś znak
int 16h ; w buforze klawiatury
jz czekaj
mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
mov al, 3H ; nr trybu
int 10H

; odtworzenie oryginalnej zawartości wektora nr 8
mov eax, cs:wektor8
mov es:[32], eax

; zakończenie wykonywania programu
mov ax, 4C00H
int 21H

rozkazy ENDS

stosik SEGMENT stack
db 256 dup (?)
stosik ENDS

END zacznij
