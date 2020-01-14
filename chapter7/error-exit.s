.code32

.include "linux.s"

.equ ST_ERROR_CODE, 8
.equ ST_ERROR_MSG, 12

.globl error_exit
.type error_exit, @function
error_exit:
    PUSHL %ebp
    MOVL %esp, %ebp

    MOVL ST_ERROR_CODE(%ebp), %ecx
    PUSHL %ecx
    CALL count_chars
    POPL %ecx
    MOVL %eax, %edx
    MOVL $STDERR, %ebx
    MOVL $SYS_WRITE, %eax
    INT $LINUX_SYSCALL

    MOVL ST_ERROR_MSG(%ebp), %ecx
    PUSHL %ecx
    CALL count_chars
    POPL %ecx
    MOVL %eax, %edx
    MOVL $STDERR, %ebx
    MOVL $SYS_WRITE, %eax
    INT $LINUX_SYSCALL

    PUSHL $STDERR
    CALL write_newline

    MOVL $SYS_EXIT, %eax
    MOVL $1, %ebx
    INT $LINUX_SYSCALL
