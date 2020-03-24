`include "boot_jtag.sv"

`timescale 1ns/1ps

`define CLK_PERIOD  40.00ns      // 25 MHz

module jtag_tb ();

  parameter  USE_ZERO_RISCY = 0;
  parameter  RISCY_RV32F    = 0;
  parameter  ZERO_RV32M     = 1;
  parameter  ZERO_RV32E     = 0;

  logic clk;
  logic rst_n;

  always begin
    #(`CLK_PERIOD/2) clk = ~clk;
  end

  localparam RAM_FILENAME_MAXWIDTH = 60;

  jtag_verif #() jv ();

  logic fetch_enable;

  pulpino   #(
    .PLATFORM          ("GENERIC"),
    .USE_ZERO_RISCY    ( USE_ZERO_RISCY ),
    .RISCY_RV32F       ( RISCY_RV32F    ),
    .ZERO_RV32M        ( ZERO_RV32M     ),
    .ZERO_RV32E        ( ZERO_RV32E     )
   ) dut (
    .clk            ( clk           ),
    .rst_n          ( rst_n         ),

    .testmode_i     ( 1'b1          ),
    .fetch_enable_i ( fetch_enable  ),

    .tck_i          ( jv.jtag_if.tck   ),
    .trstn_i        ( jv.jtag_if.trstn ),
    .tms_i          ( jv.jtag_if.tms   ),
    .tdi_i          ( jv.jtag_if.tdi   ),
    .tdo_o          ( jv.jtag_if.tdo   )
  );

  initial begin
    clk = 0;
    rst_n = 0;
    fetch_enable = 1'b0;

    #(100*`CLK_PERIOD);

    rst_n = 1;

    jv.dbg_if.jtag_reset();
    jv.dbg_if.jtag_softreset();
    jv.dbg_if.init();
    jv.dbg_if.axi4_write32(32'h1A10_7008, 1, 32'h0000_0000);
    preload_mem(32768, 32768, 32, 32);

    fetch_enable = 1'b1;

    jv.boot_jtag("gecko_test_text.dat", "gecko_test_data.dat");

    #(2000*`CLK_PERIOD);

    $stop;

  end

  logic [31:0] data_mem[];
  logic [31:0] instr_mem[];

  wire [31:0] instr_addr;
  assign instr_addr = dut.core_region_i.instr_mem.addr_i;

  // always @(posedge clk) assert (instr_addr != 32'b0)
  //   else $warning("zero address is found");

  task preload_mem;
    input integer data_size;
    input integer instr_size;
    input integer data_width;
    input integer instr_width;
    logic [31:0] data;
    integer bidx;
    integer addr;
    integer mem_addr;
    string l2_imem_file;
    string l2_dmem_file;

    begin

    instr_mem = new [instr_size/4];
    data_mem  = new [data_size/4];

    // l2_imem_file = "tail.dat";
    // $readmemh(l2_imem_file, instr_mem);

    // preload instruction memory
    for(addr = 32; addr < instr_size/4; addr = addr) begin

      for(bidx = 0; bidx < instr_width/8; bidx++) begin
        mem_addr = addr / (instr_width/32);
        // data = instr_mem[addr-32];
        data = 32'h0000_0013; // nop instruction

        if (bidx%4 == 0)
          dut.core_region_i.instr_mem.sp_ram_wrap_i.genblk1.sp_ram_i.mem[mem_addr][bidx] = data[ 7: 0];
        else if (bidx%4 == 1)
          dut.core_region_i.instr_mem.sp_ram_wrap_i.genblk1.sp_ram_i.mem[mem_addr][bidx] = data[15: 8];
        else if (bidx%4 == 2)
          dut.core_region_i.instr_mem.sp_ram_wrap_i.genblk1.sp_ram_i.mem[mem_addr][bidx] = data[23:16];
        else if (bidx%4 == 3)
          dut.core_region_i.instr_mem.sp_ram_wrap_i.genblk1.sp_ram_i.mem[mem_addr][bidx] = data[31:24];

        if (bidx%4 == 3) addr++;
      end
    end

  end
  endtask


endmodule
