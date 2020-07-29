`timescale 1ns / 1ps

//`include "RMII_interface.sv"
module top (
  input                  clk_200_mhz,
  input                  rst,

  // uart
  output                uart_tx,
  input                 uart_rx,

  //phy 1
  input                 clk_out_1   ,
  input                 crs_dv_1    ,
  input                 led_phy_1   ,
  output                mdc_1       ,
  inout                 mdio_1      ,
  output                clk_50_mhz_1,
  output                rst_n_1     ,
  input                 rx_er_1     ,
  input         [1:0]   rx_d_1      ,
  output        [1:0]   tx_d_1      ,
  output                tx_e_1      ,

  // phy 2
  input                 clk_out_2   ,
  input                 crs_dv_2    ,
  input                 led_phy_2   ,
  output                mdc_2       ,
  inout                 mdio_2      ,
  output                clk_50_mhz_2,
  output                rst_n_2     ,
  input                 rx_er_2     ,
  input         [1:0]   rx_d_2      ,
  output        [1:0]   tx_d_2      ,
  output                tx_e_2      ,

  input        [3:0]    btn,
  output       [7:0]    led

);

RMII rmii_1();
RMII rmii_2();

assign clk_50_mhz_1       = clk_50_mhz_90;
assign rst_n_1            = rst_n;
assign clk_50_mhz_2       = clk_50_mhz_90;
assign rst_n_2            = rst_n;


assign rmii_1.crs_dv  =   crs_dv_1   ;  
assign mdc_1          =   rmii_1.MDC ;
assign rmii_1.MDIO    =   mdio_1     ;  
assign rmii_1.rx_er   =   rx_er_1    ;   
assign rmii_1.rx_d    =   rx_d_1     ;
assign tx_d_1         =   rmii_1.tx_d; 
assign tx_e_1         =   rmii_1.tx_e; 

assign rmii_2.crs_dv  =   crs_dv_2   ;  
assign mdc_2          =   rmii_2.MDC ;
assign rmii_2.MDIO    =   mdio_2     ;  
assign rmii_2.rx_er   =   rx_er_2    ;   
assign rmii_2.rx_d    =   rx_d_2     ;
assign tx_d_2         =   rmii_2.tx_d; 
assign tx_e_2         =   rmii_2.tx_e; 


clk_wiz_0 pll(
.clk_100_mhz            ( clk_100_mhz       ),
.clk_50_mhz             ( clk_50_mhz        ),
.clk_in1                ( clk_200_mhz       ),
.clk_25_mhz             ( clk_25_mhz        ),
.clk_50_mhz_90          ( clk_50_mhz_90     )
 );

assign rst_n = !rst;

SoC_Wrapper #(
.INIT_FILE            ( "D:/PROJECTS/VERILOG/ETHERNET/src/sw/data_t" )
)SoC_Wrapper(
.clk                  ( clk_100_mhz     ),
.clk_50_mhz           ( clk_50_mhz      ),
.clk_25_mhz           ( clk_25_mhz      ),
.resetn               ( rst_n           ),

.uart_tx              ( uart_tx       ),
.uart_rx              ( uart_rx       ),
.rmii_1               ( rmii_1        ),
.rmii_2               ( rmii_2        ),
.btn                  ( btn           ),
.led                  ( led           )
);

endmodule
