.686
.model flat

public _find_char

.code

_find_char PROC

    push ebp ; zapisanie zawartości EBP na stosie
    mov ebp, esp ; kopiowanie zawartości ESP do EBP

    push ebx
    push esi

    mov edx, [ebp + 8] ; Adres tablicy
    mov ecx, [ebp + 16] ; Wskaźnik do adresu znalezionego elementu
    
    mov esi, 0
    mov edi, 0

    lp:
        mov ax, [edx + 2 * esi]
        movzx eax, ax
        inc esi

        cmp eax, [ebp + 12]
        jne next

        inc edi

        cmp edi, 1
        jne next
        
        mov [ecx], edx
        add [ecx], esi
        add [ecx], esi

    next:
        cmp eax, 0
        jne lp
    
    finish:
        mov eax, edi

    cmp edi, 0
    jne end_func

    mov [ecx], edi

    end_func:
    pop esi
    pop ebx

    pop ebp
    ret ; powrót do programu głównego

_find_char ENDP

 END
