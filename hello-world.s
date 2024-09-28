.intel_syntax noprefix

.global _start

.data

msg:		.ascii "Hello world\n"
msgLen = 	$ - msg

.text

_start:
	mov		rax, 1	# sys_write
	mov		rdi, 1	# fd (stdout)
	# lea  (load effective address)
	lea		rsi, [msg] # buffer
	mov		rdx, msgLen	# count
	syscall

	mov		rax, 60 # sys_exit
	mov		rdi, 0 	# return code
	syscall
	