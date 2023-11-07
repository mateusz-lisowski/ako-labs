.686
.model flat

.code

generate_random_number_to_eax_from_eax PROC

    ; Save registers state
    push ebx 
    push ecx 
    push edx
    push esi 
    push edi
    push ebp

    mov ebx, eax
    mov eax, esp

    xor edx, edx
    div ebx

    mov eax, edx

    ; Restore registers state
    pop ebp 
    pop edi 
    pop esi 
    pop edx 
    pop ecx 
    pop ebx

    ret
generate_random_number_to_eax_from_eax ENDP

END