.code32

.section .data
data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,255

.section .text
.globl _start
_start:
	MOVL $0, %edi
	MOVL data_items(,%edi,4), %eax
	MOVL %eax, %ebx

	start_loop:
		CMPL $255, %eax
		JE loop_exit
		INCL %edi
		MOVL data_items(,%edi,4), %eax
		CMPL %ebx, %eax
		JGE start_loop
		MOVL %eax, %ebx
		JMP start_loop

	loop_exit:
		MOVL $1, %eax
		INT $0x80
