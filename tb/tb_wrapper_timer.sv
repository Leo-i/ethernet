`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2020 19:18:56
// Design Name: 
// Module Name: tb_wrapper_timer
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


module tb_wrapper_timer();

reg clk = 1'b1;
reg rst = 1'b1;

timer_wrapper timer(
.axi(axi),
.interrupt(interrupt)
);

initial
    forever begin
        #10
        clk = !clk;
    end


endmodule
