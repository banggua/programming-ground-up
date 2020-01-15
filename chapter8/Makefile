include ../Makefile.header

SRC += helloworld-lib.s helloworld-nolib.s linux.s printf-example.s record-def.s read-record.s write-record.s write-records.s
OBJ += $(SRC:.s=.o)
EXEC += helloworld-lib helloworld-nolib printf-example  write-records
LOCALLIBS += librecord.so
TEST += test.dat testout.dat

all: $(EXEC)

helloworld-lib: helloworld-lib.s
	$(AS) $(ASFLAGS) -o helloworld-lib.o helloworld-lib.s
	$(LD) $(LDFLAGS) $(LDLINKER) -o helloworld-lib helloworld-lib.o -lc

helloworld-nolib: helloworld-nolib.s
	$(AS) $(ASFLAGS) -o helloworld-nolib.o helloworld-nolib.s
	$(LD) $(LDFLAGS) -o helloworld-nolib helloworld-nolib.o

printf-example: printf-example.s
	$(AS) $(ASFLAGS) -o printf-example.o printf-example.s
	$(LD) $(LDFLAGS) $(LDLINKER) -o printf-example printf-example.o -lc

write-records: read-record.s write-record.s
	$(AS) $(ASFLAGS) -o read-record.o read-record.s
	$(AS) $(ASFLAGS) -o write-record.o write-record.s
	$(LD) $(LDFLAGS) -shared -o librecord.so read-record.o write-record.o
	$(AS) $(ASFLAGS) -o write-records.o write-records.s
	$(LD) $(LDFLAGS) -L . $(LDLINKER) -o write-records write-records.o -lrecord
# export LD_LIBRARY_PATH=.

clean:
	rm -rf $(OBJ) $(EXEC) $(TEST) $(LOCALLIBS)
