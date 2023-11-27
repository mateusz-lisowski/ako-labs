.686
.model flat

public _func

CON_LENGTH equ 20

.code

; Function to calculate exponent of x
calculate_exp PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Move function arguments to registers
    mov ecx, [ebp + 12]      ; Exponent of the result

    fld dword PTR [ebp + 8]     ; Load value to raise to the top of the stack

    ; Multiply top of the stack ECX - 1 times
    lp:

        ; Check if loop should be broken
        dec ecx         ; Decrease loop counter
        cmp ecx, 0      ; Check if loop ends
        je finish       ; If yes break

        ; Calculate number pointed by EBP squaraed
        fmul dword PTR [ebp + 8]    ; Multiply by itself and store the result on the top of the stack
        
        jmp lp          ; Countinue looping

    finish:

    ; Function epilog
    pop ebp
    ret

calculate_exp ENDP

; Function for calculating factorial of some number
calculate_factorial PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push ebx

    ; Move function arguments to registers
    mov ecx, [ebp + 8]      ; Number to find factorial for

    ; Reset needed registers
    mov ebx, 1              ; Set EBX to first number to multiply
    mov eax, 1              ; Set EAX to number neutral for multipling
    xor edx, edx            ; Reset EDX

    ; Calculate factorial
    lp:

        mul ebx             ; Multiply by EBX
        inc ebx             ; Increment EBX to next value

        dec ecx         ; Decrease loop counter
        cmp ecx, 0      ; Check if loop ends
        jne lp          ; If not continue looping


    ; Restore registers state    
    pop ebx

    ; Function epilog
    pop ebp
    ret

calculate_factorial ENDP

_func PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    mov ecx, CON_LENGTH     ; Move length of conjunction to ECX

    lp:

        push [ebp + 8]      ; Argument 

    ; Function epilog
    pop ebp
    ret

_func ENDP

END