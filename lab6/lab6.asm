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
    push cx
    push dx
    push es

    mov ax, 0A000H ; adres pamięci ekranu dla trybu 13H
    mov es, ax

    mov cx, 199
    mov bx, 0
    mov dx, indeks_startowy ; to skip

    ptl: 

        cmp dx, 0
        jne skip
        dec dx

        mov al, cs:kolor
        mov es:[bx], al ; wpisanie kodu koloru do pamięci ekranu

        skip: 
        
        ; przejście do następnego wiersza na ekranie
        add bx, 320
        

        loop ptl

    ; drugi bok
    mov cx, 199
    mov bx, 319

    ptl2: 
    
        mov al, cs:kolor
        mov es:[bx], al ; wpisanie kodu koloru do pamięci ekranu

        ; przejście do następnego wiersza na ekranie
        add bx, 320

        loop ptl2

    ; góra
    mov cx, 319
    mov bx, 320

    ptl3: 
    
        mov al, cs:kolor
        mov es:[bx], al ; wpisanie kodu koloru do pamięci ekranu

        ; przejście do następnego wiersza na ekranie
        add bx, 1

        loop ptl3

    ; dół
    mov cx, 319
    mov bx, 320*199

    ptl4: 
    
        mov al, cs:kolor
        mov es:[bx], al ; wpisanie kodu koloru do pamięci ekranu

        ; przejście do następnego wiersza na ekranie
        add bx, 1

        loop ptl4

    ; odtworzenie rejestrów
    pop es
    pop dx
    pop cx
    pop bx
    pop ax

    ; skok do oryginalnego podprogramu obsługi przerwania
    ; zegarowego
    jmp dword PTR cs:wektor8

    ; zmienne procedury
    kolor db 1 ; bieżący numer koloru
    indeks_startowy dw 10  
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
mov eax, es:[36] ; odczytanie wektora nr 8
mov cs:wektor8, eax; zapamiętanie wektora nr 8

; adres procedury 'linia' w postaci segment:offset
mov ax, SEG linia
mov bx, OFFSET linia
cli ; zablokowanie przerwań

; zapisanie adresu procedury 'linia' do wektora nr 8
mov es:[36], bx
mov es:[36+2], ax
sti ; odblokowanie przerwań

czekaj:

mov ah, 1 ; sprawdzenie czy jest jakiś znak
int 16h ; w buforze klawiatury
jz czekaj

mov ah, 0
int 16H
cmp al, 'x' ; porównanie z kodem litery 'x'
jne czekaj ; skok, gdy inny znak

mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
mov al, 3H ; nr trybu
int 10H

; odtworzenie oryginalnej zawartości wektora nr 8
mov eax, cs:wektor8
mov es:[36], eax

; zakończenie wykonywania programu
mov ax, 4C00H
int 21H

rozkazy ENDS

stosik SEGMENT stack
db 256 dup (?)
stosik ENDS

END zacznij
