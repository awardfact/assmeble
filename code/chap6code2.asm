; 32bit mode
%include "io64.inc"

LOTTO_COUNT equ 6
;equ 지시어는 심볼을 정의할 때 사용한다. 심볼(symbol)이란 어셈블리 프로그래밍을 할 때 사용되는 상수를 말하며, 다음과 같이 사용한다.
;symbol equ value 한 번 정의된 심볼의 값은 절대로 재정의 될 수 없다.

section .text
global CMAIN
extern _getnumber ;c언어에서 가져오는함수 1~45 사이 수 리턴
extern _inimylib ; 랜덤시드값 초기화 해주는 함수
;============================================아래 각각에는 어셈함수가 들어갈 것임

;input:
;return:

CMAIN:
   call _inimylib ; c언어로 짜놓은 코드 불러오기, 랜덤시드값 초기화
   ;mov ecx,0 ; ecx레지스터 초기화 
   ;ecx는 보통 카운터 레지스터임. 주로 반복 명령어 사용시 반복 카운터로 사용되는 레지스터로, ECX 레지스터에 반복할 횟수를 지정하고, 반복 작업을 수행
   mov ecx,0
cmain_loop1:
   cmp ecx, LOTTO_COUNT ;값을 비교 함.
   jge cmain_end ; ecx의 값이 더 크면 cmain 함수 종료.
   
   push ecx
   call _getnumber ;45 사이 수 리턴받음
   mov [a],eax
   ;여기서 eax는 c코드에서 받아온 a,즉 랜덤으로 뽑힌 한개의 값임   
   pop ecx
   
   push ecx
   mov ebx,ecx
   call CheckSame ; CheckSame즉 동일한 값이 들어가는지 비교하는 함수 불러오기
   pop ecx
   
   cmp eax,1
   je checksame_loop1 ;je=같으면 점프 (참일시 즉 값이 같으면)
   
   mov ebx, [a]
   mov [data+ecx*4],ebx ;ebx를 다음 배열의 넣는다.
   
   inc ecx;값증가 +1   
   jmp cmain_loop1;다시 루프돌기 (반복문)
   
cmain_end:
   call ShowData ;숫자 6개 즉 > 랜덤한 6개 로또 값 출력시켜 보여줌   
   ret
;=============================================
;input: eax(a), ebx(size)
;return: eax(0: not same, 1: find same)
   inc ecx
CheckSame:
   mov edx,0 ;edx 초기화
   mov ecx,0 ;ecx 초기화

checksame_loop1:
   cmp ecx,ebx ;값을 비교
   jge checksame_end
   cmp eax, [data+ecx*4];*4를 해주는 이유는 다음 배열을 찾아서 가기 위함임(4byte짜리), 다음칸 주소 알아서 찾아감.
   jne checksame_endif  ;!= 점프해라!
   mov edx,1 
   jmp checksame_end

checksame_endif:
   inc ecx ; 1증가, 다음값 start
   jmp checksame_loop1
   NEWLINE

checksame_end:
   mov eax, edx   
   ret

;===================================================================
;input:
;return:
ShowData:
   NEWLINE
   PRINT_STRING msg1
   mov ecx,0 ;레지스터 초기화
   
showdata_loop1: ;label start
   cmp ecx,LOTTO_COUNT ; 값 비교 
   jge show_end;앞의 값이 크거나,같다면 >= show_end로 이동
   
   push ecx;스택에 넣어줌
   PRINT_DEC 4, [data + ecx*4] ;출력
   pop ecx ; 값 빼줌
   
   cmp ecx, LOTTO_COUNT -1 ;ecx와 값 비교
   jge show_next
   push ecx
   PRINT_STRING msg2 ;문자열 출력
   pop ecx ;push로 스택에 값을 넣어주면 pop을 이용해서 반드시 비워줘야함.

show_next:
   inc ecx ; inc = 피연산자에 1을 더한다.
   jmp showdata_loop1 ;무조건 jmp하는 명령어/피연산자의 위치로 실행 흐름이 변경된다. 피연산자가 가리키는 코드로 점프 뛰어서 실행한다고 생각하면 된다.

show_end:
   ret
   
section .data ;초기값,메모리 용량 확보
   msg1 db "Lotto : ",0
   msg2 db ",",0
 
   
   
section .bss;메모리 용량,갯수 확보
   a resd 1 ;4byte
   data resd 6  
   num resw 1;
   num2 resw 1;
   
