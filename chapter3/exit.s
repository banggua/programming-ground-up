.code32

.section .data

.section .text
.globl _start
_start:
    MOVL $1, %eax
    MOVL $0, %ebx
    INT $0x80
