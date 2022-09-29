
extern CreateFileA
extern CloseHandle

section .text
global start
start:

    push 0
    push 0x80
    push 0x01
    push 0
    push 0x00
    push 0x02
    push fileName
    call CreateFileA
    mov [hFile], eax
    
    
    cmp eax, -1
    jne start_end
    


    
start_end:
    mov eax, [hFile]
    push eax
    call CloseHandle
    
    xor eax, eax
    ret
section .data
fileName db 'myfile.txt',0
section .bss
hFile resd 1