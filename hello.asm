section .data
	m1 db "Hello world"
	l1 equ $-m1
section .text
global _start 
_start:
	mov rax,1
	mov rdi,1
	mov rsi,m1
	mov rdx,l1
syscall 
mov rax,60
mov rdi,0
syscall
