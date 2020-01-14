.code32

.include "linux.s"
.include "record-def.s"

.section .data
input_file_name:
.ascii "test.dat\0"

output_file_name:
.ascii "testout.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8

.section .text
.globl _start
_start:
    MOVL %esp, %ebp
    SUBL $8, %esp

    MOVL $SYS_OPEN, %eax
    MOVL $input_file_name, %ebx
    MOVL $0, %ecx
    MOVL $0666, %edx
    INT $LINUX_SYSCALL

    MOVL %eax, ST_INPUT_DESCRIPTOR(%ebp)

    CMPL $0, %eax
    JGE continue_processing

    .section .data
    no_open_file_code:
    .ascii "0001:  \0"
    no_open_file_msg:
    .ascii "Can't Open Input File\0"

    .section .text
    PUSHL $no_open_file_msg
    PUSHL $no_open_file_code
    CALL error_exit

    continue_processing:
        MOVL $SYS_OPEN, %eax
        MOVL $output_file_name, %ebx
        MOVL $0101, %ecx
        MOVL $0666, %edx
        INT $LINUX_SYSCALL

        MOVL %eax, ST_OUTPUT_DESCRIPTOR(%ebp)

        loop_begin:
            PUSHL ST_INPUT_DESCRIPTOR(%ebp)
            PUSHL $record_buffer
            CALL read_record
            ADDL $8, %esp

            CMPL $RECORD_SIZE, %eax
            JNE loop_end

            INCL record_buffer + RECORD_AGE

            PUSHL ST_OUTPUT_DESCRIPTOR(%ebp)
            PUSHL $record_buffer
            CALL write_record
            ADDL $8, %esp

            JMP loop_begin

        loop_end:
            MOVL $SYS_CLOSE, %eax
            MOVL ST_INPUT_DESCRIPTOR(%ebp), %ebx
            INT $LINUX_SYSCALL

            MOVL $SYS_CLOSE, %eax
            MOVL ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
            INT $LINUX_SYSCALL

            MOVL $SYS_EXIT, %eax
            MOVL $0, %ebx
            INT $LINUX_SYSCALL
