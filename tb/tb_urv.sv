`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 21:33:17
// Design Name: 
// Module Name: tb_picoRV32
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

module tb_urv();

wire [31:0]             mem_la_addr ;
wire [31:0]             mem_la_wdata;
wire [3:0]              mem_la_wstrb;

reg                     clk         = 1'b1;
reg                     resetn      = 1'b1;
reg                     mem_ready   = 1'b0;
reg  [31:0]             mem_rdata   = 32'b0;

reg                     pcpi_wr     = 1'b0;
reg  [31:0]             pcpi_rd     = 32'b0;
reg                     pcpi_wait   = 1'b0;
reg                     pcpi_ready  = 1'b0;

reg  [31:0]             irq         = 32'h0;

wire [31:0]             mem_wdata;
wire [3:0]              mem_wstrb;
wire [31:0]             mem_addr;
reg  [7:0]              memory [12'hFFF:0];
reg  [7:0]              instructions [1024:0];

reg  [31:0] last_addr;

wire    [31:0]      im_addr_o;
reg     [31:0]      im_data_i;
reg                 im_valid_i;

wire [3:0]          dm_data_select_o;
reg  [31:0]         dm_data_l_i;
wire [31:0]         dm_data_s_o;

reg                 dm_store_done_i;
reg                 dm_load_done_i;
wire [31:0]         mem_addr_o;
assign mem_addr = mem_addr_o & 32'h00000FFF;

initial begin
    
    resetn  <= 1'b0;
    #(`CLOCK_PERIOD_100_MHZ*100)
    resetn  <= 1'b1;
    #(`CLOCK_PERIOD_100_MHZ)

    while (1) begin
        #(`CLOCK_PERIOD_100_MHZ)
        
        im_data_i   <= { instructions[im_addr_o],instructions[im_addr_o+1],instructions[im_addr_o+2],instructions[im_addr_o+3]};
        if ( im_addr_o == 32'h64)
            im_valid_i  <= 1;
    end
end

//memory
always@( posedge clk ) begin

        if ( dm_load_o ) begin
            dm_data_l_i         <= {memory[mem_addr], memory[mem_addr+1], memory[mem_addr+2], memory[mem_addr+3]};
            dm_load_done_i      <= 1'b1; 
        end else
            dm_load_done_i      <= 1'b0; 


        if ( dm_store_o ) begin

            dm_store_done_i <= 1'b1;
           
            case ( dm_data_select_o )
                4'hF: begin 
                    memory[mem_addr]   <= dm_data_s_o[31:24]; 
                    memory[mem_addr+1] <= dm_data_s_o[23:16]; 
                    memory[mem_addr+2] <= dm_data_s_o[15:8]; 
                    memory[mem_addr+3] <= dm_data_s_o[7:0]; 
                     $display("save data ");
                end
                4'h8: begin 
                    memory[mem_addr]   <= dm_data_s_o[31:24];
                end
                4'h4: begin 
                    memory[mem_addr+1] <= dm_data_s_o[23:16];
                end
                4'h2: begin 
                    memory[mem_addr+2] <= dm_data_s_o[15:8];
                end
                4'h1: begin 
                    memory[mem_addr+3] <= dm_data_s_o[7:0];
                    //$display("save data %h, strb: %h    > addr: %h, time: %t",mem_wdata,mem_wstrb, mem_addr, $realtime);
                end
            endcase

        end else
            dm_store_done_i <= 1'b0;

end


initial begin
    #(`CLOCK_PERIOD_100_MHZ*220)
    irq <= 32'hFFFF;
end

assign dm_ready_i = 1'b1;

urv_cpu urv_cpu(
.clk_i              ( clk               ),
.rst_i              ( !resetn           ),

.irq_i              ( irq[0]            ),
   
   // instruction mem I/F
.im_addr_o          ( im_addr_o         ),
.im_data_i          ( im_data_i         ),
.im_valid_i         ( im_valid_i        ),

   // data mem I/F
.dm_addr_o          ( mem_addr_o        ),
.dm_data_s_o        ( dm_data_s_o       ),
.dm_data_l_i        ( dm_data_l_i       ),
.dm_data_select_o   ( dm_data_select_o  ),
.dm_ready_i         ( dm_ready_i        ),

.dm_store_o         ( dm_store_o        ),
.dm_load_o          ( dm_load_o         ),
.dm_load_done_i     ( dm_load_done_i    ),
.dm_store_done_i    ( dm_store_done_i   )
);
/*
picorv32 #(
.PROGADDR_IRQ               ( `PROGADDR_IRQ   ),
.PROGADDR_RESET             ( `PROGADDR       ),
.REGS_INIT_ZERO             ( 1               ),
.STACKADDR                  ( `STACKADDR      ),
.ENABLE_IRQ                 ( 1               ),
.MASKED_IRQ                 ( 32'h0           ),
.LATCHED_IRQ                ( 32'h00000000    ),
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

.mem_la_read                ( mem_la_read     ),
.mem_la_write               ( mem_la_write    ),
.mem_la_addr                ( mem_la_addr     ),
.mem_la_wdata               ( mem_la_wdata    ),
.mem_la_wstrb               ( mem_la_wstrb    ),

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
*/
int i;

initial begin
    $readmemh("D:/projects/PicoRV32/src/sw/hex", instructions);
    
    for (i = 0;i<12'hFFF ;i++ ) begin
        memory[i] = 8'h00;
    end

    forever begin
    #(`CLOCK_PERIOD_100_MHZ)clk <= ~clk;
    end
end
endmodule
