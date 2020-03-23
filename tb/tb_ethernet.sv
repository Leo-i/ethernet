`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2020 15:07:52
// Design Name: 
// Module Name: tb_ethernet
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


module tb_ethernet();

reg             clk_100_mhz     = 1'b0;
reg             clk_50_mhz      = 1'b0;
reg             clk_25_mhz      = 1'b0;
reg             rst_n           = 1'b1;

// Tx ===================================
reg             tx_send         = 1'h0;
reg     [31:0]  tx_data_in      = 32'h0;
reg             tx_valid        = 1'h0;
reg     [15:0]  tx_data_count   = 16'h0;
reg             tx_clear        = 1'h1;

wire     [1:0]  tx_d;

// Rx ===================================
reg             rx_read_en      = 1'b0;
reg             rx_clear        = 1'b0;
reg             rx_er           = 1'b0;
reg      [1:0]  rx_d            = 1'b0;
reg             crs_dv          = 1'b0;

// MD ===================================
reg             DM_start        = 1'h0; 
reg             DM_mode         = 1'h0; 
reg      [4:0]  DM_addr         = 5'h0; 
reg      [4:0]  DM_reg_addr     = 5'h0; 
reg     [15:0]  DM_data         = 16'h0; 

// data_to_send =========================
reg     [31:0]  data_1          = 32'hFFFFFFFF;
reg     [31:0]  data_2          = 32'hFFFF88E3;
reg     [31:0]  data_3          = 32'h56789ABC;
reg     [31:0]  data_4          = 32'h08004500;
reg     [31:0]  data_5          = 32'h0024774F;
reg     [31:0]  data_6          = 32'h00008011;
reg     [31:0]  data_7          = 32'h59F8A9FE;
reg     [31:0]  data_8          = 32'h1585A9FE;
reg     [31:0]  data_9          = 32'hFFFFDD5B;
reg     [31:0]  data_A          = 32'h05FE0010;
reg     [31:0]  data_B          = 32'h147D5443;
reg     [31:0]  data_C          = 32'h46320400;
reg     [31:0]  data_D          = 32'h00000204;
reg     [31:0]  data_E          = 32'hFFFFFFFF;
reg     [31:0]  data_F          = 32'h12345678;
reg     [31:0]  data_t;

// events ===============================

event   clk_50_mhz_pos;
event   clk_100_mhz_pos;

int     i = 1;
int     j = 1;

task send_data();
    begin
        

        tx_clear    <= 1'b0;
        #100
        while ( !tx_done ) @( clk_100_mhz_pos );
        $display("start transaction");
        tx_data_count   <= 15'h003C;
        tx_valid        <= 1'b1;
        while ( !tx_ready_to_write ) @( clk_100_mhz_pos );
        $display("start write data into fifo");

        
        while (1) begin

            case ( i )
                1:  tx_data_in   <= data_1;
                2:  tx_data_in   <= data_2;
                3:  tx_data_in   <= data_3;
                4:  tx_data_in   <= data_4;
                5:  tx_data_in   <= data_5;
                6:  tx_data_in   <= data_6;
                7:  tx_data_in   <= data_7;
                8:  tx_data_in   <= data_8;
                9:  tx_data_in   <= data_9;
                10: tx_data_in   <= data_A;
                11: tx_data_in   <= data_B;
                12: tx_data_in   <= data_C;
                13: tx_data_in   <= data_D;
                14: tx_data_in   <= data_E;
                15: tx_data_in   <= data_F;
                default: begin
                    tx_valid    <= 1'b0;
                    break;
                    $display("all data written into fifo");
                end
            endcase
            @( clk_100_mhz_pos )
            i = i + 1;            

            
        end

        while ( !tx_ready_to_send )@( clk_100_mhz_pos );
        $display("start sending data");
        tx_send    <= 1'b1;
        @( clk_50_mhz_pos )
        @( clk_50_mhz_pos )
        tx_send    <= 1'b0;

        while ( !tx_done ) @( clk_100_mhz_pos );
        $display("data sent");
    end
endtask

task receive_data();
    begin
        rx_clear    <= 1'b1;
        #100
        rx_clear    <= 1'b0;
        @( clk_50_mhz_pos );
        data_t      <= 32'h5555555D;

        while ( !rx_ready ) begin
            
            for (i=31; i>0; i=i-2) begin
                @( clk_50_mhz_pos );
                rx_er       <= 1'b0;
                crs_dv      <= 1'b1;
                rx_d        <= {data_t[i],data_t[i-1]};

                if (i == 3)
                case ( j )
                    1:  data_t   <= data_1;
                    2:  data_t   <= data_2;
                    3:  data_t   <= data_3;
                    4:  data_t   <= data_4;
                    5:  data_t   <= data_5;
                    6:  data_t   <= data_6;
                    7:  data_t   <= data_7;
                    8:  data_t   <= data_8;
                    9:  data_t   <= data_9;
                    10: data_t   <= data_A;
                    11: data_t   <= data_B;
                    12: data_t   <= data_C;
                    13: data_t   <= data_D;
                    14: data_t   <= data_E;
                    15: data_t   <= data_F;
                    default: begin
                        crs_dv   <= 1'b0;
                        break;
                        $display("sending data to Rx finished");
                    end
                endcase
            end
            j = j + 1;


        end

        $display("data received");
        @( clk_100_mhz_pos )
        rx_read_en  <= 1'b1;
        while( !rx_empty ) @( clk_100_mhz_pos );
        $display("data transmitted");
    end
endtask
initial begin
    rst_n   <= 1'b0;
    #200
    rst_n   <= 1'b1;
    #20
    receive_data();
    //send_data();
end




ethernet_module ethernet(

.clk                    ( clk_100_mhz       ),
.clk_25_mhz             ( clk_25_mhz        ),
.clk_50_mhz             ( clk_50_mhz        ),
.rst_n                  ( rst_n             ),

// Tx =====================================
.tx_send                ( tx_send           ),
.tx_data_in             ( tx_data_in        ),
.tx_valid               ( tx_valid          ),
.tx_data_count          ( tx_data_count     ),
.tx_ready_to_write      ( tx_ready_to_write ),
.tx_ready_to_send       ( tx_ready_to_send  ), 
.tx_done                ( tx_done           ),
.tx_clear               ( tx_clear          ),

// Rx =====================================
.rx_ready               ( rx_ready          ),
.rx_data                ( rx_data           ),
.rx_read_en             ( rx_read_en        ),
.rx_empty               ( rx_empty          ),
.rx_data_count          ( rx_data_count     ),
.rx_protocol_type       ( rx_protocol_type  ),
.rx_clear               ( rx_clear          ),

// DM =====================================
.DM_start               ( DM_start          ),
.DM_mode                ( DM_mode           ), 
.DM_addr                ( DM_addr           ),
.DM_reg_addr            ( DM_reg_addr       ),
.DM_data                ( DM_data           ),
.DM_done                ( DM_done           ),

// RMII ===================================
.tx_d                   ( tx_d              ),
.tx_e                   ( tx_e              ),
.rx_er                  ( rx_er             ),
.rx_d                   ( rx_d              ),
.crs_dv                 ( crs_dv            ),
.MDIO_io                ( MDIO_io           ),
.MDC                    ( MDC               )                   
);

//========= clk =====================
initial begin
    fork
    forever begin // в 2 раза дольше
        #5
        clk_100_mhz <= 1'b1;
        -> clk_100_mhz_pos;
        #5
        clk_100_mhz <= 1'b0;
    end
    forever begin
        #10
        clk_50_mhz  <= 1'b1;
        -> clk_50_mhz_pos;
        #10
        clk_50_mhz  <= 1'b0;
    end
    forever begin
        #20
        clk_25_mhz  <= !clk_25_mhz;
    end
    join
end

endmodule
