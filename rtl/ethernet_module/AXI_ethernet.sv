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


module AXI_ethernet(
    input               clk_25_mhz,
    input               clk_50_mhz,

    AXI_LITE.slave      axi,
    RMII.master         rmii,

    output              rx_ready
);

wire    [1:0]   tx_d;
wire    [1:0]   rx_d;

assign rmii.tx_d[1:0]   = tx_d[1:0];
assign rmii.tx_e        = tx_e;
assign rx_er            = rmii.rx_er; 
assign rx_d[1:0]        = rmii.rx_d[1:0];  
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

wire               [15:0]  rx_data_count;
wire               [31:0]  rx_data;
wire               [31:0]  rx_protocol_type;
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

                counter     <= 0;
                axi.rlast   <= 1'b0;

                rx_clear        <= 1'b0;
                
                if ( axi.arvalid ) begin
                    read_addr    <= axi.araddr;
                    axi.arready <= 1'b1;
                    rd_state    <= 4'h1;
                end else
                    axi.rvalid  <= 1'b0;
            end
            4'h1: begin //read
                if ( axi.rready ) 
                    case ( read_addr )
                        `ETHERNET_TX_DONE: begin
                            axi.rdata   <= tx_done;
                            axi.rvalid  <= 1'b1;
                            axi.rlast   <= 1'b1;
                            rd_state    <= 4'h0;
                        end
                        `ETHERNET_RX_DATA: begin

                            if ( rx_ready ) 

                                if ( rx_data_count < counter ) begin
                                    rx_read_en      <= 1'b0;
                                    counter         <= 16'h0;
                                    rd_state        <= 4'h2;
                                    rx_clear        <= 1'b1;
                                    axi.rvalid      <= 1'b1;
                                    axi.rlast       <= 1'b1;
                                    axi.rdata       <= rx_data;
                                end else begin
                                    counter         <= counter + 4'h4;
                                    axi.rlast       <= 1'b0;
                                    axi.rvalid      <= 1'b1;
                                    axi.rdata       <= rx_data;
                                    rx_read_en      <= 1'b1;
                                    rd_state        <= 4'h3;
                                end

                            else begin
                                axi.rvalid      <= 1'b1;
                                axi.rlast       <= 1'b1;
                                axi.rdata       <= 32'h0;
                                rd_state        <= 4'h0;
                            end

                        end
                        `ETHERNET_RX_EMPTY: begin
                            axi.rdata   <= rx_ready;
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
                            axi.rdata   <= rx_protocol_type[15:0];
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
                else begin
                    axi.rvalid  <= 1'b0;
                    rx_read_en  <= 1'b0;
                end

                axi.arready <= 1'b0;

            end

        4'h2: begin
            if ( !rmii.crs_dv )
                rd_state    <= 4'h0;
            axi.rlast   <= 1'b0;
            axi.rvalid  <= 1'b0;
        end

        4'h3: begin
            rd_state        <= 4'h1;
            rx_read_en      <= 1'b0;
        end
        endcase
end

// write transaction
reg     [3:0]       wr_state;
reg     [31:0]      write_addr;
reg     [1:0]       tx_wr_data;
reg                 ready_to_send_packet;
reg                 last_data;

always@( posedge axi.aclk ) begin
    if ( axi.aresetn == 1'b0 ) begin
        wr_state                <= 4'h0;
        tx_wr_data              <= 2'b0;
        ready_to_send_packet    <= 1'b0;
        last_data               <= 1'b0;
        tx_valid                <= 1'b0;
    end else begin
        case ( wr_state )
            4'h0: begin
                
                if ( axi.awvalid )begin
                    wr_state    <= 4'h1;
                    write_addr  <= axi.awaddr;
                    axi.awready <= 1'b1;
                    tx_wr_data  <= 2'b00;
                end else begin
                    axi.awready <= 1'b0;
                end

            end
            4'h1: begin
                axi.awready <= 1'b0;
                
                if ( axi.wvalid ) begin

                    case ( write_addr )
                        `ETHERNET_TX_DATA_IN : begin


                            case ( tx_wr_data )
                                2'b00: 
                                    if ( tx_ready_to_write ) begin
                                        tx_wr_data  <= 2'b01;
                                        axi.wready  <= 1'b1;
                                    end

                                2'b01: begin
                                    if ( axi.wlast ) begin
                                        tx_valid                <= 1'b0;
                                        ready_to_send_packet    <= 1'b1;
                                        tx_wr_data              <= 2'b00;
                                        wr_state                <= 4'h2;
                                        last_data               <= 1'b1;
                                    end else begin
                                        tx_data_in  <= axi.wdata;
                                        tx_wr_data  <= 2'b10;
                                        tx_valid    <= 1'b1;
                                    end
                                end
                                2'b10: begin
                                    tx_wr_data  <= 2'b01;
                                    axi.wready  <= 1'b1;
                                    tx_valid    <= 1'b0;
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
                end else begin
                    axi.wready  <= 1'b0;
                    tx_valid    <= 1'b0;
                end
                
            end
            4'h2: begin
                axi.bvalid  <= 1'b1;
                axi.bresp   <= 2'b00;
                wr_state    <= 4'h3;
            end
            4'h3: begin
                axi.wready  <= 1'b0;
                wr_state    <= 4'h0;
                axi.bvalid  <= 1'b0;
            end
        endcase

    
    if ( tx_ready_to_send & ready_to_send_packet ) begin
        tx_send                 <= 1'b1;
        ready_to_send_packet    <= 1'b0;
        tx_valid                <= 1'b0;
        last_data               <= 1'b0;
    end else
        tx_send     <= 1'b0;
    
    end
    
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
.last_data              ( last_data         ),
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
