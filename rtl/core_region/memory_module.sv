`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2020 19:09:17
// Design Name: 
// Module Name: memory_module
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


module memory_module (
input               clk,
    input               resetn,

    input               mem_valid_mem    ,
    input               mem_instr_mem    ,
    output              mem_ready_mem    ,
    input       [31:0]  mem_addr_mem     ,
    input       [31:0]  mem_wdata_mem    ,
    input       [3:0]   mem_wstrb_mem    ,
    output      [31:0]  mem_rdata_mem    
);

wire we;
wire en;

reg [31:0] addra;
reg        ena;
reg [1:0]  valid;       

assign we = mem_valid_mem && !(mem_wstrb_mem == 4'h0);
assign en = mem_valid_mem & ( (mem_wstrb_mem == 4'h0) || mem_instr_mem);

assign mem_ready_mem = valid[0] && mem_valid_mem;

always_ff@( posedge clk ) begin

    if ( (we || en) && (valid == 0) )
        valid[1]   <= 1'b1;
    else
        valid[1]   <= 1'b0;

    valid[0]   <= valid[1];

end

always_comb begin
    
    if ( resetn ) begin
        addra = (mem_addr_mem >> 2);
        ena   = en;
    end else begin //init
        addra = 32'h0;
        ena   = 1'b1;
    end
end

blk_mem_gen_0 BRAM(
.clka   ( clk              ),
.ena    ( ena || we        ),
.wea    ( we                ),
.addra  ( addra             ),
.dina   ( mem_wdata_mem     ),
.douta  ( mem_rdata_mem     )
);

endmodule
