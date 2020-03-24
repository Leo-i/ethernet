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
`include "apb_bus.sv"
`include "debug_bus.sv"
`include "config.sv"

module peripherals
  #(
    parameter PLATFORM             = "GENERIC",
    parameter AXI_ADDR_WIDTH       = 32,
    parameter AXI_DATA_WIDTH       = 64,
    parameter AXI_USER_WIDTH       = 6,
    parameter AXI_SLAVE_ID_WIDTH   = 6,
    parameter AXI_MASTER_ID_WIDTH  = 6,
    parameter ROM_START_ADDR       = 32'h8000
  )
  (
    // Clock and Reset
    input logic clk_i,
    input logic rst_n,

    AXI_BUS.Master axi_spi_master,

    DEBUG_BUS.Master debug,

    input  logic             spi_clk_i,
    input  logic             testmode_i,
    input  logic             spi_cs_i,
    output logic [1:0]       spi_mode_o,
    output logic             spi_sdo0_o,
    output logic             spi_sdo1_o,
    output logic             spi_sdo2_o,
    output logic             spi_sdo3_o,
    input  logic             spi_sdi0_i,
    input  logic             spi_sdi1_i,
    input  logic             spi_sdi2_i,
    input  logic             spi_sdi3_i,

    AXI_BUS.Slave  slave,

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

    output logic              spi0_master_clk,
    output logic              spi0_master_csn0,
    output logic              spi0_master_csn1,
    output logic              spi0_master_csn2,
    output logic              spi0_master_csn3,
    output logic       [1:0]  spi0_master_mode,
    output logic              spi0_master_sdo0,
    output logic              spi0_master_sdo1,
    output logic              spi0_master_sdo2,
    output logic              spi0_master_sdo3,
    input  logic              spi0_master_sdi0,
    input  logic              spi0_master_sdi1,
    input  logic              spi0_master_sdi2,
    input  logic              spi0_master_sdi3,

    output logic              spi1_master_clk,
    output logic              spi1_master_csn0,
    output logic              spi1_master_csn1,
    output logic              spi1_master_csn2,
    output logic              spi1_master_csn3,
    output logic       [1:0]  spi1_master_mode,
    output logic              spi1_master_sdo0,
    output logic              spi1_master_sdo1,
    output logic              spi1_master_sdo2,
    output logic              spi1_master_sdo3,
    input  logic              spi1_master_sdi0,
    input  logic              spi1_master_sdi1,
    input  logic              spi1_master_sdi2,
    input  logic              spi1_master_sdi3,

    input  logic              scl_pad_i,
    output logic              scl_pad_o,
    output logic              scl_padoen_o,
    input  logic              sda_pad_i,
    output logic              sda_pad_o,
    output logic              sda_padoen_o,

    input  logic       [31:0] gpio_in,
    output logic       [31:0] gpio_out,
    output logic       [31:0] gpio_dir,
    output logic [31:0] [5:0] gpio_padcfg,

    input  logic              core_busy_i,
    output logic [31:0]       irq_o,
    input  logic              fetch_enable_i,
    output logic              fetch_enable_o,
    output logic              clk_gate_core_o,

    output logic              fll1_req_o,
    output logic              fll1_wrn_o,
    output logic [1:0]        fll1_add_o,
    output logic [31:0]       fll1_wdata_o,
    input  logic              fll1_ack_i,
    input  logic [31:0]       fll1_rdata_i,
    input  logic              fll1_lock_i,

    output logic [31:0] [5:0] pad_cfg_o,
    output logic       [31:0] pad_mux_o,
    output logic       [31:0] boot_addr_o
  );

  localparam APB_ADDR_WIDTH  = 32;
  localparam APB_NUM_SLAVES  = 11;

  APB_BUS s_apb_bus();

  APB_BUS s_uart0_bus();
  APB_BUS s_uart1_bus();
  APB_BUS s_gpio_bus();
  APB_BUS s_spi0_bus();
  APB_BUS s_spi1_bus();
  APB_BUS s_timer0_bus();
  APB_BUS s_timer1_bus();
  APB_BUS s_event_unit_bus();
  APB_BUS s_i2c_bus();
  APB_BUS s_fll_bus();
  APB_BUS s_soc_ctrl_bus();
  APB_BUS s_debug_bus();

  logic [1:0]   s_spim0_event;
  logic [1:0]   s_spim1_event;
  logic [3:0]   timer0_irq;
  logic [3:0]   timer1_irq;
  logic [31:0]  peripheral_clock_gate_ctrl;
  logic [31:0]  clk_int;
  logic         s_uart0_event;
  logic         s_uart1_event;
  logic         i2c_event;
  logic         s_gpio_event;

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// Peripheral Clock Gating                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  generate
     genvar i;
       for (i = 0; i < APB_NUM_SLAVES; i = i + 1) begin
        cluster_clock_gating core_clock_gate
        (
          .clk_o     ( clk_int[i]                    ),
          .en_i      ( peripheral_clock_gate_ctrl[i] ),
          .test_en_i ( testmode_i                    ),
          .clk_i     ( clk_i                         )
        );
      end
   endgenerate

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// SPI Slave, AXI Master                                      ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  axi_spi_slave_wrap
  #(
    .AXI_ADDRESS_WIDTH  ( AXI_ADDR_WIDTH       ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH       ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH       ),
    .AXI_ID_WIDTH       ( AXI_MASTER_ID_WIDTH  )
  )
  axi_spi_slave_i
  (
    .clk_i      ( clk_int[0]     ),
    .rst_ni     ( rst_n          ),

    .test_mode  ( testmode_i     ),

    .axi_master ( axi_spi_master ),

    .spi_clk    ( spi_clk_i      ),
    .spi_cs     ( spi_cs_i       ),
    .spi_mode   ( spi_mode_o     ),
    .spi_sdo0   ( spi_sdo0_o     ),
    .spi_sdo1   ( spi_sdo1_o     ),
    .spi_sdo2   ( spi_sdo2_o     ),
    .spi_sdo3   ( spi_sdo3_o     ),
    .spi_sdi0   ( spi_sdi0_i     ),
    .spi_sdi1   ( spi_sdi1_i     ),
    .spi_sdi2   ( spi_sdi2_i     ),
    .spi_sdi3   ( spi_sdi3_i     )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// AXI2APB Bridge                                             ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  axi2apb_wrap
  #(
      .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
      .AXI_DATA_WIDTH ( AXI_DATA_WIDTH     ),
      .AXI_USER_WIDTH ( AXI_USER_WIDTH     ),
      .AXI_ID_WIDTH   ( AXI_SLAVE_ID_WIDTH ),
      .APB_ADDR_WIDTH ( APB_ADDR_WIDTH     )
  )
  axi2apb_i
  (
    .clk_i     ( clk_i      ),
    .rst_ni    ( rst_n      ),
    .test_en_i ( testmode_i ),

    .axi_slave ( slave      ),

    .apb_master( s_apb_bus  )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Bus                                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  periph_bus_wrap
  #(
     .APB_ADDR_WIDTH( APB_ADDR_WIDTH ),
     .APB_DATA_WIDTH( 32             )
  )
  periph_bus_i
  (
     .clk_i             ( clk_i            ),
     .rst_ni            ( rst_n            ),

     .apb_slave         ( s_apb_bus        ),

     .uart0_master      ( s_uart0_bus      ),
     .uart1_master      ( s_uart1_bus      ),
     .gpio_master       ( s_gpio_bus       ),
     .spi0_master       ( s_spi0_bus       ),
     .spi1_master       ( s_spi1_bus       ),
     .timer0_master     ( s_timer0_bus     ),
     .timer1_master     ( s_timer1_bus     ),
     .event_unit_master ( s_event_unit_bus ),
     .i2c_master        ( s_i2c_bus        ),
     .fll_master        ( s_fll_bus        ),
     .soc_ctrl_master   ( s_soc_ctrl_bus   ),
     .debug_master      ( s_debug_bus      )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 0: APB UART0 interface                           ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_uart apb_uart0_i (
    .CLK      ( clk_int[1]   ),
    .RSTN     ( rst_n        ),

    .PSEL     ( s_uart0_bus.psel       ),
    .PENABLE  ( s_uart0_bus.penable    ),
    .PWRITE   ( s_uart0_bus.pwrite     ),
    .PADDR    ( s_uart0_bus.paddr[4:2] ),
    .PWDATA   ( s_uart0_bus.pwdata     ),
    .PRDATA   ( s_uart0_bus.prdata     ),
    .PREADY   ( s_uart0_bus.pready     ),
    .PSLVERR  ( s_uart0_bus.pslverr    ),

    .INT      ( s_uart0_event ),   //Interrupt output

    .OUT1N    (),                     //Output 1
    .OUT2N    (),                     //Output 2
    .RTSN     ( uart0_rts    ),       //RTS output
    .DTRN     ( uart0_dtr    ),       //DTR output
    .CTSN     ( uart0_cts    ),       //CTS input
    .DSRN     ( uart0_dsr    ),       //DSR input
    .DCDN     ( 1'b1         ),       //DCD input
    .RIN      ( 1'b1         ),       //RI input
    .SIN      ( uart0_rx     ),
    .SOUT     ( uart0_tx     )
  );

    //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 1: APB UART1 interface                           ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_uart apb_uart1_i (
    .CLK      ( clk_int[2]   ),
    .RSTN     ( rst_n        ),

    .PSEL     ( s_uart1_bus.psel       ),
    .PENABLE  ( s_uart1_bus.penable    ),
    .PWRITE   ( s_uart1_bus.pwrite     ),
    .PADDR    ( s_uart1_bus.paddr[4:2] ),
    .PWDATA   ( s_uart1_bus.pwdata     ),
    .PRDATA   ( s_uart1_bus.prdata     ),
    .PREADY   ( s_uart1_bus.pready     ),
    .PSLVERR  ( s_uart1_bus.pslverr    ),

    .INT      ( s_uart1_event ),   //Interrupt output

    .OUT1N    (),                     //Output 1
    .OUT2N    (),                     //Output 2
    .RTSN     ( uart1_rts    ),       //RTS output
    .DTRN     ( uart1_dtr    ),       //DTR output
    .CTSN     ( uart1_cts    ),       //CTS input
    .DSRN     ( uart1_dsr    ),       //DSR input
    .DCDN     ( 1'b1         ),       //DCD input
    .RIN      ( 1'b1         ),       //RI input
    .SIN      ( uart1_rx     ),
    .SOUT     ( uart1_tx     )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 2: APB GPIO interface                            ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_gpio apb_gpio_i
  (
    .HCLK       ( clk_int[3]   ),
    .HRESETn    ( rst_n        ),

    .PADDR      ( s_gpio_bus.paddr[11:0]),
    .PWDATA     ( s_gpio_bus.pwdata     ),
    .PWRITE     ( s_gpio_bus.pwrite     ),
    .PSEL       ( s_gpio_bus.psel       ),
    .PENABLE    ( s_gpio_bus.penable    ),
    .PRDATA     ( s_gpio_bus.prdata     ),
    .PREADY     ( s_gpio_bus.pready     ),
    .PSLVERR    ( s_gpio_bus.pslverr    ),

    .gpio_in      ( gpio_in       ),
    .gpio_out     ( gpio_out      ),
    .gpio_dir     ( gpio_dir      ),
    .gpio_padcfg  ( gpio_padcfg   ),
    .interrupt    ( s_gpio_event  )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 3: APB SPI0 Master interface                     ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_spi_master
  #(
      .BUFFER_DEPTH(8)
  )
  apb_spi0_master_i
  (
    .HCLK         ( clk_int[4]   ),
    .HRESETn      ( rst_n        ),

    .PADDR        ( s_spi0_bus.paddr[11:0]),
    .PWDATA       ( s_spi0_bus.pwdata     ),
    .PWRITE       ( s_spi0_bus.pwrite     ),
    .PSEL         ( s_spi0_bus.psel       ),
    .PENABLE      ( s_spi0_bus.penable    ),
    .PRDATA       ( s_spi0_bus.prdata     ),
    .PREADY       ( s_spi0_bus.pready     ),
    .PSLVERR      ( s_spi0_bus.pslverr    ),

    .events_o     ( s_spim0_event ),

    .spi_clk      ( spi0_master_clk  ),
    .spi_csn0     ( spi0_master_csn0 ),
    .spi_csn1     ( spi0_master_csn1 ),
    .spi_csn2     ( spi0_master_csn2 ),
    .spi_csn3     ( spi0_master_csn3 ),
    .spi_mode     ( spi0_master_mode ),
    .spi_sdo0     ( spi0_master_sdo0 ),
    .spi_sdo1     ( spi0_master_sdo1 ),
    .spi_sdo2     ( spi0_master_sdo2 ),
    .spi_sdo3     ( spi0_master_sdo3 ),
    .spi_sdi0     ( spi0_master_sdi0 ),
    .spi_sdi1     ( spi0_master_sdi1 ),
    .spi_sdi2     ( spi0_master_sdi2 ),
    .spi_sdi3     ( spi0_master_sdi3 )
  );

    //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 4: APB SPI1 Master interface                     ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_spi_master
  #(
      .BUFFER_DEPTH(8)
  )
  apb_spi1_master_i
  (
    .HCLK         ( clk_int[5]   ),
    .HRESETn      ( rst_n        ),

    .PADDR        ( s_spi1_bus.paddr[11:0]),
    .PWDATA       ( s_spi1_bus.pwdata     ),
    .PWRITE       ( s_spi1_bus.pwrite     ),
    .PSEL         ( s_spi1_bus.psel       ),
    .PENABLE      ( s_spi1_bus.penable    ),
    .PRDATA       ( s_spi1_bus.prdata     ),
    .PREADY       ( s_spi1_bus.pready     ),
    .PSLVERR      ( s_spi1_bus.pslverr    ),

    .events_o     ( s_spim1_event ),

    .spi_clk      ( spi1_master_clk  ),
    .spi_csn0     ( spi1_master_csn0 ),
    .spi_csn1     ( spi1_master_csn1 ),
    .spi_csn2     ( spi1_master_csn2 ),
    .spi_csn3     ( spi1_master_csn3 ),
    .spi_mode     ( spi1_master_mode ),
    .spi_sdo0     ( spi1_master_sdo0 ),
    .spi_sdo1     ( spi1_master_sdo1 ),
    .spi_sdo2     ( spi1_master_sdo2 ),
    .spi_sdo3     ( spi1_master_sdo3 ),
    .spi_sdi0     ( spi1_master_sdi0 ),
    .spi_sdi1     ( spi1_master_sdi1 ),
    .spi_sdi2     ( spi1_master_sdi2 ),
    .spi_sdi3     ( spi1_master_sdi3 )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 5: Timer0 Unit                                   ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_timer
  apb_timer0_i
  (
    .HCLK       ( clk_int[6]   ),
    .HRESETn    ( rst_n        ),

    .PADDR      ( s_timer0_bus.paddr[11:0]),
    .PWDATA     ( s_timer0_bus.pwdata     ),
    .PWRITE     ( s_timer0_bus.pwrite     ),
    .PSEL       ( s_timer0_bus.psel       ),
    .PENABLE    ( s_timer0_bus.penable    ),
    .PRDATA     ( s_timer0_bus.prdata     ),
    .PREADY     ( s_timer0_bus.pready     ),
    .PSLVERR    ( s_timer0_bus.pslverr    ),

    .irq_o      ( timer0_irq    )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 6: Timer1 Unit                                   ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_timer
  apb_timer1_i
  (
    .HCLK       ( clk_int[7]   ),
    .HRESETn    ( rst_n        ),

    .PADDR      ( s_timer1_bus.paddr[11:0]),
    .PWDATA     ( s_timer1_bus.pwdata     ),
    .PWRITE     ( s_timer1_bus.pwrite     ),
    .PSEL       ( s_timer1_bus.psel       ),
    .PENABLE    ( s_timer1_bus.penable    ),
    .PRDATA     ( s_timer1_bus.prdata     ),
    .PREADY     ( s_timer1_bus.pready     ),
    .PSLVERR    ( s_timer1_bus.pslverr    ),

    .irq_o      ( timer1_irq    )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 7: Event Unit                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_event_unit
  apb_event_unit_i
  (
    .clk_i            ( clk_i        ),
    .HCLK             ( clk_int[8]   ),
    .HRESETn          ( rst_n        ),

    .PADDR            ( s_event_unit_bus.paddr[11:0]),
    .PWDATA           ( s_event_unit_bus.pwdata     ),
    .PWRITE           ( s_event_unit_bus.pwrite     ),
    .PSEL             ( s_event_unit_bus.psel       ),
    .PENABLE          ( s_event_unit_bus.penable    ),
    .PRDATA           ( s_event_unit_bus.prdata     ),
    .PREADY           ( s_event_unit_bus.pready     ),
    .PSLVERR          ( s_event_unit_bus.pslverr    ),

    .irq_i            ( {timer0_irq, timer1_irq, s_spim0_event, s_spim1_event, s_gpio_event, s_uart0_event, s_uart1_event, i2c_event, 16'b0} ),
    .event_i          ( {timer0_irq, timer1_irq, s_spim0_event, s_spim1_event, s_gpio_event, s_uart0_event, s_uart1_event, i2c_event, 16'b0} ),
    .irq_o            ( irq_o              ),

    .fetch_enable_i   ( fetch_enable_i     ),
    .fetch_enable_o   ( fetch_enable_o     ),
    .clk_gate_core_o  ( clk_gate_core_o    ),
    .core_busy_i      ( core_busy_i        )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 8: I2C                                           ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_i2c
  apb_i2c_i
  (
    .HCLK         ( clk_int[9]    ),
    .HRESETn      ( rst_n         ),

    .PADDR        ( s_i2c_bus.paddr[11:0] ),
    .PWDATA       ( s_i2c_bus.pwdata      ),
    .PWRITE       ( s_i2c_bus.pwrite      ),
    .PSEL         ( s_i2c_bus.psel        ),
    .PENABLE      ( s_i2c_bus.penable     ),
    .PRDATA       ( s_i2c_bus.prdata      ),
    .PREADY       ( s_i2c_bus.pready      ),
    .PSLVERR      ( s_i2c_bus.pslverr     ),
    .interrupt_o  ( i2c_event     ),
    .scl_pad_i    ( scl_pad_i     ),
    .scl_pad_o    ( scl_pad_o     ),
    .scl_padoen_o ( scl_padoen_o  ),
    .sda_pad_i    ( sda_pad_i     ),
    .sda_pad_o    ( sda_pad_o     ),
    .sda_padoen_o ( sda_padoen_o  )
  );


  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 9: FLL Ctrl                                      ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

    apb_fll_if apb_fll_if_i
    (
      .HCLK        ( clk_int[10]   ),
      .HRESETn     ( rst_n         ),

      .PADDR       ( s_fll_bus.paddr[11:0]),
      .PWDATA      ( s_fll_bus.pwdata     ),
      .PWRITE      ( s_fll_bus.pwrite     ),
      .PSEL        ( s_fll_bus.psel       ),
      .PENABLE     ( s_fll_bus.penable    ),
      .PRDATA      ( s_fll_bus.prdata     ),
      .PREADY      ( s_fll_bus.pready     ),
      .PSLVERR     ( s_fll_bus.pslverr    ),

      .fll1_req    ( fll1_req_o   ),
      .fll1_wrn    ( fll1_wrn_o   ),
      .fll1_add    ( fll1_add_o   ),
      .fll1_data   ( fll1_wdata_o ),
      .fll1_ack    ( fll1_ack_i   ),
      .fll1_r_data ( fll1_rdata_i ),
      .fll1_lock   ( fll1_lock_i  ),

      .fll2_req    (              ),
      .fll2_wrn    (              ),
      .fll2_add    (              ),
      .fll2_data   (              ),
      .fll2_ack    ( 1'b0         ),
      .fll2_r_data ( '0           ),
      .fll2_lock   ( 1'b0         )
      );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 10: PULPino control                              ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

    apb_pulpino
    #(
      .BOOT_ADDR ( ROM_START_ADDR )
    )
    apb_pulpino_i
    (
      .HCLK        ( clk_i        ),
      .HRESETn     ( rst_n        ),

      .PADDR       ( s_soc_ctrl_bus.paddr[11:0]),
      .PWDATA      ( s_soc_ctrl_bus.pwdata     ),
      .PWRITE      ( s_soc_ctrl_bus.pwrite     ),
      .PSEL        ( s_soc_ctrl_bus.psel       ),
      .PENABLE     ( s_soc_ctrl_bus.penable    ),
      .PRDATA      ( s_soc_ctrl_bus.prdata     ),
      .PREADY      ( s_soc_ctrl_bus.pready     ),
      .PSLVERR     ( s_soc_ctrl_bus.pslverr    ),

      .pad_cfg_o   ( pad_cfg_o                  ),
      .clk_gate_o  ( peripheral_clock_gate_ctrl ),
      .pad_mux_o   ( pad_mux_o                  ),
      .boot_addr_o ( boot_addr_o                )
    );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 11: APB2PER for debug                            ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb2per
  #(
    .PER_ADDR_WIDTH ( 15             ),
    .APB_ADDR_WIDTH ( APB_ADDR_WIDTH )
  )
  apb2per_debug_i
  (
    .clk_i                ( clk_i                   ),
    .rst_ni               ( rst_n                   ),

    .PADDR                ( s_debug_bus.paddr       ),
    .PWDATA               ( s_debug_bus.pwdata      ),
    .PWRITE               ( s_debug_bus.pwrite      ),
    .PSEL                 ( s_debug_bus.psel        ),
    .PENABLE              ( s_debug_bus.penable     ),
    .PRDATA               ( s_debug_bus.prdata      ),
    .PREADY               ( s_debug_bus.pready      ),
    .PSLVERR              ( s_debug_bus.pslverr     ),

    .per_master_req_o     ( debug.req               ),
    .per_master_add_o     ( debug.addr              ),
    .per_master_we_o      ( debug.we                ),
    .per_master_wdata_o   ( debug.wdata             ),
    .per_master_be_o      (                         ),
    .per_master_gnt_i     ( debug.gnt               ),

    .per_master_r_valid_i ( debug.rvalid            ),
    .per_master_r_opc_i   ( '0                      ),
    .per_master_r_rdata_i ( debug.rdata             )
  );
endmodule
