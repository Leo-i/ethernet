`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2020 14:25:56
// Design Name: 
// Module Name: tb_transmitter
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


module tb_transmitter();

reg clk = 1'b1;
reg rst = 1'b1;

reg [7:0] data  = 8'hC3;
reg       en    = 1'b1;
reg       start = 1'b0;
reg       last  = 1'b0;

wire      done;

initial begin
    #20
    rst <= 1'b0;
    #20
    rst <= 1'b1;
    #40
    start   <= 1'b1;
    #20
    start   <= 1'b1;
    while ( 1 )begin
    #5
    if ( done )
        break; 
    end
    data <= 8'h91;
    #30
        while ( 1 )begin
    #5
    if ( done )
        break; 
    end
    $finish;
    
end

initial begin
    forever begin
        #10
        clk <= !clk;
    end
end

wire [1:0] tx_d;
transmitter Tx(
.ref_clk    ( clk ),
.rst_n      ( rst ),
.data       ( data ),
.en_i       ( en   ),
.start_i    ( start ),
.last_i     ( last ),
.tx_d       ( tx_d ),
.tx_e       ( tx_e ),
.done_o     ( done )
);
endmodule
