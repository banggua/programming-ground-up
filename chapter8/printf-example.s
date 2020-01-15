.code32

.section .data
firststring:
.ascii "Hello! %s is a %s who loves the number %d\n\0"
name:
.ascii "Jonathan\0"
personstring:
.ascii "person\0"
numberloved:
.long 3

.section .text
.globl _start
_start:
    PUSHL numberloved
    PUSHL $personstring
    PUSHL $name
    PUSHL $firststring
    CALL printf
    PUSHL $0
    CALL exit
