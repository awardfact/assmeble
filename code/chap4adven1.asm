%include "io64.inc"

section .text
global CMAIN
CMAIN:

    ;임의의 값을 2바이트로 선언한 변수에 넣는다 
    GET_DEC 2, input_data
    PRINT_DEC 2, input_data
    NEWLINE
    
    mov ecx , 8

    L1:
    mov ax, input_data   
    
    
    ;write your code here
    xor rax, rax
    ret
    
section .bss
input_data resw 1