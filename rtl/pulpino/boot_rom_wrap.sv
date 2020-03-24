// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


`include "config.sv"

module boot_rom_wrap
  #(
    parameter PLATFORM       = "GENERIC",
    parameter BOOT_FILE      = "",
    parameter BOOT_CODE_SIZE = 234,
    parameter ADDR_WIDTH     = `ROM_ADDR_WIDTH,
    parameter DATA_WIDTH     = 32
  )(
    // Clock and Reset
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  en_i,
    input  logic [ADDR_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] rdata_o
  );



//  `ifdef FPGA
//    RAM_boot
//    #(INSTR_SIZE,
//      MEM_FILE_NAME)
//    RAM_boot_i
//    (
//      .CLK   ( clk                    ),
//      .RSTN  ( rst_n                  ),
//      .CSN   ( ~en_i                  ),
//      .A     ( addr_i[ADDR_WIDTH-1:2] ),
//      .Q     ( rdata_o                )
//    );   
//  `else
//    boot_code_latch
//    boot_code_i
//    (
//      .CLK   ( clk                    ),
//      .RSTN  ( rst_n                  ),
//      .CSN   ( ~en_i                  ),
//      .A     ( addr_i[ADDR_WIDTH-1:2] ),
//      .Q     ( rdata_o                )
//    );
//  `endif


generate
    
    if (PLATFORM == "GENERIC") begin
      boot_code_latch
      boot_code_i
      (
        .CLK   ( clk                    ),
        .RSTN  ( rst_n                  ),
        .CSN   ( ~en_i                  ),
        .A     ( addr_i[ADDR_WIDTH-1:2] ),
        .Q     ( rdata_o                )
      );
    end

    else if(PLATFORM == "XILINX_7_SERIES") begin
      boot_rom
      #(
        .BOOT_FILE      ( BOOT_FILE      ),
        .BOOT_CODE_SIZE ( BOOT_CODE_SIZE ),
        .DATA_WIDTH     ( DATA_WIDTH     ),
        .ADDR_WIDTH     ( ADDR_WIDTH - 2 )
      )
      boot_code_i
      (
        .clk_i   ( clk                    ),
        .rst_n_i ( rst_n                  ),
        .en_i    ( en_i                  ),
        .addr_i  ( addr_i[ADDR_WIDTH-1:2] ),
        .rdata_o ( rdata_o                )
      );

    end

    else begin // Generate error
      illegal_platform_parameter_at_boot_rom non_existing_module();
    end

  endgenerate

endmodule