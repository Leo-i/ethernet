// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "axi_bus.sv"
`include "debug_bus.sv"

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
    input logic               clk /*verilator clocker*/,
    input logic               rst_n,

    //input  logic              clk_sel_i,
    //input  logic              clk_standalone_i,
    input  logic              testmode_i,
    input  logic              fetch_enable_i,
    //input  logic              scan_enable_i,

    //SPI Slave
    input  logic              spi_clk_i /*verilator clocker*/,
    input  logic              spi_cs_i /*verilator clocker*/,
    output logic [1:0]        spi_mode_o,
    output logic              spi_sdo0_o,
    output logic              spi_sdo1_o,
    output logic              spi_sdo2_o,
    output logic              spi_sdo3_o,
    input  logic              spi_sdi0_i,
    input  logic              spi_sdi1_i,
    input  logic              spi_sdi2_i,
    input  logic              spi_sdi3_i,

    //SPI Master0
    output logic              spi0_master_clk_o,
    output logic              spi0_master_csn0_o,
    output logic              spi0_master_csn1_o,
    output logic              spi0_master_csn2_o,
    output logic              spi0_master_csn3_o,
    output logic [1:0]        spi0_master_mode_o,
    output logic              spi0_master_sdo0_o,
    output logic              spi0_master_sdo1_o,
    output logic              spi0_master_sdo2_o,
    output logic              spi0_master_sdo3_o,
    input  logic              spi0_master_sdi0_i,
    input  logic              spi0_master_sdi1_i,
    input  logic              spi0_master_sdi2_i,
    input  logic              spi0_master_sdi3_i,

    //SPI Master1
    output logic              spi1_master_clk_o,
    output logic              spi1_master_csn0_o,
    output logic              spi1_master_csn1_o,
    output logic              spi1_master_csn2_o,
    output logic              spi1_master_csn3_o,
    output logic [1:0]        spi1_master_mode_o,
    output logic              spi1_master_sdo0_o,
    output logic              spi1_master_sdo1_o,
    output logic              spi1_master_sdo2_o,
    output logic              spi1_master_sdo3_o,
    input  logic              spi1_master_sdi0_i,
    input  logic              spi1_master_sdi1_i,
    input  logic              spi1_master_sdi2_i,
    input  logic              spi1_master_sdi3_i,

    input  logic              scl_pad_i,
    output logic              scl_pad_o,
    output logic              scl_padoen_o,
    input  logic              sda_pad_i,
    output logic              sda_pad_o,
    output logic              sda_padoen_o,

    output logic              uart0_tx,
    input  logic              uart0_rx,
    output logic              uart0_rts,
    output logic              uart0_dtr,
    input  logic              uart0_cts,
    input  logic              uart0_dsr,

    output logic              uart1_tx,
    input  logic              uart1_rx,
    output logic              uart1_rts,
    output logic              uart1_dtr,
    input  logic              uart1_cts,
    input  logic              uart1_dsr,

    input  logic       [31:0] gpio_in,
    output logic       [31:0] gpio_out,
    output logic       [31:0] gpio_dir,
    output logic [31:0] [5:0] gpio_padcfg,

    // JTAG signals
    input  logic              tck_i,
    input  logic              trstn_i,
    input  logic              tms_i,
    input  logic              tdi_i,
    output logic              tdo_o,

    // PULPino specific pad config
    output logic [31:0] [5:0] pad_cfg_o,
    output logic       [31:0] pad_mux_o,

    input  logic              can_rx_i,
    output logic              can_tx_o,
    output logic              can_bus_off_on
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

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH     ),
    .AXI_ID_WIDTH   ( `AXI_ID_SLAVE_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH     )
  )
  slaves[2:0]();

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  masters[2:0]();

  DEBUG_BUS
  debug();

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
    .fetch_enable_i ( fetch_enable_int  ),
    .irq_i          ( irq_to_core_int   ),
    .core_busy_o    ( core_busy_int     ),
    .clock_gating_i ( clk_gate_core_int ),
    .boot_addr_i    ( boot_addr_int     ),

    .core_master    ( masters[0]        ),
    .dbg_master     ( masters[1]        ),
    .data_slave     ( slaves[1]         ),
    .instr_slave    ( slaves[0]         ),
    .debug          ( debug             ),

    .tck_i          ( tck_i             ),
    .trstn_i        ( trstn_i           ),
    .tms_i          ( tms_i             ),
    .tdi_i          ( tdi_i             ),
    .tdo_o          ( tdo_o             )
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
    .clk_i           ( clk_int           ),
    .rst_n           ( rstn_int          ),

    .axi_spi_master  ( masters[2]        ),
    .debug           ( debug             ),

    .spi_clk_i       ( spi_clk_i         ),
    .testmode_i      ( testmode_i        ),
    .spi_cs_i        ( spi_cs_i          ),
    .spi_mode_o      ( spi_mode_o        ),
    .spi_sdo0_o      ( spi_sdo0_o        ),
    .spi_sdo1_o      ( spi_sdo1_o        ),
    .spi_sdo2_o      ( spi_sdo2_o        ),
    .spi_sdo3_o      ( spi_sdo3_o        ),
    .spi_sdi0_i      ( spi_sdi0_i        ),
    .spi_sdi1_i      ( spi_sdi1_i        ),
    .spi_sdi2_i      ( spi_sdi2_i        ),
    .spi_sdi3_i      ( spi_sdi3_i        ),

    .slave           ( slaves[2]         ),

    .uart0_tx         ( uart0_tx         ),
    .uart0_rx         ( uart0_rx         ),
    .uart0_rts        ( uart0_rts        ),
    .uart0_dtr        ( uart0_dtr        ),
    .uart0_cts        ( uart0_cts        ),
    .uart0_dsr        ( uart0_dsr        ),

    .uart1_tx         ( uart1_tx         ),
    .uart1_rx         ( uart1_rx         ),
    .uart1_rts        ( uart1_rts        ),
    .uart1_dtr        ( uart1_dtr        ),
    .uart1_cts        ( uart1_cts        ),
    .uart1_dsr        ( uart1_dsr        ),

    .spi0_master_clk  ( spi0_master_clk_o  ),
    .spi0_master_csn0 ( spi0_master_csn0_o ),
    .spi0_master_csn1 ( spi0_master_csn1_o ),
    .spi0_master_csn2 ( spi0_master_csn2_o ),
    .spi0_master_csn3 ( spi0_master_csn3_o ),
    .spi0_master_mode ( spi0_master_mode_o ),
    .spi0_master_sdo0 ( spi0_master_sdo0_o ),
    .spi0_master_sdo1 ( spi0_master_sdo1_o ),
    .spi0_master_sdo2 ( spi0_master_sdo2_o ),
    .spi0_master_sdo3 ( spi0_master_sdo3_o ),
    .spi0_master_sdi0 ( spi0_master_sdi0_i ),
    .spi0_master_sdi1 ( spi0_master_sdi1_i ),
    .spi0_master_sdi2 ( spi0_master_sdi2_i ),
    .spi0_master_sdi3 ( spi0_master_sdi3_i ),

    .spi1_master_clk  ( spi1_master_clk_o  ),
    .spi1_master_csn0 ( spi1_master_csn0_o ),
    .spi1_master_csn1 ( spi1_master_csn1_o ),
    .spi1_master_csn2 ( spi1_master_csn2_o ),
    .spi1_master_csn3 ( spi1_master_csn3_o ),
    .spi1_master_mode ( spi1_master_mode_o ),
    .spi1_master_sdo0 ( spi1_master_sdo0_o ),
    .spi1_master_sdo1 ( spi1_master_sdo1_o ),
    .spi1_master_sdo2 ( spi1_master_sdo2_o ),
    .spi1_master_sdo3 ( spi1_master_sdo3_o ),
    .spi1_master_sdi0 ( spi1_master_sdi0_i ),
    .spi1_master_sdi1 ( spi1_master_sdi1_i ),
    .spi1_master_sdi2 ( spi1_master_sdi2_i ),
    .spi1_master_sdi3 ( spi1_master_sdi3_i ),

    .scl_pad_i       ( scl_pad_i         ),
    .scl_pad_o       ( scl_pad_o         ),
    .scl_padoen_o    ( scl_padoen_o      ),
    .sda_pad_i       ( sda_pad_i         ),
    .sda_pad_o       ( sda_pad_o         ),
    .sda_padoen_o    ( sda_padoen_o      ),

    .gpio_in         ( gpio_in           ),
    .gpio_out        ( gpio_out          ),
    .gpio_dir        ( gpio_dir          ),
    .gpio_padcfg     ( gpio_padcfg       ),

    .core_busy_i     ( core_busy_int     ),
    .irq_o           ( irq_to_core_int   ),
    .fetch_enable_i  ( fetch_enable_i    ),
    .fetch_enable_o  ( fetch_enable_int  ),
    .clk_gate_core_o ( clk_gate_core_int ),

    .fll1_req_o      ( cfgreq_fll_int    ),
    .fll1_wrn_o      ( cfgweb_n_fll_int  ),
    .fll1_add_o      ( cfgad_fll_int     ),
    .fll1_wdata_o    ( cfgd_fll_int      ),
    .fll1_ack_i      ( cfgack_fll_int    ),
    .fll1_rdata_i    ( cfgq_fll_int      ),
    .fll1_lock_i     ( lock_fll_int      ),
    .pad_cfg_o       ( pad_cfg_o         ),
    .pad_mux_o       ( pad_mux_o         ),
    .boot_addr_o     ( boot_addr_int     )
  );


  //----------------------------------------------------------------------------//
  // Axi node
  //----------------------------------------------------------------------------//

  axi_node_intf_wrap
  #(
    .NB_MASTER      ( 3                    ),
    .NB_SLAVE       ( 3                    ),
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  axi_interconnect_i
  (
    .clk       ( clk_int    ),
    .rst_n     ( rstn_int   ),
    .test_en_i ( testmode_i ),

    .master    ( slaves     ),
    .slave     ( masters    ),

    .start_addr_i ( { 32'h1A10_0000, 32'h0010_0000, 32'h0000_0000 } ),
    .end_addr_i   ( { 32'h1A11_FFFF, 32'h001F_FFFF, 32'h000F_FFFF } )
  );

endmodule

