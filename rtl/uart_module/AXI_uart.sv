`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 11:49:06
// Design Name: 
// Module Name: AXI_uart
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
//`include "addr_defines.sv"
//`include "axi_lite_bus.sv"

module AXI_uart(
    input               clk_50_mhz,
    AXI_LITE.slave      axi,

    output              uart_tx,
    input               uart_rx,

    output              rdy
);

reg     [7:0]       uart_din;
reg                 uart_wr_en;
reg                 uart_rdy_clr;
reg     [7:0]       rx_data;
reg                 rx_ready_int;

wire   [7:0]        uart_dout;
reg    [7:0]        delay= 8'h0;

reg    [4:0]        high_packet;
reg    [4:0]        curent_packet = 5'h1;
reg    [7:0]        data_buf[31:0];

// read transaction
reg     [3:0]       rd_state;
reg     [31:0]      read_addr;

always@( posedge axi.aclk ) begin
    if ( axi.aresetn == 1'b0 ) begin
        rd_state        <= 2'h0;
        rx_ready_int    <= 1'b0;
    end else
        case ( rd_state )
            4'h0: begin // initial

                if ( rdy ) begin
                    uart_rdy_clr    <= 1'b1;
                    rx_ready_int    <= 1'b1;
                    rx_data         <= uart_dout;
                end else
                    uart_rdy_clr    <= 1'b0;
                
                if ( axi.arvalid ) begin
                    read_addr    <= axi.araddr;
                    axi.arready <= 1'b1;
                    rd_state    <= 4'h1;
                end else begin
                    axi.rvalid  <= 1'b0;
                    axi.arready <= 1'b0;
                    axi.rlast   <= 1'b0;
                end

            end
            4'h1: //read
                if ( axi.rready )
                    case ( read_addr )
                        `UART_RX_DATA: begin
                            axi.rdata       <= rx_data;
                            axi.rvalid      <= 1'b1;
                            axi.rlast       <= 1'b1;
                            rd_state        <= 4'h0;
                            rx_ready_int    <= 1'b0;
                        end
                        `UART_TX_BUSY: begin
                            axi.rdata   <= uart_tx_busy;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `UART_READY: begin
                            axi.rdata   <= rx_ready_int;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        default: rd_state   <= 4'h0;
                    endcase
                else
                    axi.rvalid  <= 1'b0;
        endcase
end

// write transaction
reg     [3:0]       wr_state;
reg     [31:0]      write_addr;

always@( posedge axi.aclk ) begin
    if ( axi.aresetn == 1'b0 ) begin
        wr_state    <= 4'h0;
        uart_wr_en      <= 4'h0;
        delay           <= 4'h0;
        curent_packet   <= 5'h1;
        high_packet     <= 5'h0;
    end else
        case ( wr_state )
            4'h0: begin
                
                axi.wready  <= 1'b0;

                if ( axi.awvalid )begin
                    wr_state    <= 4'h1;
                    write_addr  <= axi.awaddr;
                    axi.awready <= 1'b1;
                end else begin
                    axi.awready <= 1'b0;
                end

                if ( delay == 4'h0)
                    if ( (high_packet != 0) && !uart_tx_busy ) begin
                        uart_din        <= data_buf[curent_packet];
                        uart_wr_en      <= 1'b1;
                        delay           <= 4'hF;
                        if ( curent_packet == high_packet) begin
                            curent_packet   <= 5'h1;
                            high_packet     <= 5'h0;
                        end else
                            curent_packet   <= curent_packet + 1;
                    end else
                        uart_wr_en      <= 1'b0;
                else
                    delay   <= delay - 1;

            end
            4'h1:
                if ( axi.wvalid ) 

                    case ( write_addr )

                        `UART_TX_DATA : begin
                            

                            if ( axi.wlast ) begin
                                wr_state    <= 4'h2;
                                data_buf[high_packet + 1]    <= axi.wdata;
                                high_packet   <= high_packet + 1'b1;
                                axi.wready  <= 1'b1;
                            end
                        end

                        default: wr_state   <= 4'h0;
                    endcase

                else
                    axi.wready  <= 1'b0;
            4'h2: begin
                axi.bvalid  <= 1'b1;
                axi.bresp   <= 2'b00;
                wr_state    <= 4'h3;
            end
            4'h3: begin
                wr_state    <= 4'h0;
                axi.bvalid  <= 1'b0;
            end            
        endcase
end


uart uart(
.din                    ( uart_din          ),
.wr_en                  ( uart_wr_en        ),
.clk_50m                ( clk_50_mhz        ),
.tx                     ( uart_tx           ),
.tx_busy                ( uart_tx_busy      ),
.rx                     ( uart_rx           ),
.rdy                    ( rdy               ),
.rdy_clr                ( uart_rdy_clr      ),
.dout                   ( uart_dout         )
);

endmodule
