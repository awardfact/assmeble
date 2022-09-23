%include "io64.inc"

section .text
global CMAIN

CMAIN:


    ; 값을 받아서 input_data에 넣는다 
    GET_DEC 2, input_data
    PRINT_DEC 2, input_data
    NEWLINE
    
    ; eax값 초기화, 3배수 변수 초기화, 1부터 반복을 돌기 때문에 반복에 사용할ecx를 1로 초기화해준다  
    mov eax , 0
    mov [three_count] , word 0
    mov ecx , 1



    L1:
    ;반복에서 cx /3 을 계산하고 나머지가 0이면 three로 점프 아니면 cx를 1추가하고 다시 반복 
    mov ax, cx
    mov dl , 3
    div dl
    CMP ah , 0

    JE three

    INC cx     

    mov dx , [input_data]    


    ;dx에 입력값 넣고 cx랑 비교해서 cx가 더 작으면 반복 아니면 LEND로 점프 
    CMP cx ,dx
    JL L1

    JMP LEND
    
    
    
    

    three:
    
    ;3의 배수일때 배열에 값을 넣고 3의 배수 숫자를 1플러스해준다 그리고 cx의 값을 + 1 해주고 다시 반복
    mov dx , [input_data]  
    CMP cx ,dx
    mov ax , [three_count]

    mov [three_array + eax*2] ,  cx
    PRINT_DEC 2, cx
    NEWLINE
    mov dx , [three_count]
    inc dx
    mov [three_count], dx
    INC cx


    Jmp L1
    LEND:
    
    ; 3의 배수의 개수를 출력하고 3의 배수를 배열에 넣은 것을 반복 돌리기 위해 값들 초기화 
    PRINT_DEC 2, three_count
    NEWLINE
    NEWLINE
    mov edx, 0
    mov cx, [three_count]
    mov [three_plus] ,word 0
    
    
    L2:
    ; 배열에 있는값을 bx에 넣고 더하기 연산 수행 후 cx랑 dx랑 비교해서 cx가 더 크면 반복을 돌린다 
    mov bx, [three_array + edx *2]
    add [three_plus] , bx
    inc dx
    
    

    cmp cx, dx
    JG L2
    
    ; 3의 배수 더한값 출력 
    PRINT_DEC 2, three_plus
    NEWLINE
    ;write your code here
    xor rax, rax
    ret
; 필요한 변수들은 초기화되지 않은 상태로 선언 
section .bss
input_data resw 1 
three_count resw 1
three_plus resw 1
three_array resw 100
