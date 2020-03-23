`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2020 20:41:44
// Design Name: 
// Module Name: sender
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


module hw_test_ethernet_module(
    input                sys_clk,
    output [7:0]         led,
    input                rst,
    input                btn,

    // phy 1
    input                clk_out_1   ,
    input                crs_dv_1    ,
    input                led_phy_1   ,
    output               mdc_1       ,
    inout                mdio_1      ,
    output               clk_50_mhz_1,
    output               rst_n_1     ,
    input                rx_er_1     ,
    input         [1:0]  rx_d_1      ,
    output        [1:0]  tx_d_1      ,
    output               tx_e_1      ,

    // phy 2
    input                clk_out_2   ,
    input                crs_dv_2    ,
    input                led_phy_2   ,
    output               mdc_2       ,
    inout                mdio_2      ,
    output               clk_50_mhz_2,
    output               rst_n_2     ,
    input                rx_er_2     ,
    input         [1:0]  rx_d_2      ,
    output        [1:0]  tx_d_2      ,
    output               tx_e_2      ,

    output          uart_tx,
    input           uart_rx
);

wire rst_n;

assign  rst_n = !rst;

assign  clk_50_mhz_1  = clk_50_mhz_90;
assign  clk_50_mhz_2  = clk_50_mhz_90;
assign  rst_n_1       = rst_n;
assign  rst_n_2       = rst_n;

assign  led[0]        = done;
assign  led[5]        = led_phy_1;
assign  led[6]        = led_phy_2;
assign  led[7]        = locked;

// receive and send via uart
wire    [15:0]      rx2_data_count;
wire    [31:0]      rx2_data;
reg     [7:0]       uart_din;
reg     [4:0]       rd_state    = 5'h7;
reg     [3:0]       delay       = 4'h0;
reg                 uart_wr_en;
reg                 rx2_read_en = 1'b0;
reg     [15:0]      counter     = 16'h0;

always@( posedge clk_100_mhz ) begin
    if ( rst ) begin
        uart_din    <= 8'h0;
        rd_state    <= 5'h7;
        delay       <= 4'h0;
        uart_wr_en  <= 1'b0;
        rx2_read_en <= 1'b0;
        counter     <= 16'h0;
    end else begin
        if ( delay  == 4'h0) begin
            case ( rd_state )

                5'h0:begin 
                    uart_wr_en  <= 1'b0;

                    if ( !uart_tx_busy ) begin
                        rd_state        <= 5'h1;
                        delay           <= 4'hF;
                    end
 
                end //if ready
                5'h1: 
                    if ( !uart_tx_busy ) begin
                        rx2_read_en     <= 1'b0;
                        uart_wr_en      <= 1'b1;
                        uart_din[7:0]   <= rx2_data[31:24];
                        rd_state        <= 5'h2;
                        delay           <= 4'hF;
                    end
                5'h2:
                    if ( !uart_tx_busy ) begin
                        uart_wr_en      <= 1'b1;
                        uart_din[7:0]   <= rx2_data[23:16];
                        rd_state        <= 5'h3;
                        delay           <= 4'hF;
                    end
                5'h3:
                    if ( !uart_tx_busy ) begin
                        uart_wr_en      <= 1'b1;
                        uart_din[7:0]   <= rx2_data[15:8];
                        rd_state        <= 5'h4;
                        delay           <= 4'hF;
                    end
                5'h4: begin
                    if ( !uart_tx_busy ) begin
                        uart_wr_en      <= 1'b1;
                        uart_din[7:0]   <= rx2_data[7:0];
                        rd_state        <= 5'h5;
                        delay           <= 4'hF;
                    end 
                end
                5'h5: begin

                    if ( rx2_empty )
                        rd_state    <= 5'h7;
                    else begin
                        rd_state        <= 5'h6;
                        rx2_read_en     <= 1'b1;
                    end
                    
                end
                5'h6: begin
                    
                    rd_state        <= 5'h0;
                    rx2_read_en     <= 1'b0;
                    
                end
                5'h7: begin
                    uart_wr_en      <= 1'b0;
                    if ( !rx2_empty )
                        rd_state        <= 5'h0;  
                end
            endcase

        end else begin
            delay       <= delay - 1'b1;
        end
    end
    
end

// send packet 
reg     [4:0]   wr_state = 5'h17;
reg             done = 1'b0;
reg             tx1_valid;
reg     [31:0]  tx1_data_in;
reg             tx1_send;
reg     [23:0]  delay_write = 24'h0;

always@( posedge clk_100_mhz )begin

    if ( btn ) begin
        wr_state        <= 5'h0;
        delay_write     <= 24'hFFFFFFF;
        done            <= 1'b0;
        tx1_valid       <= 1'b0;
        tx1_data_in     <= 32'h0;
        tx1_send        <= 1'b0;
    end else if ( delay_write == 24'h0 )
        case ( wr_state )
            5'h0 : begin
                tx1_valid       <= 1'b1;  
                if ( tx1_ready_to_write ) begin
                    wr_state    <= 5'h3;
                    tx1_data_in <= 32'hFFFFFFFF;  
                end 
            end
            
            5'h1 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'hFFFFFFFF; wr_state  <= 5'h2 ;    end
            5'h2 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'hFFFFFFFF; wr_state  <= 5'h3 ;    end
            5'h3 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'hFFFF88E3; wr_state  <= 5'h4 ;    end
            5'h4 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h56789ABC; wr_state  <= 5'h5 ;    end
            5'h5 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h08004500; wr_state  <= 5'h6 ;    end
            5'h6 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h0024774F; wr_state  <= 5'h7 ;    end
            5'h7 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h00008011; wr_state  <= 5'h8 ;    end
            5'h8 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h59F8A9FE; wr_state  <= 5'h9 ;    end
            5'h9 : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h1585A9FE; wr_state  <= 5'hA ;    end
            5'hA : begin tx1_valid <= 1'b1; tx1_data_in <= 32'hFFFFDD5B; wr_state  <= 5'hB ;    end
            5'hB : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h05FE0010; wr_state  <= 5'hC ;    end
            5'hC : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h147D5443; wr_state  <= 5'hD ;    end
            5'hD : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h46320400; wr_state  <= 5'hE ;    end
            5'hE : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h00000204; wr_state  <= 5'hF ;    end
            5'hF : begin tx1_valid <= 1'b1; tx1_data_in <= 32'h05b40103; wr_state  <= 5'h10;    end
            5'h10: begin tx1_valid <= 1'b1; tx1_data_in <= 32'h03080101; wr_state  <= 5'h11;    end
            5'h11: begin tx1_valid <= 1'b1; tx1_data_in <= 32'h04025024; wr_state  <= 5'h12;    end
            5'h12: begin tx1_valid <= 1'b1; tx1_data_in <= 32'hD6500000; wr_state  <= 5'h13;    end
            5'h13: begin tx1_valid <= 1'b1; tx1_data_in <= 32'h00000000; wr_state  <= 5'h14;    end
            5'h14: begin tx1_valid <= 1'b1; tx1_data_in <= 32'h00000000; wr_state  <= 5'h15;    end
            5'h15: begin tx1_valid <= 1'b1; tx1_data_in <= 32'hD6500000; wr_state  <= 5'h16;    end
            5'h16: begin tx1_valid <= 1'b1; tx1_data_in <= 32'h00000000; wr_state  <= 5'h17;    end
            
            5'h17: begin 
                tx1_valid <= 1'b0; 
                if ( tx1_ready_to_send ) begin 
                    tx1_send    <= 1'b1;
                    wr_state    <= 5'h18;
                    delay_write <= 4'hF;
                end 
            end

            5'h18: begin
                tx1_send    <= 1'b0;
                if ( tx1_done ) begin
                    done    <= 1'b1;
                end
            end
        endcase
    else begin
        delay_write <= delay_write - 1'b1;
    end
end

uart uart(
.din                    ( uart_din          ),
.wr_en                  ( uart_wr_en        ),
.clk_50m                ( clk_50_mhz        ),
.tx                     ( uart_tx           ),
.tx_busy                ( uart_tx_busy      ),
.rx                     ( uart_rx           ),
.rdy                    ( uart_rdy          ),
.rdy_clr                ( uart_rdy_clr      ),
.dout                   ( uart_dout         )
);

reg     reset = 1'b0;

clk_wizard clock(
.clk_100_mhz            ( clk_100_mhz       ),
.clk_50_mhz             ( clk_50_mhz        ),
.reset                  ( reset             ),
.locked                 ( locked            ),
.clk_in1                ( sys_clk           ),
.clk_25_mhz             ( clk_25_mhz        ),
.clk_50_mhz_90          ( clk_50_mhz_90     )
 );

reg             rx1_read_en  = 1'b0;
reg             rx1_clear    = 1'b0;
reg             DM1_start    = 1'h0;
reg             DM1_mode     = 1'h0;
reg             DM1_addr     = 5'h0;
reg             DM1_reg_addr = 5'h0;
reg             DM1_data_i   = 16'h0;

 ethernet_module ethernet_1(

.clk_100_mhz            ( clk_100_mhz       ),
.clk_25_mhz             ( clk_25_mhz        ),
.clk_50_mhz             ( clk_50_mhz        ),
.rst_n                  ( rst_n             ),

// Tx =====================================
.tx_send                ( tx1_send           ),
.tx_data_in             ( tx1_data_in        ),
.tx_valid               ( tx1_valid          ),
.tx_ready_to_write      ( tx1_ready_to_write ),
.tx_ready_to_send       ( tx1_ready_to_send  ), 
.tx_done                ( tx1_done           ),

// Rx =====================================
.rx_ready               ( rx1_ready          ),
.rx_data                ( rx1_data           ),
.rx_read_en             ( rx1_read_en        ),
.rx_empty               ( rx1_empty          ),
.rx_data_count          ( rx1_data_count     ),
.rx_protocol_type       ( rx1_protocol_type  ),

// DM =====================================
.DM_start               ( DM1_start          ),
.DM_mode                ( DM1_mode           ), 
.DM_addr                ( DM1_addr           ),
.DM_reg_addr            ( DM1_reg_addr       ),
.DM_data_i              ( DM1_data_i         ),
.DM_data_o              ( DM1_data_o         ),
.DM_done                ( DM1_done           ),

// RMII ===================================
.tx_d                   ( tx_d_1            ),
.tx_e                   ( tx_e_1            ),
.rx_er                  ( rx_er_1           ),
.rx_d                   ( rx_d_1            ),
.crs_dv                 ( crs_dv_1          ),
.MDIO                   ( mdio_1            ),
.MDC                    ( mdc_1             )                   
);

reg             tx2_send        = 1'h0;
reg    [31:0]   tx2_data_in     = 32'h0;
reg             tx2_valid       = 1'b0;
reg    [16:0]   tx2_data_count  = 16'h0;
reg             DM2_start       = 1'h0;
reg             DM2_mode        = 1'h0;
reg             DM2_addr        = 5'h0;
reg             DM2_reg_addr    = 5'h0;
reg             DM2_data_i      = 16'h0;
reg             tx2_clear       = 1'h0;

ethernet_module ethernet_2(

.clk_100_mhz            ( clk_100_mhz       ),
.clk_25_mhz             ( clk_25_mhz        ),
.clk_50_mhz             ( clk_50_mhz        ),
.rst_n                  ( rst_n             ),

// Tx =====================================
.tx_send                ( tx2_send           ),
.tx_data_in             ( tx2_data_in        ),
.tx_valid               ( tx2_valid          ),
.tx_ready_to_write      ( tx2_ready_to_write ),
.tx_ready_to_send       ( tx2_ready_to_send  ), 
.tx_done                ( tx2_done           ),

// Rx =====================================
.rx_ready               ( rx2_ready          ),
.rx_data                ( rx2_data           ),
.rx_read_en             ( rx2_read_en        ),
.rx_empty               ( rx2_empty          ),
.rx_data_count          ( rx2_data_count     ),
.rx_protocol_type       ( rx2_protocol_type  ),

// DM =====================================
.DM_start               ( DM2_start          ),
.DM_mode                ( DM2_mode           ), 
.DM_addr                ( DM2_addr           ),
.DM_reg_addr            ( DM2_reg_addr       ),
.DM_data_i              ( DM2_data_i         ),
.DM_data_o              ( DM2_data_o         ),
.DM_done                ( DM2_done           ),

// RMII ===================================
.tx_d                   ( tx_d_2            ),
.tx_e                   ( tx_e_2            ),
.rx_er                  ( rx_er_2           ),
.rx_d                   ( rx_d_2            ),
.crs_dv                 ( crs_dv_2          ),
.MDIO                   ( mdio_2            ),
.MDC                    ( mdc_2             )                   
);

endmodule
