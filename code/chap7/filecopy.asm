
extern CreateFileA
extern CloseHandle
extern WriteFile
extern ReadFile
extern MessageBoxA

BLOCK equ 10

section .text
global start
start:

    push msg1
    
    call MyMsgBox
    
    
    call MyOpenFile
    
    call MyCopyFile


    call MyCloseHandle
    
    push msg2
    
    call MyMsgBox
    

    ;write your code here
    xor eax, eax
    ret
    
    
    
MyCopyFile:



copy_start:
    push 0
    push dwNumberOfBytes
    push BLOCK
    push Buffer
    mov eax, [hrFile]
    push eax
    call ReadFile
    
    mov eax, [dwNumberOfBytes]
    cmp eax , 0
    je mycopyfile_end
    
    push 0
    push dwBytesWritten
    mov eax, [dwNumberOfBytes]
    push eax
    push Buffer
    mov eax,[hwFile] 
    push eax
    call WriteFile
    jmp copy_start
    
mycopyfile_end:
ret
    
    

ret

MyOpenFile:
    push 0
    push 0x80
    push 0x03
    push 0
    push 0x00
    push 0x01
    push rfileName
    call CreateFileA
    mov [hrFile] , eax
    
    
    push 0
    push 0x80
    push 0x01
    push 0
    push 0x00
    push 0x02
    push wfileName
    call CreateFileA
    mov [hwFile], eax


ret


MyCloseHandle:
    mov eax, [hwFile]
    push eax
    call CloseHandle
    
    mov eax, [hrFile]
    push eax
    call CloseHandle
    

ret

MyMsgBox:
    push ebp
    mov ebp , esp
    push 0x40
    push caption
    push dword [ebp+4+4]
    push 0x00
    call MessageBoxA
    
    
    pop ebp
    ret 4




section .data
rfileName db 'myfile2.txt',0
wfileName db 'myfile3.txt',0
caption db 'clcc message',0
msg1 db 'start copy',0
msg2 db 'end copy',0

section .bss
hrFile resd 1
hwFile resd 1
dwBytesWritten resd 1
dwNumberOfBytes resd 1
Buffer resb BLOCK +1