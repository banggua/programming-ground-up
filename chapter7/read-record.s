.include "record-def.s"
.include "linux.s"

.equ ST_READ_BUFFER, 8
.equ ST_FILEDES, 12
.section .text
.globl read_record
.type read_record, @function

read_record:
    PUSHL %ebp
    MOVL %esp, %ebp

    PUSHL %ebx
    MOVL ST_FILEDES(%ebp), %ebx
    MOVL ST_READ_BUFFER(%ebp), %ecx
    MOVL $RECORD_SIZE, %edx
    MOVL $SYS_READ, %eax
    INT $LINUX_SYSCALL

    POPL %ebx

    MOVL %ebp, %esp
    POPL %ebp
RET
