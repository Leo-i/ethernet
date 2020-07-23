MEMORY
{
   rom(RX)   : ORIGIN = 0x0000, LENGTH = 0x6000
   ram(WAIL) : ORIGIN = 0x6000, LENGTH = 0x2000
}

ENTRY(main)

SECTIONS
{
  .text : { *(.text) } > rom
  _data_start = .;
  .data : { *(.data) } > ram AT> rom
  _bss_start = .;
  .bss  : { *(.bss) }  > ram
  _bss_end = .;
}