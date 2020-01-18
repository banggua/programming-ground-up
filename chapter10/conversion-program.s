.code32

.include "linux.s"

.section .data
tmp_buffer:
.ascii "\0\0\0\0\0\0\0\0\0"

.section .text
.globl _start
_start:
    MOVL %esp, %ebp

    PUSHL $tmp_buffer
    PUSHL $824
    CALL integer2string
    ADDL $8, %esp

    PUSHL $tmp_buffer
    CALL count_chars
    ADDL $4, %esp

    MOVL %eax, %edx

    MOVL $SYS_WRITE, %eax
    MOVL $STDOUT, %ebx
    MOVL $tmp_buffer, %ecx

    INT $LINUX_SYSCALL

    PUSHL $STDOUT
    CALL write_newline

    MOVL $SYS_EXIT, %eax
    MOVL $0, %ebx
    INT $LINUX_SYSCALL
