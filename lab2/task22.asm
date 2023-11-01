.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC

public _main

.data

title_win1250 db 'Tekst w standardzie Windows 1250', 0
content_win1250 db 'Ka',0BFH,'dy znak zajmuje 8 bit',0F3H,'w', 0

title_utf16     dw 'T','e','k','s','t',' ','w',' '
                dw 'f','o','r','m','a','c','i','e',' '
                dw 'U','T','F','-','1','6', 0

content_utf16   dw 'K','a',017CH,'d','y',' ','z','n','a','k',' '
                dw 'z','a','j','m','u','j','e',' '
                dw '1','6',' ','b','i','t',0F3H,'w', 0

.code
_main PROC

    push 0                      ; MB_OK type of message box
    push OFFSET title_win1250   ; Address of the window title (encoding Win1250)
    push OFFSET content_win1250 ; Address of the window content (encoding Win1250)
    push 0                      ; NULL
    call _MessageBoxA@16

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