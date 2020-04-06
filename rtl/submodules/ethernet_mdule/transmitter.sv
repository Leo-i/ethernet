
module transmitter(
    input               ref_clk,
    input               rst_n,

    input      [7:0]    data_i,
    input               en_i,

    output     [1:0]    tx_d,
    output reg          tx_e,
    output reg          done_o
);

parameter IDLE = 0;
parameter SEND = 1;

reg       state      = IDLE;
reg [7:0] data       = 8'h00;
reg [1:0] counter    = 2'b00;

assign  tx_d[1:0]    =   data[1:0];

always_ff@( posedge ref_clk ) begin
    
    if ( rst_n == 0) begin
        state       <= IDLE;
        tx_e        <= 1'b0;
        done_o      <= 1'b1;
        data        <= 8'h00;
    end else
    begin

        case ( state )

            IDLE: begin
                tx_e    <= 1'b0;
                if ( en_i ) begin
                    state   <= SEND;
                    done_o  <= 1'b0;
                    data    <= data_i;
                    counter <= 2'b00;
                end
            end

            SEND: begin
                tx_e    <= 1'b1;
                data    <= data >> 2;
                if ( counter == 2'b11 ) begin
                    counter <= 2'b00;
                    done_o  <= 1'b1;
                    if ( en_i )
                        data    <= data_i;
                    else 
                        state   <= IDLE;
                end else 
                begin
                    done_o  <= 1'b0;
                    counter <= counter +1'b1;
                end
            end

        endcase


    end

end

endmodule
