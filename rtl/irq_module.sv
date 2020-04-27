`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2020 16:54:41
// Design Name: 
// Module Name: irq_module
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


module irq_module(
input       [3:0]   btn,      
input               uart_int, 
input               eth_1_int,
input               eth_2_int,
output reg  [31:0]  irq      
);

always@(*)
    
    if ( uart_int )
        irq <= 32'h800000000;
    else if ( eth_1_int )
        irq <= 32'h200000000;
    else if ( eth_2_int )
        irq <= 32'h100000000;
    else if ( btn != 0)
        irq[3:0] <= btn;

endmodule
