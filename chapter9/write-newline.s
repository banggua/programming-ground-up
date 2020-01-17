.code32

.include "linux.s"

.globl write_newline
.type write_newline, @function

.section .data
newline:
    .ascii "\n"
    .section .text
    .equ ST_FILEDES, 8
write_newline:
    PUSHL %ebp
    MOVL %esp, %ebp
    MOVL $SYS_WRITE, %eax
    MOVL ST_FILEDES(%ebp), %ebx
    MOVL $newline, %ecx
    MOVL $1, %edx
    INT $LINUX_SYSCALL
    MOVL %ebp, %esp
    POPL %ebp
RET
