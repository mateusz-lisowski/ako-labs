.686
.model flat

public _func

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

_func PROC



_func ENDP

END