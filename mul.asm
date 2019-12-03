%macro scall 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro
%macro exit 0
	mov rax,60
	mov rdi,0
	syscall
%endmacro

section .data
	

	
	n1msg db 10,"Enter first Number=",10d,13d
	n1msg_len equ $-n1msg

	n2msg db 10,"Enter second Number=",10d,13d		
	n2msg_len equ $-n2msg

	samsg db 10,"Result of Successive Addition is =",10d,13d
	samsg_len equ $-samsg



section .bss

         num resb 20

	no1 resb 3
	no2 resb 3
	
	ansl resw 1
	ansh resw 1

	ans resd 1
	
	char_ans resb 4
;---------------------------


section .text

global _start
_start:

    scall 1,1,n1msg,n1msg_len
    scall 0,0,num,3
	call accept_proc
	mov [no1],bx

	scall 1,1,n2msg,n2msg_len
	scall 0,0,num,3
	call accept_proc
	mov [no2],bx


SA:
	mov rbx,[no1]
	mov rcx,[no2]
	xor rax,rax
	xor rdx,rdx

back: 	add rax,rbx
	jnc next
	inc rdx

next:	dec rcx
	jnz back

	mov [ansl],rax
	mov [ansh],rdx

	scall 1,1,samsg,samsg_len
	mov ax,[ansh]

	call display_16

	mov ax,[ansl]
	call display_16

exit
;---------------------------
accept_proc:
	mov rsi,num
	mov rbx,0
	mov rax,0
	mov rcx,2
back1:
	rol rbx,04
	mov al,[rsi]
	cmp al,39h
	jbe next1
	sub al,07h
next1:
	sub al,30h
	add bx,ax
	inc rsi
	dec rcx
	jnz back1
	ret

;-----------------------------

display_16:
		mov rsi,char_ans+3
		mov rcx,4
cnt:
		mov rdx,0

		mov rbx,16
		div rbx

		cmp dl,09h
		jbe L2
		add dl,07h
	L2: 	add dl,30h

		mov [rsi],dl
		dec rsi

		dec rcx
		jnz cnt

	scall 1,1,char_ans,4
ret
