`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2020 13:11:49
// Design Name: 
// Module Name: tb_top
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


`define CLK_PERIOD  5.00ns
`define UART_DELAY  8.70us

module tb_top();

logic   clk_200_mhz = 1'b1;
logic   rst         = 1'b0;
wire    [7:0]       led;
reg                 uart_rx;

wire    [1:0]       rx_d_1;
wire    [1:0]       tx_d_1;

assign rx_d_1   = tx_d_1;
assign rx_er_1  = !tx_e_1;
assign crs_dv_1 = tx_e_1;

always begin
    #(`CLK_PERIOD/2) clk_200_mhz = ~clk_200_mhz;
end

int i;

task send_uart(
    input   [7:0] data
);
    begin
        uart_rx <= 1'b0;
    
        for (int i = 7; i >= 0; i--) begin
            #(`UART_DELAY)
            uart_rx <= data[i];
        end
        #(`UART_DELAY)
        uart_rx <= 1'b1;
    end
endtask


initial begin
    rst     <= 1'b1;
    #(100*`CLK_PERIOD);
    rst     <= 1'b0;

    #(20*`CLK_PERIOD)
    send_uart(7'h19);
end

assign uart_rx = uart_tx;

top top(
.clk_200_mhz    ( clk_200_mhz  ),
.rst            ( rst          ),

.uart_tx        ( uart_tx      ),
.uart_rx        ( uart_rx      ),

.crs_dv_1       ( crs_dv_1     ),
.mdc_1          ( mdc_1        ),
.mdio_1         ( mdio_1       ),
.clk_50_mhz_1   ( clk_50_mhz_1 ),
.rst_n_1        ( rst_n_1      ),
.rx_er_1        ( rx_er_1      ),
.rx_d_1         ( rx_d_1       ),
.tx_d_1         ( tx_d_1       ),
.tx_e_1         ( tx_e_1       ),

.crs_dv_2       ( crs_dv_2     ),
.mdc_2          ( mdc_2        ),
.mdio_2         ( mdio_2       ),
.clk_50_mhz_2   ( clk_50_mhz_2 ),
.rst_n_2        ( rst_n_2      ),
.rx_er_2        ( rx_er_2      ),
.rx_d_2         ( rx_d_2       ),
.tx_d_2         ( tx_d_2       ),
.tx_e_2         ( tx_e_2       ),

.btn            ( btn          ),
.led            ( led          )

);
endmodule
