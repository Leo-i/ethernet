`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2020 14:29:18
// Design Name: 
// Module Name: tb_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_wrapper();

reg         clk_200_mhz     =   1'b0;
reg         PHY1_CRS_DV     =   1'b0;
reg         PHY1_LED_LINK   =   1'b0;
reg         PHY1_RX_ERR     =   1'b0;
reg         PHY1_RX0        =   1'b0;
reg         PHY1_RX1        =   1'b0;
reg         PB_RST          =   1'b0;
reg         PB1             =   1'b0;
reg         PB2             =   1'b0;

wrapper wr(
.clk_200_mhz    ( clk_200_mhz  ), 
.USB_UART_RXD   ( USB_UART_RXD   ),
.USB_UART_TXD   ( USB_UART_TXD   ),
//.PHY1_CLKOUT    (   ),
.PHY1_CRS_DV    ( PHY1_CRS_DV  ), 
.PHY1_LED_LINK  ( PHY1_LED_LINK  ), 
.PHY1_MDC       ( PHY1_MDC  ), 
.PHY1_MDIO      ( PHY1_MDIO  ), 
.PHY1_REF_CLK   ( PHY1_REF_CLK  ), 
.PHY1_RST_N     ( PHY1_RST_N  ), 
.PHY1_RX_ERR    ( PHY1_RX_ERR  ), 
.PHY1_RX0       ( PHY1_RX0  ), 
.PHY1_RX1       ( PHY1_RX1  ), 
.PHY1_TX0       ( PHY1_TX0  ), 
.PHY1_TX1       ( PHY1_TX1  ), 
.PHY1_TXEN      ( PHY1_TXEN  ), 
.USER_LED3      ( USER_LED3  ), 
.USER_LED2      ( USER_LED2  ), 
.USER_LED1      ( USER_LED1  ), 
.PB_RST         ( PB_RST  ), 
.PB1            ( PB1  ),
.PB2            ( PB2  )
);
initial begin
    #100
    PB_RST  <= 1'b1;
    #30
    PB_RST  <= 1'b0;
    #50
    PB2     <= 1'b1;
    #900
    PB2     <= 1'b0;
end
initial begin
    forever begin
        #5
        clk_200_mhz <= !clk_200_mhz;
    end
end
endmodule
