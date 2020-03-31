`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2020 19:18:54
// Design Name: 
// Module Name: AXI_ethernet
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

`include "addr_defines.sv"

module AXI_ethernet(
    input               clk_25_mhz,
    input               clk_50_mhz,

    AXI_LITE.slave      axi,
    RMII.master         rmii,

    output         reg  rx_ready_int
);

assign rmii.tx_d        = tx_d;
assign rmii.tx_e        = tx_e;
assign rx_er            = rmii.rx_er; 
assign rx_d             = rmii.rx_d;  
assign crs_dv           = rmii.crs_dv;
assign rmii.MDIO        = mdio; 
assign rmii.MDC         = mdc;   

assign clk_100_mhz      = axi.aclk;
assign rst_n            = axi.aresetn;

reg                         DM_start   ;
reg                         DM_mode    ;
reg                [4:0]    DM_addr    ;
reg                [4:0]    DM_reg_addr;
reg                [15:0]   DM_data_i  ;
reg                [31:0]   tx_data_in ;
reg                         tx_valid   ;
reg                         tx_send;


// read transaction
reg     [3:0]       rd_state;
reg     [31:0]      read_addr;
reg     [15:0]      counter;

reg                 rx_int;
reg                 rx_clear;
reg                 rx_read_en;


always@( posedge axi.aclk ) begin
    if ( axi.aresetn == 1'b0 ) begin
        rd_state    <= 2'h0;
        counter     <= 16'h0;
        rx_int      <= 1'b0;
    end else
        case ( rd_state )
            4'h0: begin // initial

                

                if ( rx_ready )
                    if ( rx_data_count == 16'h1FFF ) begin
                        rx_clear        <= 1'b1;
                        rx_ready_int    <= 1'b0;
                    end else
                        rx_ready_int    <= 1'b1;
                else begin
                    rx_clear        <= 1'b0;
                    rx_ready_int    <= 1'b0;
                end
                
                if ( axi.arvalid ) begin
                    read_addr    <= axi.araddr;
                    axi.arready <= 1'b1;
                    rd_state    <= 4'h1;
                end else
                    axi.rvalid  <= 1'b0;

            end
            4'h1: //read
                if ( axi.rready )
                    case ( read_addr )
                        `ETHERNET_TX_READY_TO_WRITE: begin
                            axi.rdata   <= tx_ready_to_write;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `ETHERNET_RX_DATA: begin

                            if ( rx_data_count == counter ) begin
                                axi.rlast   <= 1'b1;
                                rx_read_en  <= 1'b0;
                                counter     <= 16'h0;
                                rd_state    <= 4'h0;
                                rx_clear    <= 1'b1;
                            end else begin
                                counter     <= counter + 1'b1;
                                axi.rlast   <= 1'b0;
                            end

                            axi.rvalid  <= 1'b1;
                            axi.rdata   <= rx_data;
                            rx_read_en  <= 1'b1;

                        end
                        `ETHERNET_RX_EMPTY: begin
                            axi.rdata   <= rx_empty;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `ETHERNET_RX_DATA_COUNT: begin
                            axi.rdata   <= rx_data_count;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `ETHERNET_RX_PROTOCOL_TYPE: begin
                            axi.rdata   <= rx_protocol_type;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `ETHERNET_DM_DATA_O: begin
                            axi.rdata   <= DM_data_o;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `ETHERNET_DM_DONE: begin
                            axi.rdata   <= DM_done;
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
reg     [1:0]       tx_wr_data;

always@( posedge axi.aclk ) begin
    if ( axi.aresetn == 1'b0 ) begin
        wr_state    <= 4'h0;
    end else
        case ( wr_state )
            4'h0: begin
                
                if ( axi.awvalid )begin
                    wr_state    <= 4'h1;
                    write_addr  <= axi.awaddr;
                    axi.awready <= 1'b1;
                end else begin
                    axi.awready <= 1'b0;
                end

            end
            4'h1: begin
                if ( axi.wvalid ) begin

                    case ( write_addr )
                        `ETHERNET_TX_DATA_IN : begin

                            tx_valid    <= 1'b1;

                            case ( tx_wr_data )
                                2'b00: 
                                    if ( tx_ready_to_write )
                                        tx_wr_data  <= 2'b01;

                                2'b01: begin
                                    if ( axi.wlast ) begin
                                        tx_wr_data  <= 4'h2;
                                        tx_valid    <= 1'b0;
                                    end else begin
                                        tx_data_in  <= axi.wdata;
                                        axi.wready  <= 1'b1;
                                        tx_valid    <= 1'b1;
                                    end
                                end
                                2'b10:
                                    if ( tx_ready_to_send ) begin
                                        tx_send     <= 1'b1;
                                        tx_wr_data  <= 2'b11;
                                    end
                                2'b11: begin
                                    tx_send     <= 1'b0;
                                    tx_wr_data  <= 2'b00;
                                    wr_state    <= 4'h2;
                                end
                            endcase
                        end                        
                        `ETHERNET_DM_MODE : begin
                            DM_mode     <= axi.wdata;
                            axi.wready  <= 1'b1;

                            if ( axi.wlast )
                                wr_state    <= 4'h2;
                        end
                        `ETHERNET_DM_START : begin
                            DM_start    <= axi.wdata;
                            axi.wready  <= 1'b1;

                            if ( axi.wlast )
                                wr_state    <= 4'h2;
                        end
                        `ETHERNET_DM_ADDR : begin
                            DM_addr     <= axi.wdata;
                            axi.wready  <= 1'b1;

                            if ( axi.wlast )
                                wr_state    <= 4'h2;
                        end
                        `ETHERNET_DM_REG_ADDR : begin
                            DM_reg_addr <= axi.wdata;
                            axi.wready  <= 1'b1;

                            if ( axi.wlast )
                                wr_state    <= 4'h2;
                        end
                        `ETHERNET_DM_DATA_IN : begin
                            DM_data_i   <= axi.wdata;
                            axi.wready  <= 1'b1;

                            if ( axi.wlast )
                                wr_state    <= 4'h2;
                        end
                        default: wr_state   <= 4'h0;
                    endcase
                end else
                    axi.wready  <= 1'b0;
                
            end
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
    
ethernet_module ethernet(

.clk_100_mhz            ( clk_100_mhz       ),
.clk_25_mhz             ( clk_25_mhz        ),
.clk_50_mhz             ( clk_50_mhz        ),
.rst_n                  ( rst_n             ),

// Tx =====================================
.tx_send                ( tx_send           ),
.tx_data_in             ( tx_data_in        ),
.tx_valid               ( tx_valid          ),
.tx_ready_to_write      ( tx_ready_to_write ),
.tx_ready_to_send       ( tx_ready_to_send  ), 
.tx_done                ( tx_done           ),

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
.DM_data_i              ( DM_data_i         ),
.DM_data_o              ( DM_data_o         ),
.DM_done                ( DM_done           ),

// RMII ===================================
.tx_d                   ( tx_d              ),
.tx_e                   ( tx_e              ),
.rx_er                  ( rx_er             ),
.rx_d                   ( rx_d              ),
.crs_dv                 ( crs_dv            ),
.MDIO                   ( mdio              ),
.MDC                    ( mdc               )                   
);

endmodule
