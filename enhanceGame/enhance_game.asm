%include "io.inc"

percnet1 equ 100
percnet2 equ 100
percnet3 equ 100
percnet4 equ 90
percnet5 equ 80
percnet6 equ 70
percnet7 equ 60
percnet8 equ 50
percnet9 equ 40
percnet10 equ 30
percnet11 equ 25
percnet12 equ 15
percnet13 equ 14
percnet14 equ 13
percnet15 equ 12

e_price1 equ 0
e_price2 equ 0
e_price3 equ 0
e_price4 equ 1
e_price5 equ 2
e_price6 equ 5
e_price7 equ 10
e_price8 equ 30
e_price9 equ 60
e_price10 equ 150
e_price11 equ 350
e_price12 equ 1500
e_price13 equ 15000
e_price14 equ 300000
e_price15 equ 4500000


s_price1 equ 0
s_price2 equ 1
s_price3 equ 2
s_price4 equ 3
s_price5 equ 5
s_price6 equ 10
s_price7 equ 30
s_price8 equ 90
s_price9 equ 350
s_price10 equ 1500
s_price11 equ 15000
s_price12 equ 300000
s_price13 equ 4500000
s_price14 equ 50000000
s_price15 equ 999999999

extern  _getnumber
section .text


; 상수 선언  

global CMAIN
extern  _getnumber


CMAIN:
    mov ebp, esp; for correct debugging


    mov ecx, 0
     
    mov [percent] ,dword 100
    mov [percent + 4] ,dword 100
    mov [percent + 8] ,dword 100
    mov [percent + 12] ,dword 90
    mov [percent + 16] ,dword 80
    mov [percent + 20] ,dword 70
    mov [percent + 24] ,dword 60    
    mov [percent + 28] ,dword 50
    mov [percent + 32] ,dword 40
    mov [percent + 36] ,dword 30
    mov [percent + 40] ,dword 25
    mov [percent +44] ,dword 15
    mov [percent + 48] ,dword 14
    mov [percent + 52] ,dword 13
    mov [percent + 56] ,dword 12

    
    
    mov [e_price] ,dword 0
    mov [e_price + 4] ,dword 0
    mov [e_price + 8] ,dword 0
    mov [e_price + 12] ,dword 1
    mov [e_price + 16] ,dword 2
    mov [e_price + 20] ,dword 5
    mov [e_price + 24] ,dword 10
    mov [e_price + 28] ,dword 30
    mov [e_price + 32] ,dword 60
    mov [e_price + 36] ,dword 150
    mov [e_price + 40] ,dword 350
    mov [e_price + 44] ,dword 1500
    mov [e_price + 48] ,dword 15000
    mov [e_price + 52] ,dword 300000
    mov [e_price + 56] ,dword 4500000
    

    
    mov [s_price] ,dword 0
    mov [s_price + 4] ,dword 1
    mov [s_price + 8] ,dword 2
    mov [s_price + 12] ,dword 3
    mov [s_price + 16] ,dword 5
    mov [s_price + 20] ,dword 10
    mov [s_price + 24] ,dword 30
    mov [s_price + 28] ,dword 90
    mov [s_price + 32] ,dword 350
    mov [s_price + 36] ,dword 1500
    mov [s_price + 40] ,dword 15000
    mov [s_price + 44] ,dword 300000
    mov [s_price + 48] ,dword 4500000
    mov [s_price + 52] ,dword 50000000
    mov [s_price + 56] ,dword 999999999

     
           
            ;  
    GAME:
    ;현재 보유 돈 출력
    
    PRINT_STRING msg__
    NEWLINE
    PRINT_STRING msg_1 
    PRINT_DEC 4, money 
    NEWLINE
    
    ;현재 강화 단계 출력
    
    PRINT_STRING msg_2 
    PRINT_DEC 4, c_enhance 
    NEWLINE
    
    ; 강화 확률과 강화 비용 출력 
    
    mov eax, [c_enhance]
    mov ebx , [percent + eax * 4]
    PRINT_STRING msg_4
    PRINT_DEC 4, ebx 
    PRINT_STRING msg_percent

    
    mov eax, [c_enhance]
    mov ebx , [e_price + eax * 4]    
    PRINT_STRING msg_5
    PRINT_DEC 4, ebx 
    NEWLINE
    
    
    ; 현재 판매 금액 출력 
    mov eax, [c_enhance]
    mov ebx , [s_price + eax * 4]    
    PRINT_STRING msg_6
    PRINT_DEC 4, ebx 
    NEWLINE
    
    ;입력 요청 출력 
    PRINT_STRING msg_3

    NEWLINE
    PRINT_STRING msg__
    NEWLINE
    ;숫자 입력을 받고 1이면 강화 2면 판매 3이면 종료 진행 다른거면 다시 반복 
    GET_DEC 4, input_key
    mov eax, [input_key]
    cmp eax, 1
    je enhance
    cmp eax, 2
    je sell
    cmp eax, 3
    je exit
    jmp GAME
       

    ;강화를 진행 랜덤 숫자를 받아서 확률 퍼센트보다 작은 숫자가 나오면 강화 성공 
    enhance:
     ;필요한 금액을 구하고 현재 금액이 더 적으면 다시 반복
      mov eax, [c_enhance]
      mov ebx,[e_price + eax *4]
      mov eax , [money]
      cmp eax, ebx
      JL nomoney
      sub eax, ebx
      mov [money], eax

      mov eax , [c_enhance]
      mov ebx , [percent + eax *4]
      
      ; 랜덤숫자를 받아서 확률보다 높은지 ㅂ교 
      call _getnumber
      PRINT_DEC 4 , eax
      NEWLINE
        PRINT_DEC 4 , ebx
      NEWLINE
      cmp eax, ebx
      JLE enhance_s
      jmp enhance_f
      
      enhance_s:
      PRINT_STRING msg_enhances
      NEWLINE
       mov eax , [c_enhance]
       inc eax
       mov [c_enhance], eax
      jmp GAME
      enhance_f:
      PRINT_STRING msg_enhancef
      NEWLINE
      mov eax,0
      mov [c_enhance], eax
      jmp GAME
      
      nomoney:
      PRINT_STRING  msg_nomoney
      NEWLINE
      jmp GAME
    sell:           
    ;강화된 아이템을 파는경우 
    mov eax , [c_enhance]
    mov ebx, [s_price + eax * 4]
    mov eax , [money]
    add eax, ebx
    mov [money] , eax
    mov [c_enhance],dword 0
    jmp GAME
    exit:
        
    


    ;write your code hered
    xor eax, eax
    ret
    
    

    
    
; 변수 세팅
section .data
money dd 0
c_enhance dd 0
input_key dd 0
fileName db 'enhanceGame.txt',0
fileStatus dd 0

msg__ db '-----------------------------------------',0

msg_1 db 'current money : ' ,0
msg_2  db 'current enhance step : ', 0
msg_3 db  'input number enhance 1, sell 2, game exit 3 ', 0
msg_4 db 'enhance percent : ', 0
msg_5 db '    enhance price : ', 0
msg_6 db 'sell price : ', 0
msg_nomoney db 'you have not engough money ', 0
msg_percent db '%', 0
msg_enhances db 'success enhance!', 0
msg_enhancef db 'fail enhance.', 0
section .bss
percent  resd 15
s_price resd 15
e_price resd 15