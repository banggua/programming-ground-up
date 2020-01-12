include ../Makefile.header

SRC += add-year.s count-chars.s linux.s read-record.s read-records.s record-def.s write-newline.s write-record.s write-records.s
OBJ += $(SRC:.s=.o)
EXEC += write-records read-records add-year
TEST += test.dat

all: $(EXEC)

write-records: write-record.s write-records.s
	$(AS) $(ASFLAGS) -o write-record.o write-record.s
	$(AS) $(ASFLAGS) -o write-records.o write-records.s
	$(LD) $(LDFLAGS) -o write-records write-record.o write-records.o

read-records: read-record.s count-chars.s write-newline.s read-records.s
	$(AS) $(ASFLAGS) -o read-record.o read-record.s
	$(AS) $(ASFLAGS) -o count-chars.o count-chars.s
	$(AS) $(ASFLAGS) -o write-newline.o write-newline.s
	$(AS) $(ASFLAGS) -o read-records.o read-records.s
	$(LD) $(LDFLAGS) -o read-records read-record.o count-chars.o write-newline.o read-records.o

add-year: read-record.s write-record.s add-year.s
	$(AS) $(ASFLAGS) -o read-record.o read-record.s
	$(AS) $(ASFLAGS) -o write-record.o write-record.s
	$(AS) $(ASFLAGS) -o add-year.o add-year.s
	$(LD) $(LDFLAGS) -o add-year read-record.o write-record.o add-year.o

clean:
	rm -rf $(OBJ) $(EXEC) $(TEST)
