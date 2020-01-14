.code32

.section .data

.section .text
.globl _start
_start:
    PUSHL $3
    PUSHL $2
    CALL power
    ADDL $8, %esp
    PUSHL %eax

    PUSHL $2
    PUSHL $5
    CALL power
    ADDL $8, %esp
    POPL %ebx
    ADDL %eax, %ebx
    MOVL $1, %eax
    INT $0x80

    .type power, @function
    power:
        PUSHL %ebp
        MOVL %esp, %ebp
        SUBL $4, %esp
        MOVL 8(%ebp), %ebx
        MOVL 12(%ebp), %ecx
        MOVL %ebx, -4(%ebp)

        power_loop_start:
            CMPL $1, %ecx
            JE end_power
            MOVL -4(%ebp), %eax
            IMULL %ebx, %eax
            MOVL %eax, -4(%ebp)
            DECL %ecx
            JMP power_loop_start

        end_power:
            MOVL -4(%ebp), %eax
            MOVL %ebp, %esp
            POPL %ebp
    RET
