.686
.model flat

extern _ExitProcess@4 : PROC

exten read_dec_num_to_eax : PROC
exten print_to_many_chikens : PROC
exten print_to_little_chikens : PROC
exten print_congrats : PROC


public _main

.code

_main PROC

    mov ebx, 10                 ; Set the start number of the chickens

    guess:
        
        call read_dec_num_to_eax    ; Read user guess
        cmp eax, ebx
        ja too_many_chickens
        jb too_little_chickens
        jmp found

    too_many_chickens:
        call print_to_many_chikens
        jmp guess

    too_little_chickens:
        call print_to_little_chikens
        jmp guess

    found:
        call print_congrats

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP
END