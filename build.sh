echo Oo_oO
# echo Now assembling, compiling, and linking your kernel:
# nasm -f aout -o start.o start.asm
# Remember this spot here: We will add 'i686-elf-gcc' commands here to compile C sources
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o main.o main.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o scrn.o scrn.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o gdt.o gdt.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o idt.o idt.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o isrs.o isrs.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o irq.o irq.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o timer.o timer.c
#gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -I./include -c -o kb.o kb.c
#ld -T link.ld -o kernel.bin start.o main.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o

nasm -f elf -o start.o start.s

i686-elf-gcc -c main.c -o main.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c scrn.c -o scrn.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c gdt.c -o gdt.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c idt.c -o idt.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c isrs.c -o isrs.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c irq.c -o irq.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c timer.c -o timer.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c kb.c -o kb.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include

file main.o
file scrn.o
file gdt.o
file idt.o
file isrs.o
file irq.o
file timer.o
file kb.o
file start.o

# i686-elf-gcc -T link.ld -o kernel.bin start.o main.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o
i686-elf-gcc -T link.ld -o myos.bin -ffreestanding -O2 -nostdlib start.o main.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o -lgcc

