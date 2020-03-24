`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2020 16:18:15
// Design Name: 
// Module Name: ethernet_module
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


module ethernet_module(

    input               clk_100_mhz,
    input               clk_25_mhz,
    input               clk_50_mhz,
    input               rst_n,

// Tx =====================================
    input               tx_send,
    input       [31:0]  tx_data_in,
    input               tx_valid,
    output              tx_ready_to_write,
    output              tx_ready_to_send, 
    output              tx_done,

// Rx =====================================
    output              rx_ready,
    output      [31:0]  rx_data,
    input               rx_read_en,
    output              rx_empty,
    output      [15:0]  rx_data_count,
    output      [15:0]  rx_protocol_type,
    input               rx_clear,

// DM =====================================
    input                DM_start,
    input                DM_mode, 
    input       [4:0]    DM_addr,
    input       [4:0]    DM_reg_addr,
    input       [15:0]   DM_data_i,
    output               DM_data_o,
    output               DM_done,
// RMII ===================================
    output      [1:0]   tx_d,
    output              tx_e,
    input               rx_er,
    input       [1:0]   rx_d,
    input               crs_dv,
    inout               MDIO,
    output              MDC
);

assign MDC = clk_25_mhz;

controller DM_controller(
.clk                ( clk_25_mhz        ),
.rst_n              ( rst_n             ),
.start              ( DM_start          ),
.mode_i             ( DM_mode           ), 
.addr_i             ( DM_addr           ),
.reg_addr_i         ( DM_reg_addr       ),
.data_i             ( DM_data_i         ),
.MDIO_io            ( MDIO              ),
.data_o             ( DM_data_o         ),
.done               ( DM_done           )
);

wire reset;
assign reset = ( rst_n && (!rx_clear) );

receiver_wrapper receiver(
.clk_100_mhz        ( clk_100_mhz       ),
.clk_50_mhz         ( clk_50_mhz        ),
.rst_n              ( reset             ),
.rx_er              ( rx_er             ),
.rx_d               ( rx_d              ),
.crs_dv             ( crs_dv            ),
.ready              ( rx_ready          ),
.data_o             ( rx_data           ),
.read_en            ( rx_read_en        ),
.empty              ( rx_empty          ),
.data_count         ( rx_data_count     ),
.protocol_type      ( rx_protocol_type  )     
);


transmitter_wrapper transmitter(
.clk_100_mhz        ( clk_100_mhz       ),
.clk_50_mhz         ( clk_50_mhz        ),
.rst_n              ( rst_n             ),
.send               ( tx_send           ),
.data_in            ( tx_data_in        ),
.valid              ( tx_valid          ),
.ready_to_write     ( tx_ready_to_write ),
.ready_to_send      ( tx_ready_to_send  ), 
.done               ( tx_done           ),
.tx_d               ( tx_d              ),
.tx_e               ( tx_e              )
);

endmodule