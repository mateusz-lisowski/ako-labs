.686
.model flat

public _harmonic_avg

.data

current_sum dd 0            ; Place in memory to store result of calculation
array_size dd ?             ; Place in memory to store to store size of array

.code

; Function calculating harmonic average of the given array
_harmonic_avg PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push ebx
    push esi

    ; Move function arguments to registers
    mov ebx, [ebp + 8]              ; Address of the array with floats
    mov ecx, [ebp + 12]             ; Number of floats in the array
    
    mov dword PTR array_size, ecx   ; Save number of floats in the array in memory

    mov esi, 0                      ; Reset pointer to the array with floats

    ; Calculate sum of the reverse of the numbers
    lp:

        fld1                                ; Load constant 1.0 to the top of the stack    
        fdiv dword PTR [ebx + 4 * esi]      ; Divide by value pointed by ESI and push result to the top of the coprocessor stack
        fadd dword PTR current_sum          ; Add result of division to the current sum
        fstp dword PTR current_sum          ; Replece old sum with the new sum

        inc esi         ; Increment pointer  
        dec ecx         ; Decrease loop counter

        cmp ecx, 0      ; Check if loop ends
        jne lp          ; If not continue looping

    ; Calculate harmonic average

    fild dword PTR array_size          ; Load number of elements to coprocessor 
    fdiv dword PTR current_sum         ; Calculate result and return it (it has to be leaved on the top of the coprocessor stack)
    
    ; Restore registers state
    pop esi
    pop ebx

    ; Function epilog
    pop ebp
    ret

_harmonic_avg ENDP

END