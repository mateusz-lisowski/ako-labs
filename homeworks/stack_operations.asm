.686
.model flat

extern __write : PROC
extern _ExitProcess@4 : PROC

public _main

.code

foo PROC
    
    push ebp
    mov ebp, esp

    sub esp, 4

    mov eax, [ebp + 20]
    mov ebx, [ebp + 16]
    mov ecx, [ebp + 12]
    mov edx, [ebp + 8]

    mov [ebp - 4], al
    mov [ebp - 3], bl
    mov [ebp - 2], cl
    mov [ebp - 1], dl

    lea ebx, [ebp - 4]

    push 4
    push ebx
    push 1
    call __write
    add esp, 12
    
    add esp, 4

    pop ebp
    ret

foo ENDP

_main PROC

    push 'a'
    push 'n'
    push 'i'
    push 'a'
    call foo
    add esp, 16

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP

END