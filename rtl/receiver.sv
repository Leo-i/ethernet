
module receiver(

    input               clk,
    input               rst_n,

    input               rx_er,
    input        [1:0]  rx_d,
    input               crs_dv,

    output  reg  [7:0]  data_o,
    output  reg         done
);

    reg [1:0]   counter         = 3'b00;
    reg         state           = 1'b0;
 
    always@( posedge clk ) begin
        
        if ( rst_n == 0 ) begin

            done            <= 1'b0;
            counter         <= 2'b00;
            state           <= 1'b0;
            data_o          <= 8'b0;

        end else if ( crs_dv && !rx_er ) begin

            data_o    <= {rx_d[1:0],data_o[7:2]};

            case ( state )
            
                1'b0: begin //IDLE

                    counter         <= 3'b10;
                    done            <= 1'b0;

                    if ( data_o == 8'hD5 )
                        state   <= 1'b1;

                end
                
                1'b1: begin //RECEIVE

                    if ( counter == 2'b00 ) begin
                        counter         <= 2'b11;
                        done            <= 1'b1;
                    end else begin
                        counter    <= counter - 1'b1;
                        done       <= 1'b0;
                    end
                    
                end

            endcase

        end else begin // not valid rx
            done        <= 1'b0;
            counter     <= 2'b00;
            if ( !rx_er )
                state   <= 1'b0;       
        end
        
    end

endmodule
