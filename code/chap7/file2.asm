
extern CreateFileA
extern CloseHandle
extern WriteFile

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
    mov [fileHandle], eax
    
    
    cmp eax, -1
    jne start_end
    mov [retval],eax
    


    
start_end:

    push 0
    push dwBytesWritten
    push msg_len
    push msg
    mov eax, [fileHandle]
    push eax 
    call WriteFile



    mov eax, [fileHandle]
    push eax
    call CloseHandle
    
    xor eax, eax
    ret
section .data
fileName db 'myfile.txt',0
msg db 'file input msg', 0
msg_len equ $ - msg
section .bss
fileHandle resd 1
retval resd 1
dwBytesWritten resd 1

