.section .data
heap_begin:
.long 0
current_break:
.long 0

.equ HEADER_SIZE, 8
.equ HDR_AVAIL_OFFSET, 0
.equ HDR_SIZE_OFFSET, 4

.equ UNAVAILABLE, 0
.equ AVAILABLE, 1
.equ SYS_BRK, 45

.equ LINUX_SYSCALL, 0x80

.section .text
.globl allocate_init
.type allocate_init, @function
allocate_init:
    PUSHL %ebp
    MOVL %esp, %ebp

    MOVL $SYS_BRK, %eax
    MOVL $0, %ebx
    INT $LINUX_SYSCALL

    INCL %eax

    MOVL %eax, current_break

    MOVL %eax, heap_begin

    MOVL %ebp, %esp
    POPL %ebp
    RET

.globl allocate
.type allocate, @function
.equ ST_MEM_SIZE, 8
allocate:
    PUSHL %ebp
    MOVL %esp, %ebp

    MOVL ST_MEM_SIZE(%ebp), %ecx

    MOVL heap_begin, %eax
    MOVL current_break, %ebx

    alloc_loop_begin:
        CMPL %ebx, %eax
        JE move_break

        MOVL HDR_SIZE_OFFSET(%eax), %edx
        CMPL $UNAVAILABLE, HDR_AVAIL_OFFSET(%eax)
        JE next_location

        CMPL %edx, %ecx
        JLE allocate_here

    next_location:
        ADDL $HEADER_SIZE, %eax
        ADDL %edx, %eax
        JMP alloc_loop_begin

    allocate_here:
        MOVL $UNAVAILABLE, HDR_AVAIL_OFFSET(%eax)
        ADDL $HEADER_SIZE, %eax

        MOVL %ebp, %esp
        POPL %ebp
        RET

    move_break:
        ADDL $HEADER_SIZE, %ebx
        ADDL %ecx, %ebx

        PUSHL %eax
        PUSHL %ecx
        PUSHL %ebx

        MOVL $SYS_BRK, %eax
        INT $LINUX_SYSCALL

        CMPL $0, %eax
        JE error

        POPL %ebx
        POPL %ecx
        POPL %eax

        MOVL $UNAVAILABLE, HDR_AVAIL_OFFSET(%eax)
        MOVL %ecx, HDR_SIZE_OFFSET(%eax)

        ADDL $HEADER_SIZE, %eax

        MOVL %ebx, current_break

        MOVL %ebp, %esp
        POPL %ebp
        RET

    error:
        MOVL $0, %eax
        MOVL %ebp, %esp
        POPL %ebp
        RET

.globl deallocate
.type deallocate, @function
.equ ST_MEMORY_SEG, 4
deallocate:
    MOVL ST_MEMORY_SEG(%esp), %eax
    SUBL $HEADER_SIZE, %eax
    MOVL $AVAILABLE, HDR_AVAIL_OFFSET(%eax)

    RET
