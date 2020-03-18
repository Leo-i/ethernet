`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2020 16:20:32
// Design Name: 
// Module Name: tb_wrapper_transmiter
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


module tb_wrapper_transmiter();

reg             clk_50_mhz      = 1'b1;  
reg             clk_100_mhz      = 1'b1;        
reg             rst_n    = 1'b1;         
reg             en_i     = 1'b0;

reg     [31:0]  signals                       = 32'h00000012      ;
reg     [31:0]  MAC_1                         = 32'h89ABCDEF      ;
reg     [31:0]  MAC_2                         = 32'h12345678      ;
reg     [31:0]  MAC_3                         = 32'h89ABCDEF      ;

reg     [7:0]   MAC_LENGTH                    = 8'h12             ;    
reg     [31:0]  Ver_IHL_TypeOfService_Length  = 32'h89ABCDEF      ;                        
reg     [31:0]  Id_Flags_FragmentOffset       = 32'h12345678      ;                     
reg     [31:0]  LiveTime_Protocol_Checksum    = 32'h89ABCDEF      ;                     
reg     [31:0]  Src_addr                      = 32'h12345678      ;    
reg     [31:0]  Dst_addr                      = 32'h89ABCDEF      ;     
reg     [31:0]  SrcPort_DstPort               = 32'h12345678      ;             
reg     [31:0]  SequenceNum                   = 32'h89ABCDEF      ;             
reg     [31:0]  AckNum                        = 32'h12345678      ; 
reg     [31:0]  tcp_param                     = 32'h89ABCDEF      ;     
reg     [31:0]  Checksum_urgentPointer        = 32'h12345678      ;                 
reg     [31:0]  Options_Padding               = 32'h89ABCDEF      ;         
reg     [31:0]  data_count                    = 32'h0             ;     
reg     [31:0]  data                          = 32'h11223344      ; 
reg     [31:0]  checksum_FCS                  = 32'h89ABCDEF      ; 


initial begin
    #30
    rst_n   <= 1'b0;
    #50
    rst_n   <= 1'b1;
    #40
    signals <= 32'h00000011;

    while(1)begin
        #10
        if ( busy )
            break;
    end

    signals <= 32'h00000010;
    while ( busy )
        #20;
    #200
    $finish;
end

wrapper_transmitter Tx(
.clk_50_mhz                         ( clk_50_mhz                    ),
.clk_100_mhz                        ( clk_100_mhz                   ),
.rst_n                              ( rst_n                         ),
.signals                            ( signals                       ), ////data_count(11 bits),FCS_calculate,enable
.MAC_1                              ( MAC_1                         ), //DST
.MAC_2                              ( MAC_2                         ), //DST-SRC
.MAC_3                              ( MAC_3                         ), //SRC
.MAC_LENGTH                         ( MAC_LENGTH                    ),
.Ver_IHL_TypeOfService_Length       ( Ver_IHL_TypeOfService_Length  ), 
.Id_Flags_FragmentOffset            ( Id_Flags_FragmentOffset       ),     
.LiveTime_Protocol_Checksum         ( LiveTime_Protocol_Checksum    ),
.Src_addr                           ( Src_addr                      ),
.Dst_addr                           ( Dst_addr                      ),
.SrcPort_DstPort                    ( SrcPort_DstPort               ), 
.SequenceNum                        ( SequenceNum                   ),     
.AckNum                             ( AckNum                        ),
.tcp_param                          ( tcp_param                     ),
.Checksum_urgentPointer             ( Checksum_urgentPointer        ),
.Options_Padding                    ( Options_Padding               ),
.data                               ( data                          ),
.checksum_FCS                       ( checksum_FCS                  ),
.busy                               ( busy                          ),
.tx_d                               ( tx_d                          ),
.tx_e                               ( tx_e                          )                              
);

initial begin
    fork
        forever begin
            #20
            clk_50_mhz  <= !clk_50_mhz;
        end
        forever begin
            #10
            clk_100_mhz  <= !clk_100_mhz;
        end
    join_none
end
endmodule
