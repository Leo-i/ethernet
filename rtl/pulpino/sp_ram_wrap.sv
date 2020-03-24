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

module sp_ram_wrap
  #(
    parameter PLATFORM   = "GENERIC",
    parameter RAM_SIZE   = 32768,              // in bytes
    parameter ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter DATA_WIDTH = 32
  )(
    // Clock and Reset
    input  logic                    clk,
    input  logic                    rstn_i,
    input  logic                    en_i,
    input  logic [ADDR_WIDTH-1:0]   addr_i,
    input  logic [DATA_WIDTH-1:0]   wdata_i,
    output logic [DATA_WIDTH-1:0]   rdata_o,
    input  logic                    we_i,
    input  logic [DATA_WIDTH/8-1:0] be_i,
    input  logic                    bypass_en_i
  );

//`ifdef PULP_FPGA_EMUL
//  sp_ram
//  #(
//    .ADDR_WIDTH ( ADDR_WIDTH ),
//    .DATA_WIDTH ( DATA_WIDTH ),
//    .NUM_WORDS  ( RAM_SIZE   )
//  )
//  sp_ram_i
//  (
//    .clk     ( clk       ),
//
//    .en_i    ( en_i      ),
//    .addr_i  ( addr_i    ),
//    .wdata_i ( wdata_i   ),
//    .rdata_o ( rdata_o   ),
//    .we_i    ( we_i      ),
//    .be_i    ( be_i      )
//  );
//
//  // TODO: we should kill synthesis when the ram size is larger than what we
//  // have here
//
//`elsif ASIC
//   // RAM bypass logic
//   logic [31:0] ram_out_int;
//   // assign rdata_o = (bypass_en_i) ? wdata_i : ram_out_int;
//   assign rdata_o = ram_out_int;
//
//   sp_ram_bank
//   #(
//    .NUM_BANKS  ( RAM_SIZE/4096 ),
//    .BANK_SIZE  ( 1024          )
//   )
//   sp_ram_bank_i
//   (
//    .clk_i   ( clk                     ),
//    .rstn_i  ( rstn_i                  ),
//    .en_i    ( en_i                    ),
//    .addr_i  ( addr_i                  ),
//    .wdata_i ( wdata_i                 ),
//    .rdata_o ( ram_out_int             ),
//    .we_i    ( (we_i & ~bypass_en_i)   ),
//    .be_i    ( be_i                    )
//   );
//
//`else
//  sp_ram
//  #(
//    .ADDR_WIDTH ( ADDR_WIDTH ),
//    .DATA_WIDTH ( DATA_WIDTH ),
//    .NUM_WORDS  ( RAM_SIZE   )
//  )
//  sp_ram_i
//  (
//    .clk     ( clk       ),

//    .en_i    ( en_i      ),
//    .addr_i  ( addr_i    ),
//    .wdata_i ( wdata_i   ),
//    .rdata_o ( rdata_o   ),
//    .we_i    ( we_i      ),
//    .be_i    ( be_i      )
//  );
//`endif

generate
    
    if (PLATFORM == "GENERIC") begin
      sp_ram
      #(
        .ADDR_WIDTH ( ADDR_WIDTH ),
        .DATA_WIDTH ( DATA_WIDTH ),
        .NUM_WORDS  ( RAM_SIZE   )
      )
      sp_ram_i
      (
         .clk     ( clk       ),

         .en_i    ( en_i      ),
         .addr_i  ( addr_i    ),
         .wdata_i ( wdata_i   ),
         .rdata_o ( rdata_o   ),
         .we_i    ( we_i      ),
         .be_i    ( be_i      )
       );
    end

    else if(PLATFORM == "XILINX_7_SERIES" &&  RAM_SIZE == 32768 && DATA_WIDTH == 32) begin
      
      logic [ADDR_WIDTH-1-$clog2(DATA_WIDTH/8):0] addr;
      assign addr = addr_i[ADDR_WIDTH-1:$clog2(DATA_WIDTH/8)];
      
      sp_ram_xilinx_8192x32 sp_ram_i (
        .clka  ( clk              ),     // input wire clka
        .ena   ( en_i             ),     // input wire ena
        .wea   ( be_i & {4{we_i}} ),     // input wire [3 : 0] wea
        .addra ( addr             ),     // input wire [12 : 0] addra
        .dina  ( wdata_i          ),     // input wire [31 : 0] dina
        .douta ( rdata_o          )      // output wire [31 : 0] douta
      );

    end

    else begin // Generate error
      illegal_platform_parameter_at_sp_ram_wrap non_existing_module();
    end

  endgenerate

endmodule
