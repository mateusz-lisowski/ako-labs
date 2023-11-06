.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main

STDOUT equ 1
STDIN equ 0

.data

too_much db 'Nope, there are less chickens in the hut', 10, 0
too_little db 'Nope, there are more chickens in the hut', 10, 0
congrats db 'Exacly, there are this much chickens in the hut', 10, 0

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

_main PROC

    call print_to_many_chikens
    call print_to_little_chikens
    call print_congrats

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP
END