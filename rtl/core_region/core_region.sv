`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2020 17:43:36
// Design Name: 
// Module Name: core_region
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


module core_region (
    input           clk,
    input           resetn,

    input   [31:0]  irq,
    output          eoi,

    AXI_LITE.master core_master
);


wire           mem_valid    ;
wire           mem_instr    ;
wire           mem_ready    ;
wire    [31:0] mem_addr     ;
wire    [31:0] mem_wdata    ;
wire    [3:0]  mem_wstrb    ;
wire    [31:0] mem_rdata    ;

wire           mem_valid_mem;
wire           mem_instr_mem;
wire           mem_ready_mem;
wire    [31:0] mem_addr_mem ;
wire    [31:0] mem_wdata_mem;
wire    [3:0]  mem_wstrb_mem;
wire    [31:0] mem_rdata_mem;

wire           mem_valid_axi;
wire           mem_instr_axi;
wire           mem_ready_axi;
wire    [31:0] mem_addr_axi ;
wire    [31:0] mem_wdata_axi;
wire    [3:0]  mem_wstrb_axi;
wire    [31:0] mem_rdata_axi;

core2axi core2axi(
.clk                        ( clk           ),
.resetn                     ( resetn        ),

.mem_valid_axi              ( mem_valid_axi ),
.mem_instr_axi              ( mem_instr_axi ),
.mem_ready_axi              ( mem_ready_axi ),
.mem_addr_axi               ( mem_addr_axi  ),
.mem_wdata_axi              ( mem_wdata_axi ),
.mem_wstrb_axi              ( mem_wstrb_axi ),
.mem_rdata_axi              ( mem_rdata_axi ),

.core_master                ( core_master   )
);

memory_module memory_module(
.clk                        ( clk           ),
.resetn                     ( resetn        ),

.mem_valid_mem              ( mem_valid_mem ),
.mem_instr_mem              ( mem_instr_mem ),
.mem_ready_mem              ( mem_ready_mem ),
.mem_addr_mem               ( mem_addr_mem  ),
.mem_wdata_mem              ( mem_wdata_mem ),
.mem_wstrb_mem              ( mem_wstrb_mem ),
.mem_rdata_mem              ( mem_rdata_mem )
);

mux_from_core mux_from_core(
.mem_valid                  ( mem_valid     ),
.mem_instr                  ( mem_instr     ),
.mem_ready                  ( mem_ready     ),
.mem_addr                   ( mem_addr      ),
.mem_wdata                  ( mem_wdata     ),
.mem_wstrb                  ( mem_wstrb     ),
.mem_rdata                  ( mem_rdata     ),

.mem_valid_mem              ( mem_valid_mem ),
.mem_instr_mem              ( mem_instr_mem ),
.mem_ready_mem              ( mem_ready_mem ),
.mem_addr_mem               ( mem_addr_mem  ),
.mem_wdata_mem              ( mem_wdata_mem ),
.mem_wstrb_mem              ( mem_wstrb_mem ),
.mem_rdata_mem              ( mem_rdata_mem ),

.mem_valid_axi              ( mem_valid_axi ),
.mem_instr_axi              ( mem_instr_axi ),
.mem_ready_axi              ( mem_ready_axi ),
.mem_addr_axi               ( mem_addr_axi  ),
.mem_wdata_axi              ( mem_wdata_axi ),
.mem_wstrb_axi              ( mem_wstrb_axi ),
.mem_rdata_axi              ( mem_rdata_axi )

);

reg                     pcpi_wr     = 1'b0;
reg  [31:0]             pcpi_rd     = 32'b0;
reg                     pcpi_wait   = 1'b0;
reg                     pcpi_ready  = 1'b0;

picorv32 #(

.PROGADDR_RESET             ( 32'h00000530      ),
.REGS_INIT_ZERO             ( 1                 ),
.STACKADDR                  ( 32'h00008000      )
) core (
.clk                        ( clk             ),
.resetn                     ( resetn          ),
.trap                       ( trap            ),

.mem_valid                  ( mem_valid       ),
.mem_instr                  ( mem_instr       ),
.mem_ready                  ( mem_ready       ),

.mem_addr                   ( mem_addr        ),
.mem_wdata                  ( mem_wdata       ),
.mem_wstrb                  ( mem_wstrb       ),
.mem_rdata                  ( mem_rdata       ),

.mem_la_read                (),
.mem_la_write               (),
.mem_la_addr                (),
.mem_la_wdata               (),
.mem_la_wstrb               (),

.pcpi_valid                 ( pcpi_valid      ),
.pcpi_insn                  ( pcpi_insn       ),
.pcpi_rs1                   ( pcpi_rs1        ),
.pcpi_rs2                   ( pcpi_rs2        ),
.pcpi_wr                    ( pcpi_wr         ),
.pcpi_rd                    ( pcpi_rd         ),
.pcpi_wait                  ( pcpi_wait       ),
.pcpi_ready                 ( pcpi_ready      ),

.irq                        ( irq             ),
.eoi                        ( eoi             ),

.trace_valid                ( trace_valid     ),
.trace_data                 ( trace_data      )
);

endmodule
