.686
.model flat

public _inverse

.code

_inverse PROC

    push ebp
    mov ebp, esp

    push ebx

    mov ebx, [ebp + 8]  ; Argument
    
    mov eax, [ebx]
    neg eax
    mov [ebx], eax

    pop ebx
    pop ebp
    ret

_inverse ENDP

END