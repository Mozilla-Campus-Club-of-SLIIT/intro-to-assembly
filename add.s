.intel_syntax noprefix

.global _start

.include "print.s"

.data

digits:		.ascii "0123456789"
prompt1:	.ascii "Enter n1: "
prompt1Len	= $ - prompt1
prompt2:	.ascii "Enter n2: "
prompt2Len = $ - prompt2


.bss 

.lcomm inputBuffer 10
.lcomm n1 8 # long n1
.lcomm n2 8 # long n2

.text

_start:

	lea		r12, [prompt1]
	mov		r13, prompt1Len
	call	print_string

	mov		rax, 0 		# sys_read
	mov		rdi, 0		# fd (stdin)
	lea		rsi, [inputBuffer] # buffer
	mov		rdx, 10		# count
	syscall

	mov		r12, rsi
	call	parse_int
	mov		[n1], rax


	lea		r12, [prompt2]
	mov		r13, prompt2Len
	call	print_string

	mov		rax, 0 		# sys_read
	mov		rdi, 0		# fd (stdin)
	lea		rsi, [inputBuffer] # buffer
	mov		rdx, 10		# count
	syscall

	mov		r12, rsi
	call	parse_int
	mov		[n2], rax

	
	mov		rax, [n1]
	mov		rbx, [n2]
	add		rax, rbx

	mov		r12, rax
	call	print_int

	mov		rax, 60 # sys_exit
	mov		rdi, 0 	# return code
	syscall


parse_int:
	xor		rbx, rbx
	mov		rsi, r12

parse_int_loop:
	lodsb
	cmp		al, '\n'
	je		parse_int_ret
	imul	bx, 10
	sub		al, '0'
	add		bx, ax
	jmp		parse_int_loop
parse_int_ret:
	mov		rax, rbx
	ret
