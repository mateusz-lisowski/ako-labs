.686
.XMM            ; !!! Use this directive to allow xmm !!!
.model flat

public _convert_int_to_float

.code

_convert_int_to_float PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push esi
    push edi

    ; Move function arguments to registers
    mov esi, [ebp + 8]              ; Address of the array of ints 
    mov edi, [ebp + 12]             ; Address of the array of floats

    cvtpi2ps xmm0, qword PTR [esi]  ; Convert all integer from 64 bits part of memory to floats

    movups [edi], xmm0              ; Move converted float to result array

    ; Restore registers state
    pop edi
    pop esi 

    ; Function epilog
    pop ebp                 ; Restore value of EBP from the stack
    ret                     ; Return from the function

_convert_int_to_float ENDP

END