.686
.model flat

extern __write : PROC

STDOUT equ 1    ; Set constants for STDOUT

.data

too_much db 'Nope, there are less chickens in the hut', 10, 0           ; Communicate for print too many chickens function
too_few db 'Nope, there are more chickens in the hut', 10, 0            ; Communicate for print too few chickens function
congrats db 'Exacly, there are this much chickens in the hut', 10, 0    ; Communicate for print congrats function

.code

; Print congrates when user typed correct number of chickens
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

; Print when guessed too many chickens
print_to_many_chickens PROC
    pusha                       ; Save registers state

    push LENGTHOF too_much      ; Calculate size of too_much
    push OFFSET too_much        ; Set too_much label as place to start writing
    push STDOUT                 ; Set out to stdout 
    call __write                ; Call write function from C library
    add esp, 12                 ; Reset write function parameters

    popa                        ; Restore registers state
    ret                         ; Return from the function
print_to_many_chickens ENDP

; Print when user guessed too few chickens
print_to_few_chickens PROC
    pusha                       ; Save registers state

    push LENGTHOF too_few       ; Calculate size of too_few
    push OFFSET too_few         ; Set too_few label as place to start writing
    push STDOUT                 ; Set out to stdout 
    call __write                ; Call write function from C library
    add esp, 12                 ; Reset write function parameters

    popa                        ; Restore registers state
    ret                         ; Return from the function
print_to_few_chickens ENDP

END