.686
.model flat

extern __write : PROC

.data

.code

calculate_onp PROC
    push ebp
    mov ebp, esp

    push ebx
    

    mov ebx, [ebp + 8] 

    push 255
    push ebx
    push 1
    call __write
    add esp, 12

    pop ebx

    pop ebp
    ret
calculate_onp ENDP
END