`timescale 1ns/1ps

`define SUSPEND_CPU0 16'b1
`define RESUME_CPU0  16'b0

`include "tb_jtag_pkg.sv"

module jtag_verif;

  jtag_i jtag_if();
  adv_dbg_if_t dbg_if = new(jtag_if);

  int instr_fid;
  int data_fid;
  logic [254:0][31:0] instr;
  logic [254:0][31:0] data;
  logic [7:0] nwords;
  int         nwrites;

  task boot_jtag (
      input logic [255:0] instr_file,
      input logic [255:0] data_file
    );

    dbg_if.cpu_stall( `SUSPEND_CPU0 );
    dbg_if.cpu_wait_for_stall();

    instr_fid = $fopen(instr_file,"r");
    data_fid  = $fopen(data_file,"r");

    // write to instruction memory
    nwords = 0;
    nwrites = 0;
    if (!instr_fid) begin
      $display("Could not open instruction file, %s", instr_file);
      $stop;
    end
    else begin
      while ( !$feof(instr_fid) ) begin
        $fscanf(instr_fid, "%h\n", instr[nwords]);
        nwords++;
        if (nwords == 8'd255) begin
          dbg_if.axi4_write32( 32'h0000_0000 + nwrites*1020, nwords, instr );
          nwrites++;
          nwords = 0;
        end
      end
    end


    dbg_if.axi4_write32( 32'h0000_0000 + nwrites*1020, nwords, instr );

    $display("Loading to instruction memory is completed");

    // write to data memory
    nwords = 0;
    nwrites = 0;
    if (!data_fid) begin
      $display("Could not open data file");
      $stop;
    end
    else begin
      while ( !$feof(data_fid) ) begin
        $fscanf(data_fid, "%h\n", data[nwords]);
        nwords++;
        if (nwords == 8'd255) begin
          dbg_if.axi4_write32( 32'h0010_0000 + nwrites*1020, nwords, data );
          nwrites++;
          nwords = 0;
        end
      end
    end

    dbg_if.axi4_write32( 32'h0010_0000 + nwrites*1020, nwords, data );

    $display("Loading to data memory is completed");

    dbg_if.axi4_write32( 32'h1A11_2000, 1, 32'h0000_0080 ); // set PC for 0x80

    dbg_if.cpu_stall( `RESUME_CPU0 );

    $display("CPU resumed");

  endtask : boot_jtag

endmodule
