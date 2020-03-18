
module transmitter(
    input               ref_clk,
    input               rst_n,

    input      [7:0]    data,
    input               en_i,

    output reg [1:0]    tx_d,
    output reg          tx_e,
    output reg          done_o
);

parameter IDLE = 2'b00;
parameter SEND = 2'b01;


//reg [7:0] data;
reg [1:0] state      = IDLE;
reg [1:0] send_state = 2'b00;

always_ff@( posedge ref_clk ) begin
    
    if ( rst_n == 0) begin
        state       <= IDLE;
        tx_e        <= 1'b0;
        done_o      <= 1'b1;
    end else
    begin

        case ( state )

            IDLE: begin
                tx_e    <= 1'b0;
                if ( en_i ) begin
                    state   <= SEND;
                    done_o  <= 1'b0;
                end
            end

            SEND: begin
                    tx_e    <= 1'b1;
                    case ( send_state )
                        2'b00: begin
                            tx_d[1:0]    <= data[7:6];
                            send_state   <= 2'b01;
                            done_o       <= 1'b0; 
                        end
                        2'b01: begin
                            tx_d[1:0]    <= data[5:4];
                            send_state   <= 2'b10;
                            done_o       <= 1'b0;
                        end
                        2'b10: begin
                            tx_d[1:0]    <= data[3:2];
                            send_state   <= 2'b11;
                            done_o       <= 1'b1;

                        end
                        2'b11: begin
                            tx_d[1:0]    <= data[1:0];
                            send_state   <= 2'b00;
                            if ( !en_i ) begin
                                state    <= IDLE; 
                                done_o   <= 1'b1;
                            end else
                                done_o   <= 1'b0;


                        end
                    endcase
                end

        endcase


    end

end

endmodule
