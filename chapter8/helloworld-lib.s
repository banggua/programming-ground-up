.code32

.include "linux.s"

.section .data
helloworld:
.ascii "hello world\n\0"

.section .text
.globl _start
_start:
    PUSHL $helloworld
    CALL printf

    PUSHL $0
    CALL exit
