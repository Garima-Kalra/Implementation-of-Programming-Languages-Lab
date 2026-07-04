TARGET = 230101039_setb_Q6

ASM = nasm
LD = ld

ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386

SRC = $(TARGET).asm
OBJ = $(TARGET).o

all: $(TARGET)

$(OBJ):$(SRC)
	$(ASM) $(ASMFLAGS) $< -o $@
	
$(TARGET):$(OBJ)
	$(LD) $(LDFLAGS) $< -o $@
	
clean:
	rm -f $(OBJ) $(TARGET)
