.code32

.section .data

.section .text
.globl _start
.globl factorial
_start:
	PUSHL $4
	CALL factorial
	ADDL $4, %esp
	MOVL %eax, %ebx
	MOVL $1, %eax
	INT $0x80

	.type factorial, @function
	factorial:
		PUSHL %ebp
		MOVL %esp, %ebp
		MOVL 8(%ebp), %eax

		CMPL $1, %eax
		JE end_factorial
		DECL %eax
		PUSHL %eax
		CALL factorial
		MOVL 8(%ebp), %ebx
		IMULL %ebx, %eax

		end_factorial:
			MOVL %ebp, %esp
			POPL %ebp
	RET
