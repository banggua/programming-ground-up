include ../Makefile.header

SRC += toupper.s toupper-stdout.s
OBJ += $(SRC:.s=.o)
EXEC += toupper toupper-stdout

all: $(EXEC)

toupper: toupper.s
	$(AS) $(ASFLAGS) -o toupper.o toupper.s
	$(LD) $(LDFLAGS) -o toupper toupper.o

toupper-stdout: toupper-stdout.s
	$(AS) $(ASFLAGS) -o toupper-stdout.o toupper-stdout.s
	$(LD) $(LDFLAGS) -o toupper-stdout toupper-stdout.o

clean:
	rm -rf $(OBJ) $(EXEC)
