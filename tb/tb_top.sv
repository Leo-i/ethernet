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

module tb_top();

logic   clk_200_mhz = 1'b1;
logic   rst         = 1'b0;
always begin
    #(`CLK_PERIOD/2) clk_200_mhz = ~clk_200_mhz;
end

initial begin
    rst     <= 1'b1;
    #(100*`CLK_PERIOD);
    rst     <= 1'b0;


end


pulpino_top pulpino_top(
.clk_200_mhz    ( clk_200_mhz  ),
.rst         ( rst          ),

.uart_tx        ( uart_tx      ),
.uart_rx        ( uart_rx      ),

.clk_out_1      ( clk_out_1    ),
.crs_dv_1       ( crs_dv_1     ),
.led_phy_1      ( led_phy_1    ),
.mdc_1          ( mdc_1        ),
.mdio_1         ( mdio_1       ),
.clk_50_mhz_1   ( clk_50_mhz_1 ),
.rst_n_1        ( rst_n_1      ),
.rx_er_1        ( rx_er_1      ),
.rx_d_1         ( rx_d_1       ),
.tx_d_1         ( tx_d_1       ),
.tx_e_1         ( tx_e_1       ),

.clk_out_2      ( clk_out_2    ),
.crs_dv_2       ( crs_dv_2     ),
.led_phy_2      ( led_phy_2    ),
.mdc_2          ( mdc_2        ),
.mdio_2         ( mdio_2       ),
.clk_50_mhz_2   ( clk_50_mhz_2 ),
.rst_n_2        ( rst_n_2      ),
.rx_er_2        ( rx_er_2      ),
.rx_d_2         ( rx_d_2       ),
.tx_d_2         ( tx_d_2       ),
.tx_e_2         ( tx_e_2       ),

.btn            ( btn          ),
.led            ( led          ),

.tck_i          ( tck_i        ),
.trstn_i        ( trstn_i      ),
.tms_i          ( tms_i        ),
.tdi_i          ( tdi_i        ),
.tdo_o          ( tdo_o        )
);
endmodule
