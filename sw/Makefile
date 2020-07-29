CROSS_COMPILE = /opt/riscv32i/bin/riscv32-unknown-elf-

CC      =	$(CROSS_COMPILE)gcc
LD      =	$(CROSS_COMPILE)ld
OBJDUMP =	$(CROSS_COMPILE)objdump
OBJCOPY =	$(CROSS_COMPILE)objcopy
SIZE    =	$(CROSS_COMPILE)size

CFLAGS  = -march=rv32i -mabi=ilp32 -Wextra -pedantic -ffreestanding -nostartfiles 
POINTERS = -T script.ld ##-Ttext=0x0000##

DEFINES	= include
ICLUDE = include/ethernet_protocol
DRIVERS = src/drivers

MAIN = src/main.c
SRC = src/ethernet_protocol/ethernet_protocol.c \
	src/ethernet_protocol/arp_protocol.c

coe:
	make hex
	sed -e '1 s/^/memory_initialization_radix=16;\nmemory_initialization_vector=\n/;' data.hex > hex.coe

hex: 
	make clean
	$(CC) $(MAIN) $(DRIVERS:%=-I %) $(DEFINES:%=-I%) $(ICLUDE:%=-I%) $(SRC:%=-lm %) $(CFLAGS) $(POINTERS) -o main.elf
	$(OBJCOPY) -O verilog -R.comment -R.debug_info -R.debug_line -R.debug_str  main.elf data_t 
	$(OBJDUMP) -D main.elf > disasm_boot.S


help:
	$(OBJCOPY) --help

clean:
	rm -f hex.coe
	rm -f data.hex
	rm -f main.elf
	rm -f a.out
	rm -f disasm_boot.S
