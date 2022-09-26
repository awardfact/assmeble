%include "io64.inc"

section .text
global CMAIN
CMAIN:

    ;임의의 값을 2바이트로 선언한 변수에 넣는다 
    GET_DEC 2, input_data
    PRINT_DEC 2, input_data
    NEWLINE
    
    
    ;16번 반복하기 위해 cx에 16을 넣어준다
    mov cx , 16
    ;bx에는 선언한 변수를 넣어준다 
    mov bx, [input_data]

    ;ax에 bx값을 넣고 ax에 SHR15를 해주면 가장 왼쪽 비트가 출력되는데 bx를 왼쪽으로 1비트씩 이동시키면서 반복하면 2진수값이 출력된다
    L1:
    mov ax, bx

    SHR ax, 15
    PRINT_DEC 2, ax

    SHL bx, 1

    dec cx
    CMP cx, 0
    JG L1
    
    ;write your code here
    xor rax, rax
    ret
    
section .bss
input_data resw 1