.code32

.section .data

.section .text
.globl _start
_start:
	PUSHL $8
	PUSHL $2
	CALL square
	PUSHL %eax
	POPL %ebx
	MOVL $1, %eax
	INT $0x80

	.type square, @function
	square:
		PUSHL %ebp
		MOVL %esp, %ebp
		SUBL $4, %esp
		MOVL 8(%ebp), %ebx
		MOVL 12(%ebp), %ecx
		MOVL %ebx, -4(%ebp)

		square_loop_start:
			CMPL $1, %ecx
			JE end_square
			MOVL -4(%ebp), %eax
			IMULL %ebx, %eax

			MOVL %eax, -4(%ebp)
			DECL %ecx
			JMP square_loop_start

			end_square:
				MOVL -4(%ebp), %eax
				MOVL %ebp, %esp
				POPL %ebp
		RET
