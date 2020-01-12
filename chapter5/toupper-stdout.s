.code32

.section .data
.equ SYS_OPEN, 5
.equ SYS_WRITE, 4
.equ SYS_READ, 3
.equ SYS_CLOSE, 6
.equ SYS_EXIT, 1

.equ O_RDONLY, 0
.equ O_CREAT_WRONLY_TRUNC, 03101

.equ STDIN, 0
.equ STDOUT, 1
.equ STDERR, 2

.equ LINUX_SYSCALL, 0x80

.equ END_OF_FILE, 0

.equ NUMBER_ARGUMENTS, 2

.section .bss
.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text
.equ ST_SIZE_RESERVE, 8
.equ ST_FD_IN, -4
.equ ST_FD_OUT, -8
.equ ST_ARGC, 0
.equ ST_ARGV_0, 4
.equ ST_ARGV_1, 8

.globl _start
_start:
	MOVL %esp, %ebp
	SUBL $ST_SIZE_RESERVE, %esp

	open_files:
		open_fd_in:
			MOVL $SYS_OPEN, %eax
			MOVL ST_ARGV_1(%ebp), %ebx
			MOVL $O_RDONLY, %ecx
			MOVL $0666, %edx
			INT $LINUX_SYSCALL
		store_fd_in:
			MOVL %eax, ST_FD_IN(%ebp)

		open_fd_out:
		store_fd_out:
			MOVL $1, ST_FD_OUT(%ebp)

	read_loop_begin:
		MOVL $SYS_READ, %eax
		MOVL ST_FD_IN(%ebp), %ebx
		MOVL $BUFFER_DATA, %ecx
		MOVL $BUFFER_SIZE, %edx
		INT $LINUX_SYSCALL

		CMPL $END_OF_FILE, %eax
		JLE end_loop

	continue_read_loop:
		PUSHL $BUFFER_DATA
		PUSHL %eax
		CALL convert_to_upper
		POPL %eax
		ADDL $4, %esp

		MOVL %eax, %edx
		MOVL $SYS_WRITE, %eax
		MOVL ST_FD_OUT(%ebp), %ebx
		MOVL $BUFFER_DATA, %ecx
		INT $LINUX_SYSCALL

		JMP read_loop_begin

	end_loop:
		movl $SYS_CLOSE, %eax
		movl ST_FD_OUT(%ebp), %ebx
		int $LINUX_SYSCALL

		movl $SYS_CLOSE, %eax
		movl ST_FD_IN(%ebp), %ebx
		int $LINUX_SYSCALL

		movl $SYS_EXIT, %eax
		movl $0, %ebx
		int $LINUX_SYSCALL

	.equ LOWERCASE_A, 'a'
	.equ LOWERCASE_Z, 'z'
	.equ UPPER_CONVERSION, 'A' - 'a'

	.equ ST_BUFFER_LEN, 8
	.equ ST_BUFFER, 12

	.type convert_to_upper, @function
	convert_to_upper:
		PUSHL %ebp
		MOVL %esp, %ebp

		MOVL ST_BUFFER(%ebp), %eax
		MOVL ST_BUFFER_LEN(%ebp), %ebx
		MOVL $0, %edi

		CMPL $0, %ebx
		JE end_convert_loop

		convert_loop:
			MOVB (%eax,%edi,1), %cl

			CMPB $LOWERCASE_A, %cl
			JL next_byte
			CMPB $LOWERCASE_Z, %cl
			JG next_byte

			ADDB $UPPER_CONVERSION, %cl
			MOVB %cl, (%eax,%edi,1)

		next_byte:
			INCL %edi
			CMPL %edi, %ebx

			JNE convert_loop


		end_convert_loop:
			MOVL %ebp, %esp
			POPL %ebp
	ret
