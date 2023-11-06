.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main

STDOUT equ 1
STDIN equ 0

INPUT_MAX_SIZE equ 8                     ; Set max size of the user number to 12 decimal chars

.data

TEN db 10   ; Set 10 in memory for multiplication purposes

too_much db 'Nope, there are less chickens in the hut', 10, 0
too_little db 'Nope, there are more chickens in the hut', 10, 0
congrats db 'Exacly, there are this much chickens in the hut', 10, 0

user_input db INPUT_MAX_SIZE dup (?)      ; Declare space for user input in memory

.code

print_congrats PROC
    pusha                       ; Save registers state

    push LENGTHOF congrats      ; Calculate size of congrats
    push OFFSET congrats        ; Set too_much label as place to start writing
    push STDOUT                 ; Set out to stdout 
    call __write                ; Call write function from C library
    add esp, 12                 ; Reset write function parameters

    popa                        ; Restore registers state
    ret                         ; Return from the function
print_congrats ENDP

print_to_many_chikens PROC
    pusha                       ; Save registers state

    push LENGTHOF too_much      ; Calculate size of too_much
    push OFFSET too_much        ; Set too_much label as place to start writing
    push STDOUT                 ; Set out to stdout 
    call __write                ; Call write function from C library
    add esp, 12                 ; Reset write function parameters

    popa                        ; Restore registers state
    ret                         ; Return from the function
print_to_many_chikens ENDP

print_to_little_chikens PROC
    pusha                       ; Save registers state

    push LENGTHOF too_little    ; Calculate size of too_little
    push OFFSET too_little      ; Set too_little label as place to start writing
    push STDOUT                 ; Set out to stdout 
    call __write                ; Call write function from C library
    add esp, 12                 ; Reset write function parameters

    popa                        ; Restore registers state
    ret                         ; Return from the function
print_to_little_chikens ENDP

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

_main PROC

    mov ebx, 10                 ; Set the start number of the chickens

    guess:
        
        call read_dec_num_to_eax    ; Read user guess
        cmp eax, ebx
        ja too_many_chickens
        jb too_little_chickens
        jmp found

    too_many_chickens:
        call print_to_many_chikens
        jmp guess

    too_little_chickens:
        call print_to_little_chikens
        jmp guess

    found:
        call print_congrats

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP
END