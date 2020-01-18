GCC = gcc
GCCFLAGS = -std=c17 -g -static

SRC = Hello-World.c
OBJ = $(SRC:.c=.o)
EXEC = HelloWorld

all: $(EXEC)

HelloWorld: Hello-World.c
	$(GCC) $(GCCFLAGS) -o HelloWorld Hello-World.c

clean:
	rm -rf $(OBJ) $(EXEC)
