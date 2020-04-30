`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2020 19:11:38
// Design Name: 
// Module Name: mux_from_core
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


module mux_from_core(

input               mem_valid    ,
input               mem_instr    ,
output              mem_ready    ,
input       [31:0]  mem_addr     ,
input       [31:0]  mem_wdata    ,
input       [3:0]   mem_wstrb    ,
output      [31:0]  mem_rdata    ,

output              mem_valid_mem,
output              mem_instr_mem,
input               mem_ready_mem,
output      [31:0]  mem_addr_mem ,
output      [31:0]  mem_wdata_mem,
output      [3:0]   mem_wstrb_mem,
input       [31:0]  mem_rdata_mem,

output              mem_valid_axi,
output              mem_instr_axi,
input               mem_ready_axi,
output      [31:0]  mem_addr_axi ,
output      [31:0]  mem_wdata_axi,
output      [3:0]   mem_wstrb_axi,
input       [31:0]  mem_rdata_axi
);

wire  to_mem;
assign to_mem = (mem_addr < `ETHERNET_1_BASE_ADDR);

assign mem_valid_mem = (to_mem) ? mem_valid : 0;
assign mem_instr_mem = (to_mem) ? mem_instr : 0;
assign mem_ready     = (to_mem) ? mem_ready_mem : mem_ready_axi;
assign mem_addr_mem  = (to_mem) ? mem_addr : 0;
assign mem_wdata_mem = (to_mem) ? mem_wdata : 0;
assign mem_wstrb_mem = (to_mem) ? mem_wstrb : 0;
assign mem_rdata     = (to_mem) ? mem_rdata_mem : mem_rdata_axi;

assign mem_valid_axi = (!to_mem) ? mem_valid : 0;
assign mem_instr_axi = (!to_mem) ? mem_instr : 0;
assign mem_addr_axi  = (!to_mem) ? mem_addr : 0;
assign mem_wdata_axi = (!to_mem) ? mem_wdata : 0;
assign mem_wstrb_axi = (!to_mem) ? mem_wstrb : 0;


endmodule
