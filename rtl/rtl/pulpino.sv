// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


`define AXI_ADDR_WIDTH         32
`define AXI_DATA_WIDTH         32
`define AXI_ID_MASTER_WIDTH     2
`define AXI_ID_SLAVE_WIDTH      4
`define AXI_USER_WIDTH          1
`define ROM_START_ADDR       16'h8080

module pulpino
  #(
    parameter PLATFORM             = "XILINX_7_SERIES",
    parameter BOOT_FILE            = "",
    parameter USE_ZERO_RISCY       = 0,
    parameter RISCY_RV32F          = 0,
    parameter ZERO_RV32M           = 1,
    parameter ZERO_RV32E           = 0,
    parameter BOOT_CODE_SIZE       = 8192
  )
  (
    // Clock and Reset
    input                     clk,          
    input                     clk_50_mhz,   
    input                     clk_50_mhz_90,
    input                     clk_25_mhz,   
    input logic               rst_n,

    input  logic              testmode_i,
    input  logic              fetch_enable_i,

    RMII.master               rmii_1,
    RMII.master               rmii_2,

    output                    uart_tx,
    input                     uart_rx,

    input        [3:0]        btn,
    output       [7:0]        led,

    // JTAG signals
    input  logic              tck_i,
    input  logic              trstn_i,
    input  logic              tms_i,
    input  logic              tdi_i,
    output logic              tdo_o

  );

  logic        clk_int;

  logic        fetch_enable_int;
  logic        core_busy_int;
  logic        clk_gate_core_int;
  logic [31:0] irq_to_core_int;

  logic        lock_fll_int;
  logic        cfgreq_fll_int;
  logic        cfgack_fll_int;
  logic [1:0]  cfgad_fll_int;
  logic [31:0] cfgd_fll_int;
  logic [31:0] cfgq_fll_int;
  logic        cfgweb_n_fll_int;
  logic        rstn_int;
  logic [31:0] boot_addr_int;


  AXI_LITE core_master();


  //----------------------------------------------------------------------------//
  // Clock and reset generation
  //----------------------------------------------------------------------------//
  clk_rst_gen
  clk_rst_gen_i
  (
      .clk_i            ( clk              ),
      .rstn_i           ( rst_n            ),

      //.clk_sel_i        ( clk_sel_i        ),
      //.clk_standalone_i ( clk_standalone_i ),
      .testmode_i       ( testmode_i       ),
      //.scan_i           ( 1'b0             ),
      //.scan_o           (                  ),
      //.scan_en_i        ( scan_enable_i    ),

      .fll_req_i        ( cfgreq_fll_int   ),
      .fll_wrn_i        ( cfgweb_n_fll_int ),
      .fll_add_i        ( cfgad_fll_int    ),
      .fll_data_i       ( cfgd_fll_int     ),
      .fll_ack_o        ( cfgack_fll_int   ),
      .fll_r_data_o     ( cfgq_fll_int     ),
      .fll_lock_o       ( lock_fll_int     ),

      .clk_o            ( clk_int          ),
      .rstn_o           ( rstn_int         )

    );

  //----------------------------------------------------------------------------//
  // Core region
  //----------------------------------------------------------------------------//
  core_region
  #(
    .PLATFORM             ( PLATFORM             ),
    .BOOT_FILE            ( BOOT_FILE            ),
    .AXI_ADDR_WIDTH       ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH       ( `AXI_DATA_WIDTH      ),
    .AXI_ID_MASTER_WIDTH  ( `AXI_ID_MASTER_WIDTH ),
    .AXI_ID_SLAVE_WIDTH   ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_USER_WIDTH       ( `AXI_USER_WIDTH      ),
    .USE_ZERO_RISCY       (  USE_ZERO_RISCY      ),
    .RISCY_RV32F          (  RISCY_RV32F         ),
    .ZERO_RV32M           (  ZERO_RV32M          ),
    .ZERO_RV32E           (  ZERO_RV32E          ),
    .BOOT_CODE_SIZE       (  BOOT_CODE_SIZE      )
  )
  core_region_i
  (
    .clk            ( clk_int           ),
    .rst_n          ( rstn_int          ),

    .testmode_i     ( testmode_i        ),
    .fetch_enable_i ( 1'b1              ),
    .irq_i          ( 32'h0             ),
    .core_busy_o    ( core_busy_int     ),
    .clock_gating_i ( 1'b1              ),
    .boot_addr_i    ( 32'h00008080      ),

    .core_master    ( core_master       )

  );

  //----------------------------------------------------------------------------//
  // Peripherals
  //----------------------------------------------------------------------------//
  peripherals
  #(
    .PLATFORM            ( PLATFORM             ),
    .AXI_ADDR_WIDTH      ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH      ( `AXI_DATA_WIDTH      ),
    .AXI_SLAVE_ID_WIDTH  ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_MASTER_ID_WIDTH ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH      ( `AXI_USER_WIDTH      ),
    .ROM_START_ADDR      ( `ROM_START_ADDR      )
  )
  peripherals_i
  (
    .clk_50_mhz      ( clk_50_mhz           ),
    .clk_25_mhz      ( clk_25_mhz           ),

    .core_master     ( core_master          ),
    .uart_tx         ( uart_tx              ),
    .uart_rx         ( uart_rx              ),

    .rmii_1          (rmii_1                ),
    .rmii_2          (rmii_2                ),

    .led             ( led                  )
  );


  //----------------------------------------------------------------------------//
  // Axi node
  //----------------------------------------------------------------------------//


endmodule

