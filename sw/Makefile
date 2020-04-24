
RISCV = /opt/riscv32i/bin

coe: 
	make clean
	$(RISCV)/riscv32-unknown-elf-gcc src/main.c -march=rv32i -mabi=ilp32 -Wall -Wextra -pedantic -ffreestanding -nostartfiles -Ttext=0x0 
	$(RISCV)/riscv32-unknown-elf-objdump --disassemble a.out -M numeric -M no-aliases > dump
	$(RISCV)/riscv32-unknown-elf-objcopy -O verilog -R.comment -R.debug_info -R.debug_line -R.debug_str --reverse-bytes=4 --verilog-data-width 4  a.out hex.coe
	sed -i -e "1d" hex.coe
	sed -i -e "s/\ /,\ /g" hex.coe
	sed -i -e '1 s/^/memory_initialization_radix=16;\nmemory_initialization_vector=\n/;' hex.coe

hex: 
	$(RISCV)/riscv32-unknown-elf-gcc src/main.c -march=rv32i -mabi=ilp32 -Wall -Wextra -pedantic -ffreestanding -nostartfiles -Ttext=0x0000 
	$(RISCV)/riscv32-unknown-elf-objdump --disassemble a.out -M numeric -M no-aliases > dump
	$(RISCV)/riscv32-unknown-elf-objcopy -O verilog -R.comment -R.debug_info -R.debug_line -R.debug_str --reverse-bytes=4  a.out hex

clean:
	rm -f dump
	rm -f hex
	rm -f hex.coe
	rm -f a.out