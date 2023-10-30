.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.data

.code
_main PROC

    ; End program
    push 0
    call _ExitProcess@4

_main ENDP
END