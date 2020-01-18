include ../Makefile.header

SRC += conversion-program.s count-chars.s integer-to-string.s linux.s write-newline.s
OBJ += $(SRC:.s=.o)
EXEC += conversion-program

all: $(EXEC)

conversion-program: conversion-program.s count-chars.s integer-to-string.s linux.s write-newline.s
	$(AS) $(ASFLAGS) -o conversion-program.o conversion-program.s
	$(AS) $(ASFLAGS) -o count-chars.o count-chars.s
	$(AS) $(ASFLAGS) -o integer-to-string.o integer-to-string.s
	$(AS) $(ASFLAGS) -o write-newline.o write-newline.s
	$(LD) $(LDFLAGS) -o conversion-program conversion-program.o count-chars.o integer-to-string.o write-newline.o

clean:
	rm -rf $(OBJ) $(EXEC)
