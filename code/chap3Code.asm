%include "io64.inc"

section .text
global CMAIN
CMAIN:
    GET_DEC 2 , a


    GET_DEC 2 , b


    GET_DEC 2, c

    ; 먼저 a랑 b비교해서 a가 크면 awin b가 크면 bwin으로 jmp
    mov ax ,[a]
    mov bx , [b]
    CMP ax, bx
    JG awin   

    
    JMP bwin
    ;a가 크면 max에 a min에 b  , b가크면 반대
    awin: 
        mov [max] , ax
        mov [min] , bx
        JMP abEnd
    bwin: 
        mov [max] , bx
        mov [min] , ax
    abEnd:
    ; max와 c를 비교해서 max가 크면maxwin c가크면 cwin으로 이동
    mov ax, [max]
    mov bx, [c]
    CMP ax , bx
    JG maxwin
    JMP cwin
    ; min과 c를 비교해서 min이 크면 minwin , c가 크면 mcwin으로 이동 다 끝나면 compareend로 이동
    maxwin:
        mov ax , [min]
        mov bx,[c]
        CMP ax, bx
        JG minwin
        JMP mcwin
        minwin:
            mov [min] , bx
        mcwin:
    JMP compareEnd
    ; c가 크면 max만 c로 변경 
    cwin:
        mov [max] , bx
    ;write your code here
    compareEnd:
    ; min과 max를출력, 곱하기에 사용될 EAX,EDX초기화 시켜주고 AX,CX에 값을 넣어서 곱하기 실행 , EDX를 왼쪽으로 옮기고 OR연산실행해서 곱하기 값 넣고 출력
    PRINT_DEC 2, min
    NEWLINE
    PRINT_DEC 2, max
    NEWLINE
    mov EAX, 0x00000000
    mov EDX, 0x00000000
    mov AX, [max]
    mov CX , [min]
    MUL CX

    shl EDX ,16
    OR EDX , EAX
    mov [total], EDX
    

    PRINT_DEC 4, total
    NEWLINE
    
    xor rax, rax
    ret


    
section .bss
a resw 1
b resw 1
c resw 1
min resw 1
max resw 1
total resd 1