.code32

.include "linux.s"
.include "record-def.s"

.section .data
file_name:
.ascii "test.dat"
.lcomm record_buffer, RECORD_SIZE

.section .text
.globl _start
_start:
	.equ ST_INPUT_DESCRIPTOR, -4
	.equ ST_OUTPUT_DESCRIPTOR, -8

	MOVL %esp, %ebp
	SUBL $8, %esp

	MOVL $SYS_OPEN, %eax
	MOVL $file_name, %ebx
	MOVL $0, %ecx
	MOVL $0666, %edx
	INT $LINUX_SYSCALL

	MOVL %eax, ST_INPUT_DESCRIPTOR(%ebp)

	MOVL $STDOUT, ST_OUTPUT_DESCRIPTOR(%ebp)

	record_read_loop:
		PUSHL ST_INPUT_DESCRIPTOR(%ebp)
		PUSHL $record_buffer
		CALL read_record
		ADDL $8, %esp

		CMPL $RECORD_SIZE, %eax
		JNE finished_reading

		PUSHL $RECORD_FIRSTNAME + record_buffer
		CALL count_chars
		ADDL $4, %esp
		MOVL %eax, %edx
		MOVL $SYS_WRITE, %eax
		MOVL ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
		MOVL $RECORD_FIRSTNAME + record_buffer, %ecx
		INT $LINUX_SYSCALL

		PUSH ST_OUTPUT_DESCRIPTOR(%ebp)
		CALL write_newline
		ADDL $4, %esp

		JMP record_read_loop

	finished_reading:
		MOVL $SYS_EXIT, %eax
		MOVL $0, %ebx
		INT $LINUX_SYSCALL
