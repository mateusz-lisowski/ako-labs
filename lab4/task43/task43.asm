.686
.model flat

public _decrement

.code

_decrement PROC

    push ebp
    mov ebp, esp

    push ebx

    mov ebx, [ebp + 8]  ; Argument

    mov edx, [ebx]
    mov eax, [edx]
    
    dec eax

    mov [edx], eax
    mov [ebx], edx

    pop ebx
    pop ebp
    ret

_decrement ENDP

END