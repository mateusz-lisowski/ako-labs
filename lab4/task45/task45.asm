public sum_seven

.code

sum_seven PROC

    push rbp
    mov rbp, rsp

    mov rax, rcx

    add rax, rdx
    add rax, r9
    add rax, r8
    add rax, [rbp + 48]
    add rax, [rbp + 56]
    add rax, [rbp + 64]

    pop rbp
    ret

sum_seven ENDP
END