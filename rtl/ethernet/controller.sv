
module controller(
    input                clk,
    input                rst_n,

    input                start,
    input                mode_i, //read - 1
    input       [4:0]    addr_i,
    input       [4:0]    reg_addr_i,
    input       [15:0]   data_i,

    inout                MDIO_io,
    output reg  [15:0]   data_o,
    output reg           done
);

reg MDIO;

reg                 mode;
reg [15:0]          data;
reg [4:0]           addr;
reg [4:0]           reg_addr;

reg [3:0]           send_state;
reg [2:0]           state;
reg                 write;

assign MDIO_io = ( write ) ? MDIO : 1'bZ;

parameter IDLE      = 3'b000;
parameter START     = 3'b001;
parameter OPCODE    = 3'b010;
parameter D_ADDR    = 3'b011;
parameter R_ADDR    = 3'b100;
parameter TURN      = 3'b101;
parameter DATA      = 3'b110;

always_ff@( posedge clk ) begin
    
    if (rst_n == 1'b0) begin
        send_state  <= 4'b0;
        state       <= IDLE;
        data        <= 16'b0;
        addr        <= 5'b0;
        reg_addr    <= 5'b0;
        done        <= 1'b0;
        write       <= 1'b1;
    end else
        case( state )
            IDLE: begin
                MDIO            <= 1'b1;

                if ( start ) begin
                    write       <= 1'b1;
                    send_state  <= 4'b0;
                    state       <= START;
                    data        <= data_i;
                    addr        <= addr_i;
                    reg_addr    <= reg_addr_i;
                    mode        <= mode_i;
                    done        <= 1'b0;
                end

            end
            START: begin
                case ( send_state )

                    5'h0: begin MDIO <= 1'b0; send_state <= 1'b1; end
                    5'h1: begin MDIO <= 1'b1; send_state <= 1'b0; state <= OPCODE; end

                endcase
            end
            OPCODE: begin

                if ( mode ) // read operation
                    case ( send_state )

                        5'h0: begin MDIO <= 1'b1; send_state <= 1'b1; end
                        5'h1: begin MDIO <= 1'b0; send_state <= 1'b0; state <= D_ADDR; end

                    endcase
                else
                    case ( send_state )

                        5'h0: begin MDIO <= 1'b0; send_state <= 1'b1; end
                        5'h1: begin MDIO <= 1'b1; send_state <= 1'b0; state <= D_ADDR; end

                    endcase

            end
            D_ADDR: begin

                if ( send_state == 3'b100 ) begin
                    MDIO        <= addr[send_state];
                    state       <= R_ADDR;
                    send_state  <= 5'b0;
                end else
                begin
                    MDIO        <= addr[send_state];
                    send_state  <= send_state + 1'b1;
                end

            end
            R_ADDR: begin

                if ( send_state == 3'b100 ) begin
                    MDIO        <= reg_addr[send_state];
                    state       <= TURN;
                    send_state  <= 5'b0;
                end else
                begin
                    MDIO        <= reg_addr[send_state];
                    send_state  <= send_state + 1'b1;
                end

            end
            TURN: begin

                if ( mode ) begin // read operation
                    write   <= 1'b0;
                    case ( send_state )

                        5'h0: begin MDIO <= 1'bZ; send_state <= 1'b1; end
                        5'h1: begin MDIO <= 1'bZ; send_state <= 1'b0; state <= DATA; end

                    endcase
                end else
                    case ( send_state )

                        5'h0: begin MDIO <= 1'b1; send_state <= 1'b1; end
                        5'h1: begin MDIO <= 1'b0; send_state <= 1'b0; state <= DATA; end

                    endcase
                
            end
            DATA: begin
                if ( mode ) // read operation
                    if ( send_state == 4'b1111 ) begin
                        state                <= IDLE;
                        data_o[send_state]   <= MDIO_io;
                        done                 <= 1'b1;
                    end else
                    begin
                        send_state           <= send_state + 1'b1;
                        data_o[send_state]   <= MDIO_io;
                    end
                else
                    if ( send_state == 4'b1111 ) begin
                        state       <= IDLE;
                        MDIO        <= data[send_state];
                        done        <= 1'b1;
                    end else
                    begin
                        send_state  <= send_state + 1'b1;
                        MDIO        <= data[send_state];
                    end
            end
            default: state <= IDLE;
        endcase
end



endmodule