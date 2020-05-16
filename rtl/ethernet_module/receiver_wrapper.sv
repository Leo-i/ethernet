`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2020 18:00:08
// Design Name: 
// Module Name: receiver_wrapper
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


module receiver_wrapper(
    input               clk_100_mhz,
    input               clk_50_mhz,
    input               rst_n,

    input               rx_er,
    input        [1:0]  rx_d,
    input               crs_dv,

    output  reg         ready,

    output       [31:0] data_o,
    input               read_en,
    output              empty,

    output  reg  [15:0] data_count = 16'h0,
    output  reg  [15:0] protocol_type     
);

wire    [7:0]   data;
reg     [15:0]  counter = 16'h0;


always_ff@( posedge clk_50_mhz ) begin

    if ( rst_n == 1'b0 ) begin
        counter         <= 16'b0;
        protocol_type   <= 16'h0;
        data_count      <= 16'h0;
        ready           <= 1'b0; 

    end else 

        if ( done && !ready ) begin // octet counter

            counter <= counter + 1'b1;

            case ( counter )
                8'hC:   protocol_type[15:8]  <= data;
                8'hD:   protocol_type[7:0]   <= data;
            endcase

        end else if ( (counter > 12) && !crs_dv ) begin
            ready       <= 1'b1;
            data_count  <= counter;
        end
    

end

FIFO_RX FIFO_RX(
.wr_clk         ( clk_50_mhz        ),
.rd_clk         ( clk_100_mhz       ),
.rst            ( !rst_n            ),
.din            ( data              ),
.wr_en          ( done && !ready    ),
.rd_en          ( read_en           ),
.dout           ( data_o            ),
.full           ( full              ),
.empty          ( empty             ) 
);

receiver receiver(
.clk            ( clk_50_mhz        ),
.rst_n          ( rst_n             ),
.rx_er          ( rx_er             ),
.rx_d           ( rx_d              ),
.crs_dv         ( crs_dv            ),
.data_o         ( data              ),
.done           ( done              )
);



endmodule
