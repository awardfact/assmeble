section .text
global _main
_main : 
    mov ax , 1
    mov bx, 2
    add ax, bx
    mov [my],ax
    
    ret
    
section .bss
    my resw 1