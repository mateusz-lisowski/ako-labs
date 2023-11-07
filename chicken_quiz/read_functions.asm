.686
.model flat

extern __read : PROC

STDIN equ 0

INPUT_MAX_SIZE equ 8                     ; Set max size of the user number to 12 decimal chars

.data

TEN db 10   ; Set 10 in memory for multiplication purposes

user_input db INPUT_MAX_SIZE dup (?)      ; Declare space for user input in memory

.code

read_dec_num_to_eax PROC
    push ebx 
    push ecx 
    push edx
    push esi 
    push edi
    push ebp

    ; Read the user number
    push INPUT_MAX_SIZE
    push OFFSET user_input
    push STDIN
    call __read
    add esp, 12

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
        pop ebp 
        pop edi 
        pop esi 
        pop edx 
        pop ecx 
        pop ebx
        ret

read_dec_num_to_eax ENDP

END