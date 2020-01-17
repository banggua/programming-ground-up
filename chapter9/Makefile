include ../Makefile.header

SRC += alloc.s count-chars.s linux.s read-record.s read-records.s record-def.s write-newline.s
OBJ += $(SRC:.s=.o)
EXEC += read-records

all: $(EXEC)

read-records: alloc.s count-chars.s linux.s read-record.s read-records.s record-def.s write-newline.s
	$(AS) $(ASFLAGS) -o alloc.o alloc.s
	$(AS) $(ASFLAGS) -o count-chars.o count-chars.s
	$(AS) $(ASFLAGS) -o read-record.o read-record.s
	$(AS) $(ASFLAGS) -o read-records.o read-records.s
	$(AS) $(ASFLAGS) -o write-newline.o write-newline.s
	$(LD) $(LDFLAGS) -o read-records alloc.o count-chars.o read-record.o read-records.o write-newline.o

clean:
	rm -rf $(OBJ) $(EXEC)
