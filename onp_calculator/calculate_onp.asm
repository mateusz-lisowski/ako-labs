.686
.model flat

; Import custom functions
extern is_character_operand : PROC
extern change_to_decimal : PROC 

.data

current_char dd ?

.code

; Function for calcultating ONP
calculate_onp PROC
    
    ; Standard function prolog
    push ebp            ; Save EBP on stack
    mov ebp, esp        ; Move current value of ESP to EPB

    ; Save used registers on stack
    push ebx
    push esi

    mov ebx, [ebp + 8]  ; Move address of user formula to EBP
    mov esi, 0          ; Set formula pointer (ESI) to 0 

    calculate:

        mov eax, [ebx + esi]    ; Move character pointed by ESI to EAX
        inc esi                 ; Move ESI to next character

        mov [current_char], eax ; Save current character to memory

        ; Check if current character is space
        cmp eax, ' '            ; Check if current character is space
        jne continue            ; If not continue

        ; If current character is space skip it and go to the next character
        inc esi                 ; Move pointer to the next character
        jmp calculate           ; Return to calculate

        continue:

        ; Check if current character is an operand
        push eax                ; Push current character as an argument
        call is_operand         ; Call custom 
        add esp, 4              ; Remove function parameters from stack

        cmp eax, 1              ; If result is 1 then it is an operand        
        je char_is_operand      ; Jump to char_is_operand label

        ; If character is not an operand and it is not a space, then it is a number
        push ebx                ; Push addres of formula
        push esi                ; Push place to start converting
        call change_to_decimal  ; Call custom change_to_decimal function
        add esp, 4              ; Remove function parameters from stack

        add esi, edx            ; Add shift returned from change_to_decimal function to ESI    
        push eax                ; Push value returned from change_to_decimal function

        jmp calculate

    char_is_operand:

        ; Remove two last numbers from the stack
        pop ecx                 ; Pop last stack number to ecx
        pop edx                 ; Pop penultimate number to edx

        ; Check what kind of operand was provided
        mov eax, current_char   ; Move character stored in current_char to EAX

        cmp eax, '+'            ; Check if operand is '+' character
        je adding               ; If yes perform adding
        
        jmp calculate           ; If operand was not recognized go back to calculate
        
        ; If operand is '+' perform adding
        adding:
            
            mov eax, 0          ; Reset EAX
            add eax, ecx        ; Add first number to EAX
            add eax, edx        ; Add second number to EAX

            jmp calculate

    ; Restore registers state
    pop esi
    pop ebx

    ; Standard function epilog
    pop ebp             ; Restore EBP from stack
    ret                 ; Return to current value of ESP

calculate_onp ENDP

END