%include "io64.inc"

section .text
global CMAIN
; 프로시저를 이용해서 입력한 숫자의 팩토리얼 값을 구하는 프로그램 
CMAIN:

    ;임의의 값을 받는다
    GET_DEC 2, input_data
    PRINT_DEC 2, input_data
    NEWLINE
    ;값들 초기화 하고 bx에는 입력받은 값 ax에도 입력받은 값을 넣는다 
    mov edx , 0x00000000
    mov eax , 0x00000000
    mov bx, [input_data]
    mov ax , [input_data]
    ;FACT프로시저 호출 
    call FACT
    
    
    ; 프로시저 결과값을 출력 
    PRINT_DEC 4, eax
    NEWLINE
    ;write your code here
    xor rax, rax
    ret
    
    
FACT:


    push rbp
    ; bx가 1보다 크면 A 작으면 B로 이동 
    CMP bx, 1
    JG FACTA
    jmp FACTB
    ; bx가 1보다 큰 경우 bx를 -1한 후 ax와 곱한 후 다시 프로시저 호출 
    FACTA:
    dec bx
    mul bx

    shl edx , 16
    OR eax, edx
    pop rbp 
    jmp FACT
    
    ;bx가 1보다 작은경우 프로시저 종료 
    FACTB:
    pop rbp
    ret
    
section .bss
input_data resw 1