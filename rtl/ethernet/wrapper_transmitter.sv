`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2020 14:53:18
// Design Name: 
// Module Name: draft_wrapper_transmitter
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


module wrapper_transmitter(
    input           clk_50_mhz,
    input           clk_100_mhz,
    input           rst_n,

    input   [31:0]  signals, //data_count(11 bits),FCS_calculate,enable

    input   [31:0]  MAC_1, //DST
    input   [31:0]  MAC_2, //DST-SRC
    input   [31:0]  MAC_3, //SRC
    input   [31:0]  MAC_LENGTH,

    input   [31:0]  Ver_IHL_TypeOfService_Length, 
    input   [31:0]  Id_Flags_FragmentOffset,     
    input   [31:0]  LiveTime_Protocol_Checksum,
    input   [31:0]  Src_addr,
    input   [31:0]  Dst_addr,
    input   [31:0]  SrcPort_DstPort, 
    input   [31:0]  SequenceNum,     
    input   [31:0]  AckNum,
    input   [31:0]  tcp_param,
    input   [31:0]  Checksum_urgentPointer,
    input   [31:0]  Options_Padding,
    input   [31:0]  data,
    input   [31:0]  checksum_FCS,

    output          busy,
    output  [1:0]   tx_d,
    output          tx_e
    );

wire [31:0]  FCS_w;
wire [31:0]  CRC;
wire         enable;

reg         clear  = 1'b0 ; 
reg         BITVAL = 1'b0 ; 
reg         valid  = 1'b0 ;

reg         en = 1'b0;
reg [4:0]   state       = 5'b0;
reg [1:0]   data_send   = 2'b0;
reg [31:0]  data_to_send;
reg         done = 1'b0;
reg [4:0]   i;
reg [3:0]   j;

assign  FCS_w  = signals[1] ? CRC : checksum_FCS;
assign  enable = ( signals[0]  &&  !signals[1] ) || done ;
assign  busy   = tx_busy || ( state != 5'h0 ) || ( done );

always_ff@( posedge clk_100_mhz ) begin

    if  ( rst_n == 0 ) begin
        state           <= 5'h0;
        clear           <= 1'b0;
        data_send       <= 2'b0;
        data_to_send    <= 32'b0;
        done            <= 1'b0;
        i               <= 6'h1F;
        j               <= 3'hF;
    end  else if ( signals[0] && signals[1] )
    begin
        state  <= 4'h1;
        clear  <= 1'b1;
        done <= 1'b0;
    end
    
    case ( state )
        5'h0:       begin valid       <= 1'b0;   i <= 6'h1F;   j <= 3'hF;    data_send   <= 2'b0;  done <= 1'b0;                end
        5'h1:       begin data_send   <= 2'b01;  data_to_send       <= MAC_1;                           clear  <= 1'b0;         end
        5'h2:       begin data_send   <= 2'b01;  data_to_send       <= MAC_2;                           clear  <= 1'b0;         end
        5'h3:       begin data_send   <= 2'b01;  data_to_send       <= MAC_3;                           clear  <= 1'b0;         end
        5'h4:       begin data_send   <= 2'b10;  data_to_send[15:0] <= MAC_LENGTH[15:0];                clear  <= 1'b0;         end
        5'h5:       begin data_send   <= 2'b01;  data_to_send       <= Ver_IHL_TypeOfService_Length ;   clear  <= 1'b0;         end
        5'h6:       begin data_send   <= 2'b01;  data_to_send       <= Id_Flags_FragmentOffset;         clear  <= 1'b0;         end
        5'h7:       begin data_send   <= 2'b01;  data_to_send       <= LiveTime_Protocol_Checksum;      clear  <= 1'b0;         end
        5'h8:       begin data_send   <= 2'b01;  data_to_send       <= Src_addr;                        clear  <= 1'b0;         end
        5'h9:       begin data_send   <= 2'b01;  data_to_send       <= Dst_addr;                        clear  <= 1'b0;         end
        5'hA:       begin data_send   <= 2'b01;  data_to_send       <= SrcPort_DstPort ;                clear  <= 1'b0;         end
        5'hB:       begin data_send   <= 2'b01;  data_to_send       <= SequenceNum     ;                clear  <= 1'b0;         end
        5'hC:       begin data_send   <= 2'b01;  data_to_send       <= AckNum;                          clear  <= 1'b0;         end
        5'hD:       begin data_send   <= 2'b01;  data_to_send       <= tcp_param;                       clear  <= 1'b0;         end
        5'hE:       begin data_send   <= 2'b01;  data_to_send       <= Checksum_urgentPointer;          clear  <= 1'b0;         end
        5'hF:       begin data_send   <= 2'b01;  data_to_send       <= Options_Padding;                 clear  <= 1'b0;         end
        5'h10:      begin data_send   <= 2'b01;  data_to_send       <= data;                            clear  <= 1'b0;         end
        5'h11:      begin state <= state+1; valid       <= 1'b0;   clear  <= 1'b0; done <= 1'b1;      end
        default:    begin    state <=  4'h0;    data_send   <= 2'b0;                        end
    endcase

    case( data_send )
        2'b01: begin    // send 32 bit

            if ( i == 6'b1 ) begin
                state   <= state + 1'b1;
                BITVAL  <= data_to_send[i];
                i       <= 6'b0;
                valid   <= 1'b1;
            end if ( i == 6'b0 ) begin
                valid   <= 1'b1;
                BITVAL  <= data_to_send[i];
                i       <= 6'h1F;
            end else 
            begin
                i       <= i - 1;
                valid   <= 1'b1;
                BITVAL  <= data_to_send[i];
            end

        end
        2'b10: begin    // send 8 bit

            if ( j == 6'b1 ) begin
                state   <= state + 1'b1;
                BITVAL  <= data_to_send[j];
                j       <= 6'b0;
                valid   <= 1'b1;
            end if ( j == 3'b0 ) begin
                valid   <= 1'b1;
                BITVAL  <= data_to_send[j];
                j       <= 3'hF;
            end else 
            begin
                j       <= j - 1;
                valid   <= 1'b1;
                BITVAL  <= data_to_send[j];
            end
        end
        default: valid  <= 1'b0;
    endcase
    
end

CRC_32_calculator crc_32(
.clk        ( clk_100_mhz   ),
.clear      ( clear         ),
.BITVAL     ( BITVAL        ),
.CRC        ( CRC           ),
.valid      ( valid         )
);

tcp_ip_transmitter tcp_ip(
.clk                               ( clk_50_mhz                    ) ,
.rst_n                             ( rst_n                         ) ,
.en_i                              ( enable                        ) ,
.MAC_1                             ( MAC_1                         ) ,
.MAC_2                             ( MAC_2                         ) ,
.MAC_3                             ( MAC_3                         ) ,
.MAC_LENGTH                        ( MAC_LENGTH[15:0]               ) ,
.Ver_IHL_TypeOfService_Length      ( Ver_IHL_TypeOfService_Length  ) , 
.Id_Flags_FragmentOffset           ( Id_Flags_FragmentOffset       ) ,     
.LiveTime_Protocol_Checksum        ( LiveTime_Protocol_Checksum    ) ,
.Src_addr                          ( Src_addr                      ) ,
.Dst_addr                          ( Dst_addr                      ) ,
.SrcPort_DstPort                   ( SrcPort_DstPort               ) , 
.SequenceNum                       ( SequenceNum                   ) ,     
.AckNum                            ( AckNum                        ) ,
.tcp_param                         ( tcp_param                     ) ,
.Checksum_urgentPointer            ( Checksum_urgentPointer        ) ,
.Options_Padding                   ( Options_Padding               ) ,
.data_count                        ( signals[12:2]                 ) ,
.data                              ( data                          ) ,
.done_send                         ( done_send                     ) ,
.checksum_FCS                      ( FCS_w                         ) ,
.busy                              ( tx_busy                       ) ,
.tx_d                              ( tx_d                          ) ,
.tx_e                              ( tx_e                          ) 
);


endmodule
