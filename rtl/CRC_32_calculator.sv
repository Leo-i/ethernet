`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2020 21:58:47
// Design Name: 
// Module Name: CRC_32_calculator
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


module CRC_32_calculator(
    input               clk     ,    
    input               clear   , 
    input               BITVAL  ,
    input               valid,
  

    output reg [31:0]   CRC
);                       



wire         inv;

assign inv = BITVAL ^ CRC[31];              

always_ff@( posedge clk ) begin
    if ( clear ) begin
        CRC = 32'hFFFFFFFF;                                  
    end else 
    begin
        if ( valid ) begin
            CRC[31] <= CRC[30]       ;
            CRC[30] <= CRC[29]       ;
            CRC[29] <= CRC[28]       ;
            CRC[28] <= CRC[27]       ;
            CRC[27] <= CRC[26]       ;
            CRC[26] <= CRC[25] ^ inv ;
            CRC[25] <= CRC[24]       ;
            CRC[24] <= CRC[23]       ;
            CRC[23] <= CRC[22] ^ inv ;
            CRC[22] <= CRC[21] ^ inv ;
            CRC[21] <= CRC[20]       ;
            CRC[20] <= CRC[19]       ;
            CRC[19] <= CRC[18]       ;
            CRC[18] <= CRC[17]       ;
            CRC[17] <= CRC[16]       ;
            CRC[16] <= CRC[15] ^ inv ;
            CRC[15] <= CRC[14]       ;
            CRC[14] <= CRC[13]       ;
            CRC[13] <= CRC[12]       ;
            CRC[12] <= CRC[11] ^ inv ;
            CRC[11] <= CRC[10] ^ inv ;
            CRC[10] <= CRC[9]  ^ inv ;
            CRC[9]  <= CRC[8]        ;
            CRC[8]  <= CRC[7]  ^ inv ;
            CRC[7]  <= CRC[6]  ^ inv ;
            CRC[6]  <= CRC[5]        ;
            CRC[5]  <= CRC[4]  ^ inv ;
            CRC[4]  <= CRC[3]  ^ inv ;
            CRC[3]  <= CRC[2]        ;
            CRC[2]  <= CRC[1]  ^ inv ;
            CRC[1]  <= CRC[0]  ^ inv ;
            CRC[0]  <= inv           ;
        end
    end
end

endmodule

