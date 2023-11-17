.686
.model flat

extern _GetSystemTime@4 : PROC          ; Get function for checking system time from Win32 api

.data

time_struct dw 8 dup (?)                ; Reserve space for time structure returned by GetSystemTime function

.code

; Generates random number (always divisible by 4 :/ unfortunately) from 0 to given argument
generate_random_number PROC

    push ebp                            ; Save the base pointer
    mov ebp, esp                        ; Set up a new base pointer

    ; Save any registers that you plan to modify
    push ebx            

    ; Obtain current system time
    push offset time_struct             ; First argument is pointer to the memory 
    call _GetSystemTime@4               ; Call the GetSystemTime function

    ; Generate random number from time
    mov eax, dword PTR time_struct[12]  ; Move number of seconds from time_struct to EAX
    add eax, dword PTR time_struct[14]  ; Add number of milliseconds from time_struct to EAX

    ; Retrieve the argument from the stack
    mov ebx, [ebp+8]                    ; Argument was the first pushed (8 bytes above the base pointer)

    xor edx, edx                        ; Zero EDX before the division
    div ebx                             ; Divide by argument to ger the rest (modulo operation)

    mov eax, edx                        ; Move result to EAX

    ; Restore registers and clean up the stack
    pop ebx
    pop ebp

    ret

generate_random_number ENDP

END