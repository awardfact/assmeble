%include "io64.inc"

section .text
global CMAIN
CMAIN:

    mov ax, 0
    
    PRINT_STRING msg
    NEWLINE
    ;write your code here
    xor rax, rax
    ret
section .data
msg db 'haha',0