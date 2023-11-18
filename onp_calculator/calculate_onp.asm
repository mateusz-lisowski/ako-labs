.686
.model flat

extern __write : PROC

.data

.code

; Function for checking if given character is an ONP operand
is_operand PROC

    ; Standard function prolog
    push ebp            ; Save EBP on stack
    mov ebp, esp        ; Move current value of ESP to EPB

    mov eax, [ebp + 8]  ; Move address of user formula to EBP

    cmp eax, '+'        ; Check if char is a plus sign
    je operand          ; If yes it is an ONP operand

    cmp eax, '-'        ; Check if char is a minus sign
    je operand          ; If yes it is an ONP operand

    cmp eax, '*'        ; Check if char is a multiplication sign
    je operand          ; If yes it is an ONP operand

    cmp eax, '/'        ; Check if char is a division sign
    je operand          ; If yes it is an ONP operand

    ; If neiter of above is true, then sign is not an ONP operand
    mov eax, 0          ; If character is not an opernad, then return false (in asm equivalent to returning false is setting EAX to 0)
    jmp finish          ; Finish function execution

    operand:
        mov eax, 1      ; If character is an opernad, then return true (in asm equivalent to returning true is setting EAX to 1)

    finish:

    ; Standard function epilog
    pop ebp             ; Restore EBP from stack
    ret                 ; Retutn to current value of ESP

is_operand ENDP

; Function for calcultating ONP
calculate_onp PROC
    
    ; Standard function prolog
    push ebp            ; Save EBP on stack
    mov ebp, esp        ; Move current value of ESP to EPB

    sub esp, 8          ; Reserve memory for local variables

    ; Save used registers on stack
    push ebx
    push esi

    mov ebx, [ebp + 8]  ; Move address of user formula to EBP
    mov esi, 0

    calculate:

        mov eax, [ebx + esi]
        inc esi
        mov edx, eax

        push eax
        call is_operand
        add esp, 4

        cmp eax, 1
        je char_is_operand

        push edx
        jmp calculate

    char_is_operand:

        pop ecx
        pop edx
        mov eax, 0
        add eax, ecx
        add eax, edx

    ; Restore registers state
    pop esi
    pop ebx

    ; Standard function epilog
    pop ebp             ; Restore EBP from stack
    ret                 ; Return to current value of ESP

calculate_onp ENDP
END