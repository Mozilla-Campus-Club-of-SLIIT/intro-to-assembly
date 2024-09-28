.intel_syntax noprefix

.global print_string
.global print_int

.text

print_string:
	mov		rax, 1	# sys_write
	mov		rdi, 1	# fd (stdout)
	mov		rsi, r12 # buffer
	mov		rdx, r13	# count
	syscall
	ret
	
print_int:
	xor		rax, rax
	mov		rax, r12
	mov		bx, 10
	mov		rbp, rsp
print_int_loop:
	xor		rdx, rdx
	div		bx

	push	rdx

	cmp		rax, 0
	jne		print_int_loop

print_digit_loop:
	pop		rax

	lea		r12, [digits + rax] # digits[5]
	mov		r13, 1
	call	print_string

	cmp		rbp, rsp
	je 		print_int_done
	jmp		print_digit_loop

print_int_done:
	ret
