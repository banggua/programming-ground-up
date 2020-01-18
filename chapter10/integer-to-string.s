.code32

.equ ST_VALUE, 8
.equ ST_BUFFER, 12

.globl integer2string
.type integer2string, @function
integer2string:
    PUSHL %ebp
    MOVL %esp, %ebp

    MOVL $0, %ecx
    MOVL ST_VALUE(%ebp), %eax
    MOVL $10, %edi

    conversion_loop:
        MOVL $0, %edx
        DIVL %edi
        ADDL $'0', %edx
        PUSHL %edx
        INCL %ecx
        CMPL $0, %eax
        JE end_conversion_loop
        JMP conversion_loop

    end_conversion_loop:
        MOVL ST_BUFFER(%ebp), %edx

    copy_reversing_loop:
        POPL %eax
        MOVB %al, (%edx)
        DECL %ecx
        INCL %edx
        CMPL $0, %ecx
        JE end_copy_reversing_loop
        JMP copy_reversing_loop

    end_copy_reversing_loop:
        MOVL $0, (%edx)

        MOVL %ebp, %esp
        POPL %ebp
        RET
