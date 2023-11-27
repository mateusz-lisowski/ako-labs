.686
.XMM            ; !!! Use this directive to allow xmm !!!
.model flat

public _sum_in_parallel

.code

; Function for summing two char arrays in parallel
_sum_in_parallel PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push ebx
    push esi
    push edi

    ; Move function arguments to registers
    mov esi, [ebp + 8]      ; Address of the first array to sum 
    mov edi, [ebp + 12]     ; Address of the second array to sum
    mov ebx, [ebp + 16]     ; Address of the result array

    movups xmm0, [esi]      ; Load first 4 foats from array a to XMM0 register
    movups xmm1, [edi]      ; Load first 4 foats from array b to XMM1 register

    paddsb xmm0, xmm1       ; Add four numbers at the same time

    movups [ebx], xmm0      ; Save results in memory

    ; Restore registers state
    pop edi
    pop esi
    pop ebx

    ; Function epilog
    pop ebp                 ; Restore value of EBP from the stack
    ret                     ; Return from the function

_sum_in_parallel ENDP


END