.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC

public _main

.data
eax_val dd 0                ; Declare the eaz_val chunk of the memory

.code

print_eax PROC
    pusha                   ; Save registers state
    mov eax_val, eax        ; Save data form eax to eax_val chunk of memory
    push 8                  ; Set size of write to 8 bytes (32 bits)
    push OFFSET eax_val     ; Set eax_val label as place to start writing
    push 1                  ; Set out to stdout 
    call __write            ; Call write function from C library
    add esp, 12             ; Reset write function parameters
    popa                    ; Restore registers state
    ret                     ; Go back to executing code
print_eax ENDP

_main PROC

    mov eax, 'a'            ; Set eax register value to 'a' ASCII code
    call print_eax          ; Call print_eax function

    ; End of the program
    push 0
    call _ExitProcess@4

_main ENDP
END