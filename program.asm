section .bss
	stack_space resq 128							; Allocates 1kb
	buffer resb 128									; 128 bytes for standard user input
	sp resq 1										; Stack pointer index

section .data
	prompt db "Enter RPN Expression: ", 10, 0

section .text
	global _start

_start:
	; Take input
	mov rax, 0										; Syscall number for sys_read
	mov rdi, 0										; File descriptor 0 = stdin
	mov rsi, buffer									; Pointer to buffer
	mov rdx, 128									; Max number of bytes to read
	syscall

	; Remove newline
	mov rcx, rax
	cmp rcx, 0
	je skip_newline
	dec rcx
	mov al, [buffer + rcx]
	cmp al, 10
	jne skip_newline
	mov byte [buffer + rcx], 0
skip_newline:

	

	; Write back
	mov rax, 1										; Syscall number for sys_write
	mov rdi, 1										; File descriptor 1 = stdout
	mov rsi, buffer									; Pointer to buffer
	; rdx contains bytes read from rax
	syscall

	; Exit
	mov rax, 60										; Syscall number for sys_exit
	xor rdi, rdi									; Exit code 0
	syscall
