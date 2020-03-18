
module receiver(
    input               clk,
    input               rst_n,

    input               rx_er,
    input        [1:0]  rx_d,
    input               crs_dv,

    output  reg  [7:0]   data_o,
    output  reg          done
);

reg [2:0]   counter    = 3'b111;
reg         start      = 1'b0;

always_ff@( posedge clk ) begin
    
    if ( rst_n == 0 ) begin
        done         <= 1'b0;
        counter      <= 3'h111;
        start        <= 1'b0;
    end else if ( crs_dv && !(rx_er) ) 
        begin

            data_o    <= {rx_d[1:0],data_o[7:2]};

            if ( ( data_o == 8'hD5) && !start ) begin
                start   <= 1'b1;
                counter <= 3'b10;
                done    <= 1'b0;
            end else if ( counter == 3'b000 ) 
            begin
                done      <= start;
                counter   <= 2'b11;
            end else 
            begin
                counter    <= counter - 1'b1;
                done       <= 1'b0;
            end

    
        end else
        begin
            done        <= 1'b0;
            start       <= 1'b0;
            counter     <= 2'b00;

        end
    
end

endmodule
