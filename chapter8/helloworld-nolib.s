.code32

.include "linux.s"

.section .data
helloworld:
.ascii "hello world\n"
helloworld_end:
.equ helloworld_len, helloworld_end - helloworld

.section .text
.globl _start
_start:
    MOVL $STDOUT, %ebx
    MOVL $helloworld, %ecx
    MOVL $helloworld_len, %edx
    MOVL $SYS_WRITE, %eax
    INT $LINUX_SYSCALL

    MOVL $0, %ebx
    MOVL $SYS_EXIT, %eax
    INT $LINUX_SYSCALL
