.686
.XMM            ; !!! Use this directive to allow xmm !!!
.model flat

public _add_sub_one

.data

array_mask dd 1.0, 1.0, 1.0, 1.0

.code

_add_sub_one PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push ebx

    ; Move function arguments to registers
    mov ebx, [ebp + 8]              ; Address of the array of floats

    movups xmm0, [ebx]              ; Move 4 floats from array to XMM0 register
    movups xmm1, array_mask         ; Move 4 mask floats ro XMM1 register

    addsubps xmm0, xmm1             ; Perform parallel adding and subtracting of the floats from mask 

    movups [ebx], xmm0              ; Save result to under pointer from function 

    ; Restore registers state
    pop ebx

    ; Function epilog
    pop ebp                 ; Restore value of EBP from the stack
    ret                     ; Return from the function

_add_sub_one ENDP

END