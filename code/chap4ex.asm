%include "io64.inc"

section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    mov eax , a
    mov ebx , b
    
    mov edx , 0
    mov ecx , 3
L1: 
    mov eax, [a + edx * 2]
    mov [b + edx *2] , eax
    inc edx
    loop L1
   
    mov edx, 0
L2:
    PRINT_HEX 2, a+edx*2
    NEWLINE
    inc edx
    cmp edx , 3
    jl L2
    
    
    
    
    ;write your code here
    xor rax, rax
    ret
    
section .data
a dw 0x1234, 0x5678, 10
section .bss
b resw 3