.686
.model flat

.code

; Function for checking if given character is an ONP operand
is_character_operand PROC

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

is_character_operand ENDP

END