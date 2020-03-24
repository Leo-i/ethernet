`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2020 17:07:06
// Design Name: 
// Module Name: tb_controller
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


module tb_controller();

reg         clk          = 1'b1;
reg         rst_n        = 1'b1;

reg         start        = 1'b0;
reg         mode         = 1'b1;
reg [4:0]   addr         = 5'b11011;
reg [4:0]   reg_addr     = 5'b11011;
reg [15:0]  data         = 16'hCC33;

int i;

controller ctu(
.clk        (    clk         ),
.rst_n      (    rst_n       ),
.start      (    start       ),
.mode_i     (    mode        ),
.addr_i     (    addr        ),
.reg_addr_i (    reg_addr    ),
.data_i     (    data        ),
.MDIO_io    (    MDIO_w      ),
.data_o     (    data_o      ),
.done       (    done        )
);


reg write = 0;
reg MDIO;
assign MDIO_w = ( write ) ? MDIO : 1'bZ;

initial begin
    #30
    rst_n   <= 1'b0;
    #10
    rst_n   <= 1'b1;

    #20
    start   <= 1'b1;
    #20
    start   <= 1'b0;


    if ( mode == 1 ) begin
        # 280
        write   <= 1;
        MDIO    <= 0;
            for (i = 0; i<16 ; i++ ) begin
                #20
                MDIO    <= data[i];
                
            end
    end
    #1000
    $finish;

end

initial begin
    forever begin
        #10
        clk <= !clk;
    end
end
endmodule
