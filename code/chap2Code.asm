%include "io64.inc"

section .text
global CMAIN
CMAIN:
    GET_DEC 1 , a
    PRINT_DEC 1, a
    NEWLINE
    GET_DEC 1 , b
    PRINT_DEC 1 , b
    NEWLINE
   
    mov al , [a]
    mov bl , [b] 
    add al, bl
    mov [plusResult] , al
    
    mov al , [a]
    mov bl , [b]
    sub al , bl 
    mov [minusResult] , al
    
    mov al, [a]
    mov bl, [b]
    mul bl
    mov [xresult] , ax
    
    
    mov ax , 0
    mov al , [a]
    mov bl , [b]
    div bl
    mov [nresult] , al
    mov [nnamoji] , ah
    
    
    PRINT_DEC 1, plusResult
    NEWLINE
    PRINT_DEC 1, minusResult
    NEWLINE
    PRINT_DEC 2, xresult
    NEWLINE
    PRINT_DEC 1, nresult
    NEWLINE
    PRINT_DEC 1 , nnamoji
    NEWLINE
    
    
    
    
    

    ;write your code here
    xor rax, rax
    ret
    
    
section .bss
a resb 1
b resb 1
plusResult resb 1
minusResult resb 1
xresult resw 2 
nresult resb 1
nnamoji resb 1
