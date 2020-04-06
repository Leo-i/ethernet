// Copyright 2015 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`define OKAY   2'b00
`define EXOKAY 2'b01
`define SLVERR 2'b10
`define DECERR 2'b11

module core2axi
#(
    parameter AXI4_ADDRESS_WIDTH = 32,
    parameter AXI4_RDATA_WIDTH   = 32,
    parameter AXI4_WDATA_WIDTH   = 32,
    parameter AXI4_ID_WIDTH      = 16,
    parameter AXI4_USER_WIDTH    = 10,
    parameter REGISTERED_GRANT   = "FALSE"           // "TRUE"|"FALSE"
)
(
    // Clock and Reset
    input logic                           clk_i,
    input logic                           rst_ni,

    input  logic                          data_req_i,
    output logic                          data_gnt_o,
    output logic                          data_rvalid_o,
    input  logic [AXI4_ADDRESS_WIDTH-1:0] data_addr_i,
    input  logic                          data_we_i,
    input  logic [3:0]                    data_be_i,
    output logic [31:0]                   data_rdata_o,
    input  logic [31:0]                   data_wdata_i,

    AXI_LITE.master                       axi_core
);

assign axi_core.aclk    = clk_i;
assign axi_core.aresetn = rst_ni;

endmodule
