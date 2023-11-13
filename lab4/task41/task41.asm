.686
.model flat

public _find_max

.code

_find_max PROC

    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]  ; Max
    
    mov esi, 12
    mov ecx, 3

    lp:
        
        mov ebx, [ebp + esi]
        add esi, 4

        cmp ebx, eax
        jg write_current
        jmp next

    write_current:
        mov eax, ebx
    
    next:
        dec ecx
        cmp ecx, 0
        jne lp

    pop ebp
    ret

_find_max ENDP

END