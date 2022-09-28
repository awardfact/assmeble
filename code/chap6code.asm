%include "io.inc"

section .text
global CMAIN
extern _inimylib
extern  _getnumber
CMAIN:

    mov ecx, 0
    lotto:
    call _getnumber
    mov [tmp] ,eax
    call checksame
    cmp eax ,1
    jne notsame
    jmp lotto
    notsame:
    mov eax, [tmp]
    mov [data + ecx * 4] , eax
    inc ecx 
    cmp ecx , 6
    jl lotto  
    
    ;write your code here
    xor eax, eax
    ret
    

checksame:
    push rbp
    mov edx , 6
    cmp  eax , data[ecx * 4]
    je eq1
    
    dec edx
    cmp edx, 0
    jg checksame
    
    jmp  checksame

    mov eax , 0
    pop rbp
    ret
    eq1:
    mov eax , 1
    pop rbp 
    ret
    
   
showdata:

push rbp
mov ecx , 0
showd:


pop rbp
ret
                
section .bss
data resd 6
tmp resd 1