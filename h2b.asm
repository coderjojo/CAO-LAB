%macro scall 4
        mov rax,%1
        mov rdi,%2
        mov rsi,%3
        mov rdx,%4
        syscall
 %endmacro
 
 section .data
        m1 DB "Enter 4 digit Hex number :",10d,13d
        l1 equ $-m1
         
         m2 DB "The 4 digit Hex number :",10d,13d
        l2 equ $-m2      
        
        m3 DB "Equivalent BCD number is :",10d,13d
        l3 equ $-m3
        
section .bss
        num resb 10
        char_ans resb 6
        count resb 1
        arr resb 8
        
section .text 
global _start
_start:

        scall 1,1,m1,l1
        scall 0,0,num,5
        call accept_proc
        scall 1,1,m3,l3
        call HexToBCD
        
        mov rax,60
        mov rdi,0
        syscall
        
accept_proc:
                mov rsi,num
                mov rbx,0
                mov rax,0
                mov rcx,4
                
back:
        rol bx,04
        mov al,[rsi] 
        cmp al,39H
        jbe next
        sub al,07H
        
next:
        sub al,30H
        add bx,ax
        inc rsi
        dec rcx
        jnz back
        ret
        
 HexToBCD:
        mov rbp,arr
        mov rax,rbx
        mov rbx,0AH
        
 back2:
        xor rdx,rdx
        div rbx
        mov [rbp],rdx
        inc rbp
        inc byte[count]
        cmp rax,0H
        jne back2
        dec rbp
        
 display_BCD:
        xor rdx,rdx
        mov rdx,[rbp]
        add dl,30H
        mov [char_ans],dl
        scall 1,1,char_ans,1
        dec rbp
        dec byte[count]           
         jnz display_BCD
         ret
