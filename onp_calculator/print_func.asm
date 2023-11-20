.686
.model flat

; Import c functions
extern __write : PROC

; Declare constants
STDOUT equ 1                        ; Constant for standard output

.data

eax_val db 8 dup (?)                ; Declare the eax_val chunk of the memory for converted number
ten dd 10                           ; Declare 10 for division purposes

.code

print_eax_as_number PROC

    ; Save registers state
    pusha                   

    mov esi, 7                  ; Set esi to point to last part of eax_val 

    convert:

        xor edx, edx            ; Reset older part of dividend
        div ten                 ; Divide EAX by 10

        ; Rest from division is last part of number to show
        add dl, 030H            ; Convert number to its ascii code
        mov eax_val[esi], dl    ; Move changed number to memory
        dec esi                 ; Move pointer to next free cell

        ; Finish when EAX is equal to 0 which means number was fully converted
        cmp eax, 0
        jne convert

    ; Write converted number to STDOUT
    push 8                  ; Set size of write to 8 bytes (32 bits)
    push OFFSET eax_val     ; Set eax_val label as place to start writing
    push STDOUT             ; Set out to stdout 
    call __write            ; Call write function from C library

    add esp, 12             ; Remove write function parameters from stack

    ; Finish function execution
    popa                    ; Restore registers state
    ret                     ; Go back to executing code

print_eax_as_number ENDP

END