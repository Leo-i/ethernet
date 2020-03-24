`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2019 15:26:10
// Design Name: 
// Module Name: tb_gecko_soc_top
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
`timescale 1ns/1ps

`define CLK_PERIOD 10.00 

module tb_gecko_soc_gpio(
);

logic       clk;
logic       rst_n;
reg  [31:0] gpio;
wire [31:0] gpio_wire;
assign      gpio_wire = gpio;

reg value = 1'b1;


gecko_soc_top DUT(
	.CLK100MHZ( clk ),
	.ck_rst( rst_n ),

	.spi_master_sdio(),
	.spi_master_clko(),
	.spi_master_cso(),
 
    .scl_pad_i(),
    .scl_pad_o(),
    .scl_padoen_o(),
    .sda_pad_i(),
    .sda_pad_o(),
    .sda_padoen_o(),

	.uart_tx(),
    .uart_rx(),
    .uart_rts(),
    .uart_dtr(),
    .uart_cts(),
    .uart_dsr(),

    .gpio_inout(gpio_wire),
    
    .tck_i(),
    .trstn_i(),
    .tms_i(),
    .tdi_i(),
    .tdo_o()
  );

initial
  begin
    clk = 0;
    rst_n = 0; 
    #(10*`CLK_PERIOD);
    rst_n = 1;
    // For simple test without irq
    for (int e=0;e<32;e++) 
    begin
        gpio[e] =  value;
        value   = ~value;
    end
    #1555000 // Preparing
    for (int e=0;e<32;e++) 
    begin
        gpio[e] =  1'b1;
    end
    #1000000 // For 0 irq test
    for (int e=0;e<32;e++) 
    begin
        gpio[e] =  1'b0;
    end
    #10600000 // For 1 irq test
    for (int e=0;e<32;e++) 
    begin
        gpio[e] =  1'b1;
    end
    #11600000 // For fall edge irq test
    for (int e=0;e<32;e++) 
    begin
        gpio[e] =  1'b0;
        #400000;
    end
    #1780000 // For rise edge irq test
    for (int e=0;e<32;e++) 
    begin
        gpio[e] =  1'b1;
        #400000;
    end
    
    #(9000000*`CLK_PERIOD);
    $stop;
  end

always 
  begin
    #(`CLK_PERIOD/2) clk = ~clk;
  end




endmodule
