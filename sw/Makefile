CROSS_COMPILE = /opt/riscv32i/bin/riscv32-unknown-elf-

CC      =	$(CROSS_COMPILE)gcc
LD      =	$(CROSS_COMPILE)ld
OBJDUMP =	$(CROSS_COMPILE)objdump
OBJCOPY =	$(CROSS_COMPILE)objcopy
SIZE    =	$(CROSS_COMPILE)size

CFLAGS  = -march=rv32i -mabi=ilp32 -Wextra -pedantic -ffreestanding -nostartfiles
POINTERS = -T script.ld

DEFINES	= include
DRIVERS = src/drivers

MAIN = src/main.c

coe:
	make hex
	sed -e '1 s/^/memory_initialization_radix=16;\nmemory_initialization_vector=\n/;' data.hex > hex.coe

hex: 
	make clean
	$(CC) $(MAIN) $(DRIVERS:%=-I %) $(DEFINES:%=-I%) $(CFLAGS) $(POINTERS) -o main.elf
	$(OBJCOPY) -O verilog main.elf data_t
	$(OBJDUMP) -D main.elf > disasm_boot.S
	sed -i -e "1d" data_t
	sed s/' '//g -i data_t
	sed -i -e 's/.\{8\}/&\n/g' data_t
	sed -i -e "s/\ /,\ /g" data_t
	grep "\S" data_t > data.hex
	rm -f data_t

test:
	$(RISCV)/riscv32-unknown-elf-objcopy --info
help:
	$(OBJCOPY) --help

clean:
	rm -f hex.coe
	rm -f data.hex
	rm -f main.elf
	rm -f a.out
	rm -f disasm_boot.S
