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

module tb_picoRV32();
parameter PROGADDR = 32'h0000;

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

wire [31:0]             mem_addr;
wire [31:0]             mem_wdata;
wire [3:0]              mem_wstrb;

reg [7:0] memory [32'h000FFFFF:0];

reg  [31:0] last_addr;



initial begin
    
    resetn  <= 1'b0;
    #(`CLOCK_PERIOD_100_MHZ*100)
    resetn  <= 1'b1;
    #(`CLOCK_PERIOD_100_MHZ)

    while (1) begin
        #(`CLOCK_PERIOD_100_MHZ*2-1)

        if ( mem_valid ) begin

            if ( mem_instr ) begin

                mem_rdata   <= {memory[mem_addr], memory[mem_addr+1], memory[mem_addr+2], memory[mem_addr+3]};
                $display("addr: %h, instr: %h",mem_addr,{memory[mem_addr], memory[mem_addr+1], memory[mem_addr+2], memory[mem_addr+3]});

            end
            else
                case ( mem_wstrb )
                    4'h0: begin 
                        mem_rdata        <= {memory[mem_addr], memory[mem_addr+1], memory[mem_addr+2], memory[mem_addr+3]};
                    end
                    4'hF: begin 
                        memory[mem_addr]   <= mem_wdata[31:24]; 
                        memory[mem_addr+1] <= mem_wdata[23:16]; 
                        memory[mem_addr+2] <= mem_wdata[15:8]; 
                        memory[mem_addr+3] <= mem_wdata[7:0]; 
                    end
                    4'h8: begin 
                        memory[mem_addr]   <= mem_wdata[31:24];
                    end
                    4'h4: begin 
                        memory[mem_addr+1] <= mem_wdata[23:16];
                    end
                    4'h2: begin 
                        memory[mem_addr+2] <= mem_wdata[15:8];
                    end
                    4'h1: begin 
                        memory[mem_addr+3] <= mem_wdata[7:0];
                        //$display("save data %h, strb: %h    > addr: %h, time: %t",mem_wdata,mem_wstrb, mem_addr, $realtime);
                    end
                endcase

            mem_ready   <= 1'b1;
        end else
            mem_ready   <= 1'b0;
        
        #1
        last_addr   <= mem_addr;
    end
end

initial begin
    #(`CLOCK_PERIOD_100_MHZ*220)
    irq <= 32'hFFFF;

end

picorv32 #(

.PROGADDR_RESET             ( `PROGADDR           ),
.REGS_INIT_ZERO             ( 1                  ),
.STACKADDR                  ( `STACKADDR         )
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

int i;

initial begin
    $readmemh("D:/projects/PicoRV32/src/sw/hex", memory);

    forever begin
    #(`CLOCK_PERIOD_100_MHZ)clk <= ~clk;
    end
end
endmodule
