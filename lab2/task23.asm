.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

public _main

.data

title_utf16     dw 'Z','n','a','k','i', 0

content_utf16   dw 'T','o',' ','j','e','s','t',' '
                dw 'p','i','e','s',' ',0E052H,' '           ; This code int utf-16 is dog face emoji
                dw 'i',' ','k','o','t',0D83DH,0DC08H, 0     ; This code int utf-16 is cat emoji

.code
_main PROC

    push 0                      ; MB_OK type of message box
    push OFFSET title_utf16     ; Address of the window title (encoding UTF-16)
    push OFFSET content_utf16   ; Address of the window content (encoding UTF-16)
    push 0                      ; NULL
    call _MessageBoxW@16

    ; Exit program
    push 0
    call _ExitProcess@4

_main ENDP
END