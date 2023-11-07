.686
.model flat

extern _ExitProcess@4 : PROC

; Function for generating random number
extern generate_random_number_to_eax_from_eax : PROC

; Custom function for reding user input
extern read_dec_num_to_eax : PROC        

; Custom functions for showing user proper communicate
extern print_to_many_chickens : PROC      
extern print_to_few_chickens : PROC
extern print_congrats : PROC

public _main

.code

_main PROC

    mov eax, 100 
    call generate_random_number_to_eax_from_eax
    add esp, 4

    mov ebx, eax                         ; Set the start number of the chickens

    ; Main loop of the program
    guess:
        
        call read_dec_num_to_eax        ; Read user guess and store its value to EAX
        cmp eax, ebx                    ; Check if value is the same as the given chickens number
        ja too_many_chickens            ; Jump if guess was bigger than the number of chickens
        jb too_little_chickens          ; Jump if guess was smaller than the number of chickens
        jmp found                       ; Else number of chicken was found

    ; Guess was bigger than the number of chickens
    too_many_chickens:
        call print_to_many_chickens     ; Print proper communicate
        jmp guess                       ; Jump to ask onece again

    ; Guess was smaller than the number of chickens
    too_little_chickens:
        call print_to_few_chickens      ; Print proper communicate
        jmp guess                       ; Jump to ask onece again 

    ; Guessed properly
    found:
        call print_congrats             ; Print congratulations communicate

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP
END