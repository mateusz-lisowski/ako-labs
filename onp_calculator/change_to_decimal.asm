.686
.model flat

; !!! TRY TO DELETE THIS SECTION LATER AND CHANGE IT TO LOCAL VARIABLES !!!
.data

ten dd 10

.code

change_to_decimal PROC

    ; Standard function prolog
    push ebp            ; Save EBP on stack
    mov ebp, esp        ; Move current value of ESP to EPB

    ; Save used registers
    push ebx
    push esi

    ; Save pointer to formula in EBX
    mov ebx, [ebp + 8]

    ; Set global registers 
    mov esi, 0
    mov eax, 0

    convert:
        mov cl, [ebx + esi]         ; Read character to cl
        inc esi                     ; At the same time increment esi (for you not to forget to change it later)

        cmp cl, ' '                 ; Compare bl to space (enter char) 
        je finish                   ; If the char is space, finish converting 

        sub cl, 30H                 ; Convert ASCII codes for numbers to the actual number
        movzx ecx, cl               ; Expand the number to whole ECX

        mul ten                     ; Multiply result by 10
        add eax, ecx                ; Add newly found number to EAX
        
        jmp convert                 ; Continue converting

    finish:                         ; Finish function execution

    ; Standard function epilog
    pop ebp             ; Restore EBP from stack
    ret                 ; Return to current value of ESP

change_to_decimal ENDP

END