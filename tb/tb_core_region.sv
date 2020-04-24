`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2020 18:57:52
// Design Name: 
// Module Name: tb_core_region
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
`define CLOCK_PERIOD_100_MHZ 10.00ns

module tb_core_region();

reg                 clk     = 1'b1;
reg                 resetn;
reg          [31:0] irq = 32'h0;

AXI_LITE    core_master();


initial begin
    
    resetn  <= 1'b0;
    #(`CLOCK_PERIOD_100_MHZ*50)
    resetn  <= 1'b1;

    while(1) begin
        #(`CLOCK_PERIOD_100_MHZ)

        if ( core_master.awvalid)
            core_master.awready <= 1'b1;

        if ( core_master.wvalid)
            core_master.wready <= 1'b1;
    end
end

core_region core_region (
.clk            ( clk           ),
.resetn         ( resetn        ),
.irq            ( irq           ),
.eoi            ( eoi           ),
.core_master    ( core_master   )
);

initial begin
    forever begin
    #(`CLOCK_PERIOD_100_MHZ)clk <= ~clk;
    end
end

endmodule
