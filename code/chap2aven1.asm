%include "io64.inc"

section .text
global CMAIN
CMAIN:

    GET_DEC 1 , dl
    PRINT_DEC 1, dl
    NEWLINE
    GET_DEC 1 , cl
    PRINT_DEC 1 , cl
    NEWLINE
   
    mov al , dl
    mov bl , CL
    add al, bl
    
    PRINT_DEC 1, al
    NEWLINE

    
    mov al , dl
    mov bl , CL
    sub al , bl 
    PRINT_DEC 1, al
    NEWLINE

    
    mov al, dl
    mov bl, CL
    mul bl
    PRINT_DEC 2, ax
    NEWLINE
    
    mov ax , 0
    mov al , BH
    mov bl , CL
    div bl
    
    
    mov bl , ah 
    PRINT_DEC 1, al
    NEWLINE
    PRINT_DEC 1, bl
    NEWLINE

    
   

    ;write your code here
    xor rax, rax
    ret

