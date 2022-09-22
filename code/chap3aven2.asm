%include "io64.inc"

section .text
global CMAIN
CMAIN:
    
    
    ;EBX초기화하고 AX, DX에 값을 넣어준다
    mov EBX,0x00000000
    
    mov AX, 0x1234
    mov DX, 0x5678
    
    
    ; tmp에 1234 tmp2에 5678로 넣어야할거같았는데 리틀엔디언이라 그런지 앞 메모리에 큰 숫자 뒷 메모리에 작은숫자를 넣어야 원하는 대로 출력
    mov [tmp], DX
    mov [tmp + 2], AX
    PRINT_HEX 2, [tmp + 2]
    PRINT_HEX 2, [tmp]

    mov EBX, EDX
    ;PRINT_HEX 2,AX
    NEWLINE
    ;PRINT_HEX 2,DX
    NEWLINE댐
    ;tmp 메모리 값을 EBX에 넣으면 ax와 DX가 합쳐진 값이 출력된다
    mov EBX, [tmp]
    
    
    
    PRINT_HEX 4, EBX
    ;write your code here
    xor rax, rax
    ret
    
section .bss
tmp resw 2 