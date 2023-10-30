.686
.model flat

extern _ExitProcess@4 : PROC
extern __read : PROC

public _main

MAX_SIZE equ 12                 ; Set max size of the user number to 12 decimal chars

.data
user_input db MAX_SIZE dup (?)  ; Declare space for user input in memory
ten db 10                       ; Set 10 in memory for multiplication purposes

.code

read_dec_num_to_eax PROC
    push esi
    push ebx

    ; Set global registers 
    mov esi, 0
    mov eax, 0

    ; Convert number from decimal to binary
    convert:
        mov bl, user_input[esi]     ; Read character to bl
        inc esi                     ; At the same time increment esi (for you not to forget to change it later)

        cmp bl, 10                  ; Compare bl to 10 (enter char) 
        je finish                   ; If the char is entern, finish 

        sub bl, 30H                 ; Convert ASCII codes for numbers to the actual number
        movzx ebx, bl               ; Expand the number to whole ebx

        mul TEN                     ; Multiply result by 10
        add eax, ebx                ; Add newly find number to eax
        
        jmp convert

    finish:                         ; Finish function execution
        pop ebx
        pop esi
        ret

read_dec_num_to_eax ENDP

_main PROC
    
    ; Read the user number
    push MAX_SIZE
    push OFFSET user_input
    push 0
    call __read
    add esp, 12

    ; Call custom function
    call read_dec_num_to_eax

    ; End of the program
    push 0
    call _ExitProcess@4

_main ENDP
END