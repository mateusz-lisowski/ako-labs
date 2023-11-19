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

change_to_decimal PROC

    ; Standard function prolog
    push ebp            ; Save EBP on stack
    mov ebp, esp        ; Move current value of ESP to EPB

    ; Rerserve place for one local variable
    sub esp, 4

    ; 10 is our local variable
    mov [ebp - 1], 10

    ; Save used registers
    push ebx
    push esi

    ; Save pointer to formula in EBX
    mov ebx, [ebp + 8]

    ; Set global registers 
    mov esi, 0
    mov eax, 0

    convert:
        mov dl, [ebx + esi]         ; Read character to bl
        inc esi                     ; At the same time increment esi (for you not to forget to change it later)

        cmp dl, ' '                  ; Compare bl to space (enter char) 
        je finish                   ; If the char is entern, finish 

        sub dl, 30H                 ; Convert ASCII codes for numbers to the actual number
        movzx edx, dl               ; Expand the number to whole ebx

        mul [ebp - 1]               ; Multiply result by 10
        add eax, edx                ; Add newly find number to eax
        
        jmp convert

    finish:                         ; Finish function execution

    ; Standard function epilog
    pop ebp             ; Restore EBP from stack
    ret                 ; Return to current value of ESP

change_to_decimal ENDP


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

        push ebx
        call change_to_decimal
        add esp, 4

        push eax
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

print_eax PROC
    pusha                   ; Save registers state

    sub esp, 4
    mov [ebp - 1]

    push 8                  ; Set size of write to 8 bytes (32 bits)
    push [ebp - 1]          ; Set eax_val label as place to start writing
    push 1                  ; Set out to stdout 
    call __write            ; Call write function from C library

    add esp, 12             ; Reset write function parameters
    popa                    ; Restore registers state
    ret                     ; Go back to executing code
print_eax ENDP

END