#i686-elf-gcc -T src/link.ld -o Baros.bin -ffreestanding -O2 -nostdlib bin/boot.o bin/kernel.o -lgcc
#cp Baros.bin isodir/boot/Baros.bin
#grub-mkrescue -o Baros.iso isodir
#qemu-system-i386 -cdrom Baros.iso

SOURCES=*.o
INCLUDES=include
LDFLAGS=-ffreestanding -O2 -nostdlib
CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra -I$(INCLUDES)
LD=link.ld
CC=i686-elf-gcc
OS=Baros
EMULATOR=qemu-system-i386
ISO=isodir
ASM=nasm
SRC=~/projects/Operating_Systems/Branos

all: cc asm link
	cd $(SRC)

clean:
	rm -rf *o hello

cc:
	$(CC) -c *c $(CFLAGS)

asm:
	$(ASM) start.s -f elf -o start.o

link: cc asm
	$(CC) -T $(LD) -o $(OS).bin $(LDFLAGS) $(SOURCES) -lgcc
	cp $(OS).bin $(ISO)/boot/$(OS).bin
	grub-mkrescue -o $(OS).iso $(ISO)
	cp $(OS).iso bin
	
run:	
	$(EMULATOR) -monitor stdio -cdrom ./bin/$(OS).iso
