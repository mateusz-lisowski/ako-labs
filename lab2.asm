.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)

public _main

.data
	tekst_pocz db 10, 'Prosze napisac jakis tekst '
	db 'i nacisnac Enter', 10
	koniec_t db ?
	magazyn1 db 80 dup (?)
	magazyn2 db 240 dup (?)
	nowa_linia db 10
	liczba_znakow dd ?

.code
_main PROC

	; wyświetlenie tekstu informacyjnego
	; liczba znaków tekstu
	 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
	 push ecx
	 push OFFSET tekst_pocz ; adres tekstu
	 push 1 ; nr urządzenia (tu: ekran - nr 1)
	 call __write ; wyświetlenie tekstu początkowego
	 add esp, 12 ; usuniecie parametrów ze stosu

	; czytanie wiersza z klawiatury
	 push 80 ; maksymalna liczba znaków
	 push OFFSET magazyn1
	 push 0 ; nr urządzenia (tu: klawiatura - nr 0)
	 call __read ; czytanie znaków z klawiatury
	 add esp, 12 ; usuniecie parametrów ze stosu

	; kody ASCII napisanego tekstu zostały wprowadzone
	; do obszaru 'magazyn'
	; funkcja read wpisuje do rejestru EAX liczbę
	; wprowadzonych znaków
	 mov liczba_znakow, eax
	; rejestr ECX pełni rolę licznika obiegów pętli
	 mov ecx, eax

	 mov ebx, 0 ; indeks początkowy
	 mov esi, 0 

ptl: 

	 mov dl, magazyn1[ebx] ; pobranie kolejnego znaku

	 cmp dl, '/'
	 je zmien_spac

	 cmp dl, 0A5H
	 je zmien_a_z_kreska

	 cmp dl, 086H
	 je zmien_c_z_kreska

	 cmp dl, 0A9H
	 je zmien_e_z_kreska

	 cmp dl, 088H
	 je zmien_l_z_kreska

	 cmp dl, 0E4H
	 je zmien_n_z_kreska

	 cmp dl, 0A2H
	 je zmien_o_z_kreska

	 cmp dl, 098H
	 je zmien_s_z_kreska

	 cmp dl, 0ABH
	 je zmien_z_z_kreska

	 cmp dl, 0BEH
	 je zmien_z_z_kropka

	 cmp dl, 'a'
	 jb dalej ; skok, gdy znak nie wymaga zamiany

	 cmp dl, 'z'
	 ja dalej ; skok, gdy znak nie wymaga zamiany

	 sub dl, 20H ; zamiana na wielkie litery
	; odesłanie znaku do pamięci
	 mov magazyn2[esi], dl


zmien_a_z_kreska:
	cmp dl, 0A5H
	jne koniec

	mov magazyn2[esi], 0A4H
	jmp koniec

zmien_c_z_kreska:
	cmp dl, 086H
	jne koniec

	mov magazyn2[esi], 08FH
	jmp koniec

zmien_e_z_kreska:
	cmp dl, 0A9H
	jne koniec

	mov magazyn2[esi], 0A8H
	jmp koniec

zmien_l_z_kreska:
	cmp dl, 088H
	jne koniec

	mov magazyn2[esi], 09DH
	jmp koniec

zmien_n_z_kreska:
	cmp dl, 0E4H
	jne koniec

	mov magazyn2[esi], 0E3H
	jmp koniec

zmien_o_z_kreska:
	cmp dl, 0A2H
	jne koniec

	mov magazyn2[esi], 0E0H
	jmp koniec

zmien_s_z_kreska:
	cmp dl, 098H
	jne koniec

	mov magazyn2[esi], 097H
	jmp koniec

zmien_z_z_kreska:
	cmp dl, 0ABH
	jne koniec

	mov magazyn2[esi], 08DH
	jmp koniec

zmien_z_z_kropka:
	cmp dl, 0BEH
	jne koniec

	mov magazyn2[esi], 0BDH
	jmp koniec


zmien_spac:

	cmp dl, '/'
	jne koniec
	
	mov magazyn2[esi], ' '
	inc esi
	mov magazyn2[esi], ' '
	inc esi
	mov magazyn2[esi], ' '

	mov edi, liczba_znakow
	add edi, 2
	mov liczba_znakow, edi

	jmp koniec

dalej: 
	
	mov magazyn2[esi], dl

koniec:

	inc ebx ; inkrementacja indeksu
	inc esi

	cmp ebx, ecx
	jle ptl ; sterowanie pętlą

	; wyświetlenie przekształconego tekstu
	 push liczba_znakow
	 push OFFSET magazyn2
	 push 1
	 call __write ; wyświetlenie przekształconego tekstu
	 add esp, 12 ; usuniecie parametrów ze stosu
	 push 0
	 call _ExitProcess@4 ; zakończenie programu
_main ENDP
END