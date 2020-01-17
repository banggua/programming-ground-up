.code32

.type count_chars, @function
.globl count_chars

.equ ST_STRING_START_ADDRESS, 8
count_chars:
    PUSHL %ebp
    MOVL %esp, %ebp

    MOVL $0, %ecx
    MOVL ST_STRING_START_ADDRESS(%ebp), %edx

    count_loop_begin:
        MOVB (%edx), %al
        CMPB $0, %al
        JE count_loop_end
        INCL %ecx
        INCL %edx
        JMP count_loop_begin

    count_loop_end:
        MOVL %ecx, %eax
        POPL %ebp
RET
