`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2020 21:43:18
// Design Name: 
// Module Name: tb_sender
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


module tb_sender();

reg         sys_clk     = 1'b1 ;
reg         rst         = 1'b0 ;
reg         btn         = 1'b0 ;
reg         rx2_clear   = 1'b0;   

reg         rx_er   = 1'b1;
reg         crs_dv  = 1'b0; 

reg         uart_rx =1'b0;

reg         clk_out_1 = 1'b0;
reg         crs_dv_1  = 1'b0;
reg         led_phy_1 = 1'b0;
reg         rx_er_1   = 1'b0;
reg         rx_d_1    = 1'b0;


reg         clk_out_2 = 1'b0;
reg         led_phy_2 = 1'b0;

wire    [1:0]   tx_d_1;
wire [1:0]  tx_d;
wire [1:0]  rx_d;

assign  rx_d = tx_d;

initial begin
    #1000
    rst <= 1'b1;
    #200
    rst <= 1'b0;
    #500
    btn <= 1'b1;
    #100
    btn <= 1'b0;
    #19000
    rx2_clear   <= 1'b1;
    #2000;
    rx2_clear   <= 1'b0;

    while ( 1 ) begin
        #1
        if ( tx_e_1 ) begin
            crs_dv <= 1'b1;
            rx_er  <= 1'b0;
        end else
        begin
            crs_dv <= 1'b0;
            rx_er  <= 1'b1;
        end
    end
end


hw_test_ethernet_module tx(
.sys_clk        ( sys_clk       ),
.led            ( led           ),
.rst            ( rst           ),
.btn            ( btn           ),
.rx2_clear      ( rx2_clear     ),

.clk_out_1      ( clk_out_1     ),
.crs_dv_1       ( crs_dv_1      ),
.led_phy_1      ( led_phy_1     ),
.mdc_1          ( mdc_1         ),
.mdio_1         ( mdio_1        ),
.clk_50_mhz_1   ( clk_50_mhz_1  ),
.rst_n_1        ( rst_n_1       ),
.rx_er_1        ( rx_er_1       ),
.rx_d_1         ( rx_d_1        ),
.tx_d_1         ( tx_d_1        ),
.tx_e_1         ( tx_e_1        ),

.clk_out_2      ( clk_out_2     ),
.crs_dv_2       ( tx_e_1        ),
.led_phy_2      ( led_phy_2     ),
.mdc_2          ( mdc_2         ),
.mdio_2         ( mdio_2        ),
.clk_50_mhz_2   ( clk_50_mhz_2  ),
.rst_n_2        ( rst_n_2       ),
.rx_er_2        ( !tx_e_1       ),
.rx_d_2         ( tx_d_1        ),
.tx_d_2         ( tx_d_2        ),
.tx_e_2         ( tx_e_2        ),

.uart_tx        ( uart_tx       ),
.uart_rx        ( uart_rx       )
);

initial begin
    forever begin
        # 5
        sys_clk <= !sys_clk;
    end
end

endmodule
