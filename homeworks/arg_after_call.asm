.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.code

; Test function to try accessing argument, which were given after calling
foo PROC

    ; After calling addres of the return is stored in the ESP
    ; So now, value of the ESP is the addres of `dd 4` instruction

    mov eax, [esp]      ; !!! Discuss with expert !!!
    mov eax, [eax]      ; !!! Discuss with expert !!!
    
    add esp, 4          ; Add size of 4 bytes to ESP to skip `dd 4` instruction and go to the next one                

    ret                 ; Return to place where ESP points to

foo ENDP

_main PROC
    
    ; Call function and give it argument after calling
    call foo            ; Call function
    dd 4                ; Provide argument

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP

END