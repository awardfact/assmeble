%include "io64.inc"

section .text
global CMAIN
CMAIN:


    GET_DEC 2, a

    mov ax , [a]

    mov bh, 3

    div bh
    PRINT_DEC 2,a
    NEWLINE
    CMP ah, 0
    JE basu
    JMP notbasu
    basu:

    PRINT_STRING basuString
    JMP basuend
    notbasu:

    PRINT_STRING notbasuString
    basuend:
    ;write your code here
    xor rax, rax
    ret
    
section .data
basuString db 'basu ',0x00
notbasuString db 'not basu.',0x00
section .bss
a resw 1