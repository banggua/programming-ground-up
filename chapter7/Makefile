include ../Makefile.header

SRC += add-year.s count-chars.s error-exit.s read-record.s record-def.s write-newline.s write-record.s
OBJ += $(SRC:.s=.o)
EXEC += add-year
TEST += test.dat testout.dat

all: $(EXEC)

add-year: add-year.s count-chars.s error-exit.s read-record.s write-newline.s write-record.s
	$(AS) $(ASFLAGS) -o add-year.o add-year.s
	$(AS) $(ASFLAGS) -o count-chars.o count-chars.s
	$(AS) $(ASFLAGS) -o error-exit.o error-exit.s
	$(AS) $(ASFLAGS) -o read-record.o read-record.s
	$(AS) $(ASFLAGS) -o write-newline.o write-newline.s
	$(AS) $(ASFLAGS) -o write-record.o write-record.s
	$(LD) $(LDFLAGS) -o add-year add-year.o count-chars.o error-exit.o read-record.o write-newline.o write-record.o

clean:
	rm -rf $(OBJ) $(EXEC) $(TEST)
