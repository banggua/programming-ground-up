include ../Makefile.header

SRC += exit.s maximum.s minimum.s
OBJ += $(SRC:.s=.o)
EXEC += exit maximum minimum

all: $(EXEC)

exit: exit.s
	$(AS) $(ASFLAGS) -o exit.o exit.s
	$(LD) $(LDFLAGS) -o exit exit.o

maximum: maximum.s
	$(AS) $(ASFLAGS) -o maximum.o maximum.s
	$(LD) $(LDFLAGS) -o maximum maximum.o

minimum: minimum.s
	$(AS) $(ASFLAGS) -o minimum.o minimum.s
	$(LD) $(LDFLAGS) -o minimum minimum.o

clean:
	rm -rf $(OBJ) $(EXEC)
