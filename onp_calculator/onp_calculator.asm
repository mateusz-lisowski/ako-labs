.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC

public _main

MAX_FORMULA_LENGTH equ 256
STDIN equ 0
STDOUT equ 1

.data

; Tooltip information
info db 'Kalkulator odwr',0A2H,'conej notacji polskiej', 10
     db 'Wpisz poprawny ci',0A5H,'g znak',0A2H,'w oznaczj'
     db 0A5H,'cy dzia',088H,'anie w ONP', 10, 0
     
i_len equ $ - info                      ; Caclulate info length

propmpt db '->', 0                      ; Visual indicator to enter prompt
p_len equ $ - propmpt                   ; Calculate propmpt length

formula db MAX_FORMULA_LENGTH dup (?)   ; Allocate place in memory for user input

.code

_main PROC

    push i_len              ; Length of the info string 
    push OFFSET info        ; Pointer to info string
    push STDOUT             ; STDOUT as a place to write
    call __write            ; Call write function
    add esp, 12             ; Deallocate memory for three arguments

    push p_len              ; Length of the prompt string 
    push OFFSET propmpt     ; Pointer to prompt string
    push STDOUT             ; STDOUT as a place to write
    call __write            ; Call write function
    add esp, 12             ; Deallocate memory for three arguments


    ; End program
    push 0
    call _ExitProcess@4

_main ENDP

END