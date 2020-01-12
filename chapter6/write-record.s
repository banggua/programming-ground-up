.code32

.include "linux.s"
.include "record-def.s"

.equ ST_WRITE_BUFFER, 8
.equ ST_FILEDESCRIPTOR, 12

.section .text
.globl write_record
.type write_record,@function
write_record:
    PUSHL %ebp
    MOVL %esp, %ebp

    PUSHL %ebx
    MOVL $SYS_WRITE, %eax
    MOVL ST_FILEDESCRIPTOR(%ebp), %ebx
    MOVL ST_WRITE_BUFFER(%ebp), %ecx
    MOVL $RECORD_SIZE, %edx
    INT $LINUX_SYSCALL

    POPL %ebx

    MOVL %ebp, %esp
    POPL %ebp
RET
