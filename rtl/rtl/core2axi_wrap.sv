// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.



module core2axi_wrap
#(
    parameter AXI_ADDR_WIDTH   = 32,
    parameter AXI_DATA_WIDTH   = 32,
    parameter AXI_USER_WIDTH   = 6,
    parameter AXI_ID_WIDTH     = 6,
    parameter REGISTERED_GRANT = "FALSE"
)
(
    input logic                       clk_i,
    input logic                       rst_ni,

    input  logic                      data_req_i,
    output logic                      data_gnt_o,
    output logic                      data_rvalid_o,
    input  logic [AXI_ADDR_WIDTH-1:0] data_addr_i,
    input  logic                      data_we_i,
    input  logic [3:0]                data_be_i,
    output logic [31:0]               data_rdata_o,
    input  logic [31:0]               data_wdata_i,

    AXI_LITE.master                   master
);


  //********************************************************
  //************** AXI2APB WRAPER **************************
  //********************************************************
  core2axi
  #(
    .AXI4_ADDRESS_WIDTH ( AXI_ADDR_WIDTH   ),
    .AXI4_RDATA_WIDTH   ( AXI_DATA_WIDTH   ),
    .AXI4_WDATA_WIDTH   ( AXI_DATA_WIDTH   ),
    .AXI4_ID_WIDTH      ( AXI_ID_WIDTH     ),
    .AXI4_USER_WIDTH    ( AXI_USER_WIDTH   ),
    .REGISTERED_GRANT   ( REGISTERED_GRANT )
  )
  core2axi_i
  (
    .clk_i         ( clk_i               ),
    .rst_ni        ( rst_ni              ),

    .data_req_i    ( data_req_i          ),
    .data_gnt_o    ( data_gnt_o          ),
    .data_rvalid_o ( data_rvalid_o       ),
    .data_addr_i   ( data_addr_i         ),
    .data_we_i     ( data_we_i           ),
    .data_be_i     ( data_be_i           ),
    .data_rdata_o  ( data_rdata_o        ),
    .data_wdata_i  ( data_wdata_i        ),
    .axi_core      ( master              )
    
  );

endmodule
