.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main

USER_INPUT_SIZE equ 96
MAX_HINT_SIZE equ 128

STDIN equ 0
STDOUT equ 1

.data

hint db 'Please, write some text and press enter: ', 0      ; Hint to help user understand the program 
user_input db USER_INPUT_SIZE dup (?)                       ; Allocate memory for user input

.code
_main PROC

    ; Write hint to the console
    push MAX_HINT_SIZE          ; Length of the hint
    push OFFSET hint            ; Address of the hint
    push STDOUT                 ; Set out to STDOUT
    call __write                ; Call write function
    add esp, 12                 ; Remove parameters from stack

    ; Read user input
    push USER_INPUT_SIZE        ; Max length of the user input
    push OFFSET user_input      ; Address of the user input
    push STDIN                  ; Set in to STDIN
    call __read                 ; Call read function    
    add esp, 12                 ; Remove parameters from stack

    ; Initialize registers
    mov ecx, eax                ; Move number of written characters (eax) to ecx
    mov esi, 0                  ; Set esi to 0

    convert:

        mov al, user_input[esi]     ; Move character from user_input to al

        ; Change all polish specific characters to upper case
        ; Read fuction saves them in Latin2 encoding
        ; Write fuction writes them in Latin2 encoding
        
        cmp al, 0A5H                ; Check for 'ą' character
        je change_a

        cmp al, 086H                ; Check for 'ć' character
        je change_c

        cmp al, 0A9H                ; Check for 'ę' character
        je change_e

        cmp al, 088H                ; Check for 'ł' character
        je change_l

        cmp al, 0E4H                ; Check for 'ń' character
        je change_n

        cmp al, 0A2H                ; Check for 'ó' character
        je change_o

        cmp al, 098H                ; Check for 'ś' character
        je change_s

        cmp al, 0ABH                ; Check for 'ź' character
        je change_z1

        cmp al, 0BEH                ; Check for 'ż' character
        je change_z2

        cmp al, 'a'                 ; Check if character is smaller than 'a'
        jb skip                     ; If yes, it does not need to be changed, so skip

        cmp al, 'z'                 ; Check if character is grater than 'z'
        ja skip                     ; If yes, it does not need to be changed, so skip

        sub al, 20H                 ; Transform small letters into big ones
        mov user_input[esi], al     ; Save transformed character to memory

    change_a:                       ; Change 'ą' to 'Ą'

        cmp al, 0A5H
        jne save

        mov al, 0A4H
        jmp save

    change_c:                       ; Change 'ć' to 'Ć'

            cmp al, 086H
            jne save

            mov al, 08FH
            jmp save


    change_e:                       ; Change 'ę' to 'Ę'

            cmp al, 0A9H
            jne save

            mov al, 0A8H
            jmp save


    change_l:                       ; Change 'ł' to 'Ł'

            cmp al, 088H
            jne save

            mov al, 09DH
            jmp save


    change_n:                       ; Change 'ń' to 'Ń'

            cmp al, 0E4H
            jne save

            mov al, 0E3H
            jmp save

            

    change_o:                       ; Change 'ó' to 'Ó'

            cmp al, 0A2H
            jne save

            mov al, 0E0H
            jmp save


    change_s:                       ; Change 'ś' to 'Ś'

            cmp al, 098H
            jne save

            mov al, 097H
            jmp save


    change_z1:                      ; Change 'ź' to 'Ź'

            cmp al, 0ABH
            jne save

            mov al, 08DH
            jmp save


    change_z2:                      ; Change 'ż' to 'Ż'

            cmp al, 0BEH
            jne save

            mov al, 0BDH
            jmp save

    save:                           

        mov user_input[esi], al     ; Save transformed character to memory

    skip: 
    
        inc esi                     ; Increment esi, as it is loop counter
        cmp esi, ecx                ; Check if all characters have been read
        jne convert                 ; If no, continue the loop 
    
    
    ; Write transformed user imput
    push ecx                    ; Register ecx contains number of characters enterd by user
    push OFFSET user_input      ; Addresss of user input
    push STDOUT                 ; Set out to STDOUT
    call __write                ; Call write function
    add esp, 12                 ; Remove parameters from stack

    ; Exit program
    push 0
    call _ExitProcess@4

_main ENDP
END