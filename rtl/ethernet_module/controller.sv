`timescale 1ns / 1ps

module controller(
    input                clk,
    input                rst_n,

    input                start_i,
    input       [10:0]   addr_mode_i,
    input       [15:0]   data_i,

    inout                MDIO_io,
    output reg  [15:0]   data_o,
    output               busy_o
);

reg MDIO;

reg                 mode; //read - 0, write - 1
reg [15:0]          data;
reg [9:0]           addr;
reg                 operation; //read - 0, write - 1

reg [2:0]           state;
reg [7:0]           local_state;
reg [3:0]           i;


localparam IDLE      = 3'b000;
localparam START     = 3'b001;
localparam OPCODE    = 3'b010;
localparam PHY_ADDR  = 3'b011;
localparam REG_ADDR  = 3'b100;
localparam TURN      = 3'b101;
localparam DATA      = 3'b110;

assign MDIO_io = ( mode ) ? MDIO : 1'bZ;
assign busy_o  = ( state == IDLE ) ? 1'b0 : 1'b1;

always_ff@( posedge clk ) begin

    if( rst_n == 0 ) begin
        state       <= 3'b0;
        local_state <= 8'h00;
        mode        <= 1'b1;
        i           <= 1'b0;
    end else
        case ( state )
            
            IDLE: 
                if ( start_i ) begin
                    state       <= START;
                    data        <= data_i;
                    addr        <= addr_mode_i[10:1];
                    operation   <= addr_mode_i[0];
                    local_state <= 8'h00;
                    mode        <= 1'b1;
                    i           <= 1'b0;
                end

            START: //01
                case ( local_state )
                    8'h00:begin
                        MDIO        <= 1'b0;
                        local_state <= 8'h01;
                    end 
                    8'h01:begin
                        MDIO        <= 1'b1;
                        local_state <= 8'h00;
                        state       <= OPCODE;
                    end 
                    default:;
                endcase

            OPCODE: //read 10, write 01
                case ( local_state )
                    8'h00:begin
                        MDIO        <= !operation;
                        local_state <= 8'h01;
                    end 
                    8'h01:begin
                        MDIO        <= operation;
                        local_state <= 8'h00;
                        state       <= PHY_ADDR;
                    end 
                    default:; 
                endcase
            
            PHY_ADDR:// 5 bits
                case ( local_state )
                    8'h00, 8'h01, 8'h02, 8'h03:begin
                        MDIO        <= addr[9 - i];
                        local_state <= local_state + 1;
                        i           <= i + 1;
                    end 
                    8'h04:begin
                        MDIO        <= addr[5];
                        local_state <= 8'h00;
                        state       <= REG_ADDR;
                        i           <= 1'b0;
                    end 
                    default:; 
                endcase
            
            REG_ADDR: // 5bits
                case ( local_state )
                    8'h00, 8'h01, 8'h02, 8'h03:begin
                        MDIO        <= addr[4 - i];
                        local_state <= local_state + 1;
                        i           <= i + 1;
                    end 
                    8'h04:begin
                        MDIO        <= addr[0];
                        local_state <= 8'h00;
                        state       <= TURN;
                        i           <= 1'b0;

                        if ( !operation )
                            mode <= 1'b0;
                    end 
                    default:; 
                endcase

            TURN: // write 10, read zz
                case ( local_state )
                    8'h00:begin
                        MDIO        <= 1'b1;
                        local_state <= 8'h01;
                    end 
                    8'h01:begin
                        MDIO        <= 1'b0;
                        local_state <= 8'h00;
                        state       <= DATA;
                    end 
                    default:;
                endcase
            DATA:
                case ( local_state )
                    8'h00, 8'h01, 8'h02, 8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08, 8'h09, 8'h0A, 8'h0B, 8'h0C, 8'h0D, 8'h0E, 8'h0F:begin
                        MDIO        <= data[15-i];
                        data_o[15-i]<= MDIO_io;
                        local_state <= local_state + 1;
                        i           <= i + 1;
                    end 
                    8'h10:begin
                        MDIO        <= data[0];
                        data_o[0]   <= MDIO_io;
                        local_state <= 8'h00;
                        state       <= IDLE;
                        i           <= 1'b0;

                    end 
                    default:; 
                endcase
            default:;

        endcase
    
    
end



endmodule