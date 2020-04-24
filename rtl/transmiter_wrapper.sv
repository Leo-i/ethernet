`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2020 17:27:38
// Design Name: 
// Module Name: transmiter_wrapper
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


module transmitter_wrapper(

    input               clk_100_mhz,
    input               clk_50_mhz,
    input               rst_n,

    input               send,
    input       [31:0]  data_in,
    input               valid,
    input               last_data,

    output reg          ready_to_write,
    output reg          ready_to_send, 

    output              done,

    output      [1:0]   tx_d,
    output              tx_e
);

wire    [7:0]       data;

reg                 wr_en;
reg                 state = 1'b0;
reg     [1:0]       send_state = 2'b00;
reg                 valid_fifo;
reg     [31:0]      data_fifo;
reg     [3:0]       delay;

always@( posedge clk_100_mhz ) begin

    if ( rst_n == 1'b0 ) begin

        state           <= 1'b0;
        ready_to_write  <= 1'b1;
        ready_to_send   <= 1'b0;
        wr_en           <= 1'b0;
        send_state      <= 2'b00;
        valid_fifo      <= 1'b0;
        data_fifo       <= 32'h0;
        delay           <= 4'h0;

    end else

        if ( state == 1'b0 )

                case ( send_state )
                    2'b00: begin  
                        
                        data_fifo       <= 32'h55555555; 
                        send_state      <= 2'b01; 
                        valid_fifo      <= 1'b1;
                        
                    end //preamble
                    2'b01:  begin
                        data_fifo       <= 32'h555555D5; 
                        send_state      <= 2'b10; 
                        valid_fifo      <= 1'b1; 
                    end
                    2'b10: begin 

                        if ( !last_data ) begin
                            valid_fifo  <= valid;
                            data_fifo   <= data_in;
                        end else begin // data
                            data_fifo       <= 32'h00000000;
                            valid_fifo      <= 1'b1; 
                            send_state      <= 2'b11;
                            ready_to_send   <= 1'b1;
                            ready_to_write  <= 1'b0;
                        end // tail

                    end 

                    2'b11: begin
                        valid_fifo          <= 1'b0;
                        if ( send ) begin
                            state           <= 1'b1;
                            wr_en           <= 1'b1;
                            ready_to_send   <= 1'b0;
                            send_state      <= 2'b0;
                            delay           <= 4'hF;
                        end
                    end

                endcase
                
        else if ( delay != 0)
            delay   <= delay - 1;
        else if ( done ) begin
            state           <= 1'b0;
            wr_en           <= 1'b0;
            ready_to_write  <= 1'b1;
        end
                      
        
end


FIFO_TX FIFO_TX(
.wr_clk         ( clk_100_mhz       ),
.rd_clk         ( clk_50_mhz        ),
.rst            ( !rst_n            ),
.din            ( data_fifo         ),
.wr_en          ( valid_fifo        ),
.rd_en          ( send_done & wr_en ),
.dout           ( data              ),
.full           ( full              ),
.empty          ( done              ) 
);

transmitter ethernet_Tx(
 .ref_clk       ( clk_50_mhz        ),
 .rst_n         ( rst_n             ),
 .data_i        ( data              ),
 .en_i          ( wr_en & !done    ),
 .tx_d          ( tx_d              ),
 .tx_e          ( tx_e              ),
 .done_o        ( send_done         )
);

endmodule
