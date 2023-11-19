; Example function with arguments
; Change 'some_function' to your function name
; To access arguments use [ebx + 8] for first and add 4 for next ones
; If call to this function followed C standard [ebx + 8] should be the first argument 
some_function PROC

    ; Standard function prolog
    push ebp            ; Save EBP on stack
    mov ebp, esp        ; Move current value of ESP to EPB

    ; Standard function epilog
    pop ebp             ; Restore EBP from stack
    ret                 ; Return to current value of ESP

some_function ENDP