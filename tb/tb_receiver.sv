`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2020 17:16:06
// Design Name: 
// Module Name: tb_receiver
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


module tb_receiver();

reg clk = 1'b1;
reg rst = 1'b1;

reg         rx_er  = 1'b0;
reg [1:0]   rx_d;
reg         crs_dv = 1'b0;


initial begin
    #20
    rst <= 1'b0;
    #20
    rst <= 1'b1;
    #40
    rx_d    <= 2'b01;
    crs_dv  <= 1'b1;

    while ( 1 ) begin
        if ( done )
            break; 

        #20
        rx_d    <= 2'b01;
        crs_dv  <= 1'b1;


        
    end
    rx_d    <= 2'b10;

    while ( 1 ) begin

        #20
        rx_d    <= 2'b10;
        crs_dv  <= 1'b1;
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

wire [7:0] data_o;

receiver Rx(
.clk    ( clk ),
.rst_n      ( rst ),
.rx_er      ( rx_er),
.rx_d       ( rx_d ),
.crs_dv     ( crs_dv ),
.data_o     ( data_o ),
.done       ( done )
);

endmodule
