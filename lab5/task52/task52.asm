.686
.model flat

public _func

CON_LENGTH equ 3        ; Number of conjuction values to be calculated

.data

eax_val dd ?            ; Place to store value of EAX register
current_sum dd 0        ; Place to store current value of the conjuction sum

.code

; Function to calculate exponent of x
calculate_exp PROC

    ; Function prolog
    push ebp                    ; Save value of EBP on the stack
    mov ebp, esp                ; Move value of ESP to EBP

    ; Move function arguments to registers
    mov ecx, [ebp + 12]         ; Exponent of the result

    fld dword PTR [ebp + 8]    ; Load value to raise to the top of the stack

    ; Multiply top of the stack ECX - 1 times
    lp:

        ; Check if loop should be broken
        dec ecx         ; Decrease loop counter
        cmp ecx, 0      ; Check if loop ends
        je finish       ; If yes break

        ; Calculate number pointed by EBP squaraed
        fmul dword PTR [ebp + 8]    ; Multiply by itself and store the result on the top of the stack
        
        jmp lp          ; Countinue looping

    finish:

    ; Function epilog
    pop ebp
    ret

calculate_exp ENDP

; Function for calculating factorial of some number
calculate_factorial PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push ebx

    ; Move function arguments to registers
    mov ecx, [ebp + 8]      ; Number to find factorial for

    ; Reset needed registers
    mov ebx, 1              ; Set EBX to first number to multiply
    mov eax, 1              ; Set EAX to number neutral for multipling
    xor edx, edx            ; Reset EDX

    ; Calculate factorial
    lp:

        mul ebx             ; Multiply by EBX
        inc ebx             ; Increment EBX to next value

        dec ecx         ; Decrease loop counter
        cmp ecx, 0      ; Check if loop ends
        jne lp          ; If not continue looping


    ; Restore registers state    
    pop ebx

    ; Function epilog
    pop ebp
    ret

calculate_factorial ENDP

_func PROC

    ; Function prolog
    push ebp                ; Save value of EBP on the stack
    mov ebp, esp            ; Move value of ESP to EBP

    ; Save used registers state
    push ebx

    ; Set registers used by function
    mov esi, CON_LENGTH     ; Move length of conjunction to ESI (ESI has to be preserved by subprograms)
    mov ebx, 1              ; First we raise to the power of 1

    lp:

        ; Calculate x to power of EBX
        push ebx                        ; Argument is an exponent to raise x to
        push [ebp + 8]                  ; Argument is same as for func (x)
        call calculate_exp              ; Call custom calculate_exp function
        add esp, 8                      ; Deallocate arguments from stack

        ; Result is on the top of the coprocessor stack

        ; Calculate factorial of EBX
        push ebx                        ; Argument for calculate_factorial is current state of EBX     
        call calculate_factorial        ; Call custom calculate_factorial function
        add esp, 4                      ; Deallocate arguments from stack

        ; Result is in EAX

        mov dword PTR eax_val, eax    ; Save value returned from function to EAX

        ; Calculate current conjunction value
        fidiv dword PTR eax_val        ; Divide by value stored under eax_val label
        fadd dword PTR current_sum    ; Add result of division to the current sum
        fstp dword PTR current_sum    ; Replece old sum with the new sum

        inc ebx         ; Increment EBX  
        dec esi         ; Decrease loop counter

        cmp esi, 0      ; Check if loop ends
        jne lp          ; If not continue looping

    ; Add first conjunction value
    fld1                            ; Load 1 to the top of the coprocessor stack
    fld dword PTR current_sum       ; Load current_sum to the stack
    faddp st(1), st(0)              ; Add two top numbers from the stack and place result on the top

    ; Restore registers state    
    pop ebx

    ; Function epilog
    pop ebp
    ret

_func ENDP

END