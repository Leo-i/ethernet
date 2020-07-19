`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2020 19:21:55
// Design Name: 
// Module Name: tb_DM_controller
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

`define DM_period 40.00ns

module tb_DM_controller();

reg             clk_25_mhz   = 0;
reg             rst_n        = 1;
reg             DM_start     ;
reg  [10:0]     DM_addr_mode ;
reg  [15:0]     DM_data_write;
wire            MDIO_io         ;
wire  [15:0]    DM_data_read ;
wire            DM_busy      ;

int     i = 0;
reg     mode = 1; //read - 0, write - 1
reg     MDIO;
assign MDIO_io = ( mode ) ? MDIO : 1'bZ;

initial begin
    rst_n     <= 1'b0;
    #(100*`DM_period);
    rst_n     <= 1'b1;

    DM_addr_mode[10:6]  <= 5'b01101;
    DM_addr_mode[5:1]   <= 5'b01010;
    DM_addr_mode[0]     <= 1'b0; // change
    DM_data_write[15:0] <= 16'hABCD;

    #(100.00ns)
    DM_start    <= 1'b1;

    #(16*`DM_period);

    for ( i = 15; i >= 0 ; i-- ) begin
        #(`DM_period);
        MDIO <= DM_data_write[i];
    end

    DM_start    <= 1'b0;    
    while(DM_busy == 1)#10;

    $finish();

end


controller DM_controller(
.clk                ( clk_25_mhz        ),
.rst_n              ( rst_n             ),
.start_i            ( DM_start          ),
.addr_mode_i        ( DM_addr_mode      ),
.data_i             ( DM_data_write     ),
.MDIO_io            ( MDIO_io           ),
.data_o             ( DM_data_read      ),
.busy_o             ( DM_busy           )
);

always begin
    #(`DM_period/2) clk_25_mhz = ~clk_25_mhz;
end
endmodule
