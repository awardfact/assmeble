%include "io.inc"


LOTTO_COUNT equ 6
section .text
global CMAIN
; c언어 함수 가져옴
extern  _getnumber
extern _inimylib

CMAIN:

    call _inimylib
    
    
    ; ecx값을 초기화 해준다
    mov ecx, 0



    lotto:

    ; getnumber를 통해 랜덤 숫자를 가져오고 tmp에 그 숫자를 넣고 edx초기화 후 같은 숫자가 있는지 체크하는 함수를 호출 
    push ecx
    call _getnumber
    pop ecx
    mov [tmp] ,eax
    mov edx , 0

    call checksame

    ; 같은 숫자가 없으면notsame으로 아니면 다시 반복
    cmp eax ,1
    jne notsame

    jmp lotto
    notsame:

    ;같은 숫자가 없는경우 숫자를 data에 넣고 ecx를 inc해준다 
    mov eax, [tmp]
    mov [data + ecx * 4] , eax

    inc ecx 

    cmp ecx , 6
    jl lotto  
    ; 숫자 뽑기가 완료되면 숫자를 출력해주는 함수 호출 
    call showdata
   
   

    
    ;write your code here
    xor eax, eax
    ret
    

checksame:


    ; 같은 숫자가 있는지 체크 ecx는 0부터 시작하고 edx도 0부터 시작해서 ecx와 edx가 같으면 반복을 다 돈거여서 같으면 eq0으로 이동 
    cmp ecx, edx
    je eq0


    ; 얻은 숫자가 데이터에 있는값과 같으면 eq1로 이동 아니면 edx를 추가하고 반복
    cmp  eax , [data + edx * 4]
    je eq1
    
    inc edx

    jg checksame
    eq0:
    ; 같은 숫자가 없는경우 0을 리턴 

    mov eax , 0

    ret
    eq1:
    ;같은 숫자가 있는경우 1을 리턴 
    mov eax , 1

    ret

   
showdata:


mov ecx , 0
showd:
PRINT_DEC 4, [data+ecx * 4]
NEWLINE
inc ecx
cmp ecx, 6
JL showd

ret
                
                
section .data
tmp2 db "tmp",0
section .bss
data resd 6
tmp resd 1
tmp3 resd 1