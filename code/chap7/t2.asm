
extern MessageBoxA

section .text

global start
start:
    ;write your code here
    
    push 0x40
    push caption
    push msg
    push 0x00
    call MessageBoxA
    mov [reval] , eax
    
    
    xor eax, eax
    ret
    
section .data
caption db 'myapp',0
msg db 'hello, world',0
    
section .bss
reval resd 1