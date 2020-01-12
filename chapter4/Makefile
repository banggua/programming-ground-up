include ../Makefile.header

SRC += factorial.s power.s square.s
OBJ += $(SRC:.s=.o)
EXEC += factorial power square

all: $(EXEC)

factorial: factorial.s
	$(AS) $(ASFLAGS) -o factorial.o factorial.s
	$(LD) $(LDFLAGS) -o factorial factorial.o

power: power.s
	$(AS) $(ASFLAGS) -o power.o power.s
	$(LD) $(LDFLAGS) -o power power.o

square: square.s
	$(AS) $(ASFLAGS) -o square.o square.s
	$(LD) $(LDFLAGS) -o square square.o

clean:
	rm -rf $(OBJ) $(EXEC)
