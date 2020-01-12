.code32

.include "linux.s"
.include "record-def.s"

.section .data
record1:
	.ascii "Fredrick\0"
	.rept 31
	.byte 0
	.endr

	.ascii "Bartlett\0"
	.rept 31
	.byte 0
	.endr

	.ascii "4242 S Prairie\nTulsa, OK 55555\0"
	.rept 209
	.byte 0
	.endr

	.long 45

record2:
	.ascii "Marilyn\0"
	.rept 32
	.byte 0
	.endr

	.ascii "Taylor\0"
	.rept 33
	.byte 0
	.endr

	.ascii "2224 S Johannan St\nChicago, IL 12345\0"
	.rept 203
	.byte 0
	.endr

	.long 29

record3:
	.ascii "Derrick\0"
	.rept 32
	.byte 0
	.endr

	.ascii "McIntire\0"
	.rept 31
	.byte 0
	.endr

	.ascii "500 W Oakland\nSan Diego, CA 54321\0"
	.rept 206
	.byte 0
	.endr

	.long 36

file_name:
	.ascii "test.dat\0"
	.equ ST_FILE_DESCRIPTOR, -4
.globl _start
_start:
	MOVL %esp, %ebp
	SUBL $4, %esp

	MOVL $SYS_OPEN, %eax
	MOVL $file_name, %ebx
	MOVL $0101, %ecx
	MOVL $0666, %edx
	INT $LINUX_SYSCALL

	MOVL %eax, ST_FILE_DESCRIPTOR(%ebp)

	PUSHL ST_FILE_DESCRIPTOR(%ebp)
	PUSHL $record1
	CALL write_record
	ADDL $8, %esp

	PUSHL ST_FILE_DESCRIPTOR(%ebp)
	PUSHL $record2
	CALL write_record
	ADDL $8, %esp

	PUSHL ST_FILE_DESCRIPTOR(%ebp)
	PUSHL $record3
	CALL write_record
	ADDL $8, %esp

	MOVL $SYS_CLOSE, %eax
	MOVL ST_FILE_DESCRIPTOR(%ebp), %ebx
	INT $LINUX_SYSCALL

	MOVL $SYS_EXIT, %eax
	MOVL $0, %ebx
	INT $LINUX_SYSCALL
