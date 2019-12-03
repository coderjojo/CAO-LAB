%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall 
%endmacro

section .data 
m1 db "Enter 64 bit no=",10d,13d
l1 equ $-m1
m2 db "The 64 bit no is =",10d,13d
l2 equ $-m2
section .bss
num resq 1
section .text
global _start
_start:
scall 1,1,m1,l1
scall 0,0,num,17
scall 1,1,m2,l2
scall 1,1,num,17
mov rax,60
mov rdi,0
syscall
