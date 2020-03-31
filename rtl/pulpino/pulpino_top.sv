`timescale 1ns / 1ps

module pulpino_top (
  input  logic       sys_clk,
  input  logic       ck_rst,

  inout  logic  [3:0] spi_master_sdio,
  output logic        spi_master_clko,
  output logic  [3:0] spi_master_cso,

  input  logic        scl_pad_i,
    output logic        scl_pad_o,
    output logic        scl_padoen_o,
    input  logic        sda_pad_i,
    output logic        sda_pad_o,
    output logic        sda_padoen_o,

   output logic        uart_tx,
    input  logic        uart_rx,
    output logic        uart_rts,
    output logic        uart_dtr,
    input  logic        uart_cts,
    input  logic        uart_dsr,

    inout  logic [31:0] gpio_inout,

    input  logic        tck_i,
    input  logic        trstn_i,
    input  logic        tms_i,
    input  logic        tdi_i,
    output logic        tdo_o
  );

localparam SPI_DATA_LINES     =  4;
localparam SPI_MASTER_STD     =  0;
localparam SPI_MASTER_QUAD_TX =  1;
localparam SPI_MASTER_QUAD_RX =  2;
localparam GPIO_NUMBER        = 32;
localparam GPIO_DIR_IN        =  0;
localparam GPIO_DIR_OUT       =  1;

logic       rst_n;

logic [3:0] spi_master_sdo;
logic [3:0] spi_master_sdi;
logic [1:0] spi_master_mode;
logic       spi_master_tx_en;

logic        [31:0] gpio_in;
logic        [31:0] gpio_out;
logic        [31:0] gpio_dir;
logic [31:0]  [5:0] gpio_padcfg;



assign rst_n = (locked & ck_rst) ? 1'b1 : 1'b0;
assign spi_master_tx_en = ((spi_master_mode == SPI_MASTER_QUAD_TX) || (spi_master_mode == SPI_MASTER_STD)) ? 1'b1 : 1'b0;

genvar i;
generate
    for (i = 0; i < SPI_DATA_LINES; i = i + 1) begin
      assign spi_master_sdio[i] = ((i!=0) && (spi_master_mode == SPI_MASTER_STD))? 1'bz : ((spi_master_tx_en) ? spi_master_sdo[i] : 1'bz);
      assign spi_master_sdi[i]  = spi_master_sdio[i];
    end
endgenerate

generate
    for (i = 0; i < GPIO_NUMBER; i = i + 1) begin
      assign gpio_inout[i] = (gpio_dir[i] == GPIO_DIR_OUT) ? gpio_out[i] : 1'bz;
      assign gpio_in[i]    = gpio_inout[i];
    end
endgenerate

pulpino
#(
    .PLATFORM             ( "XILINX_7_SERIES"     ),
    .BOOT_FILE            ( ""),
    .USE_ZERO_RISCY       (  0                    ),
    .RISCY_RV32F          (  0                    ),
    .ZERO_RV32M           (  1                    ),
    .ZERO_RV32E           (  0                    )
  )
  pulpino_i
  (
      .clk                ( sys_clk ),
      .rst_n              ( ck_rst ),

      //.clk_sel_i        (  ),
      //.clk_standalone_i (  ),
      .testmode_i         ( 1'b1 ),
      .fetch_enable_i     ( 1'b1 ),
      //.scan_en_i        ( scan_enable_i ),

      .spi_clk_i           (),
      .spi_cs_i            (),
      .spi_mode_o          (),
      .spi_sdo0_o          (),
      .spi_sdo1_o          (),
      .spi_sdo2_o          (),
      .spi_sdo3_o          (),
      .spi_sdi0_i          (),
      .spi_sdi1_i          (),
      .spi_sdi2_i          (),
      .spi_sdi3_i          (),

      .spi0_master_clk_o    ( spi_master_clko ),  
      .spi0_master_csn0_o   ( spi_master_cso[0] ),
      .spi0_master_csn1_o   ( spi_master_cso[1] ),
      .spi0_master_csn2_o   ( spi_master_cso[2] ),
      .spi0_master_csn3_o   ( spi_master_cso[3] ),
      .spi0_master_mode_o   ( spi_master_mode ),
      .spi0_master_sdo0_o   ( spi_master_sdo[0] ),
      .spi0_master_sdo1_o   ( spi_master_sdo[1] ),
      .spi0_master_sdo2_o   ( spi_master_sdo[2] ),
      .spi0_master_sdo3_o   ( spi_master_sdo[3] ),
      .spi0_master_sdi0_i   ( spi_master_sdi[0] ),
      .spi0_master_sdi1_i   ( spi_master_sdi[1] ),
      .spi0_master_sdi2_i   ( spi_master_sdi[2] ),
      .spi0_master_sdi3_i   ( spi_master_sdi[3] ),

      .scl_pad_i           ( scl_pad_i ),
      .scl_pad_o           ( scl_pad_o ),
      .scl_padoen_o        ( scl_padoen_o ),
      .sda_pad_i           ( sda_pad_i ),
      .sda_pad_o           ( sda_pad_o ),
      .sda_padoen_o        ( sda_padoen_o ),

      .uart0_tx             ( uart_tx ),
      .uart0_rx             ( uart_rx ),
      .uart0_rts            ( uart_rts ),
      .uart0_dtr            ( uart_dtr ),
      .uart0_cts            ( uart_cts ),
      .uart0_dsr            ( uart_dsr ),

      .gpio_in             ( gpio_in ),
      .gpio_out            ( gpio_out ),
      .gpio_dir            ( gpio_dir ),
      .gpio_padcfg         ( gpio_padcfg ),

      // JTAG signals
      .tck_i               ( tck_i ),
      .trstn_i             ( trstn_i ),
      .tms_i               ( tms_i ),
      .tdi_i               ( tdi_i ),
      .tdo_o               ( tdo_o ),

      // PULPino specific pad config
      .pad_cfg_o           (),
      .pad_mux_o           ()

  );

endmodule
