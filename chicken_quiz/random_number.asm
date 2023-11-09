.686
.model flat

.code

; Generates random number (always divisible by 4 :/ unfortunately) from 0 to given argument
generate_random_number PROC

    push ebp            ; Save the base pointer
    mov ebp, esp        ; Set up a new base pointer
    
    ; Save any registers that you plan to modify
    push ebx            
    push edx

    ; Retrieve the argument from the stack
    mov ebx, [ebp+8]    ; Argument was the first pushed (8 bytes above the base pointer)
    mov eax, esp        ; Choose some random number (ESP is different every time, but always divides by 4)

    xor edx, edx        ; Zero EDX before the division
    div ebx             ; Divide by argument to ger the rest (modulo operation)

    mov eax, edx        ; Move result to EAX

    ; Restore registers and clean up the stack
    pop edx
    pop ebx
    pop ebp

    ret

generate_random_number ENDP

END