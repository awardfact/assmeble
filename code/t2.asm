
global myadd
global mysub

section .text
myadd :
    mov ax , 3
    mov bx, 2
    add ax, bx
    ret
    
mysub:
    mov ax, 2
    mov bx, 3
    sub ax, bx
    ret
    
section .data
ok dw 0x1234