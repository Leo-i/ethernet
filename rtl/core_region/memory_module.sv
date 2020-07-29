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


module memory_module#(
	parameter           INIT_FILE

) (
    input               clk,
    input               resetn,

    input               mem_valid_mem    ,
    input               mem_instr_mem    ,
    output reg          mem_ready_mem    ,
    input       [31:0]  mem_addr_mem     ,
    input       [31:0]  mem_wdata_mem    ,
    input       [3:0]   mem_wstrb_mem    ,
    output reg  [31:0]  mem_rdata_mem    
);

reg [7:0] mem [32768:0];
wire [31:0] addr;
assign addr = mem_addr_mem;

initial begin
    for ( int i=0,i=4;i<32768;i++) begin
      mem[i] = 8'h00;
    end
   $readmemh(INIT_FILE,mem);
end

always_ff@( posedge clk ) begin

    if (resetn == 0) 
        mem_ready_mem <= 1'b0;
    else if( mem_valid_mem ) begin
        
        if ( mem_wstrb_mem == 4'h0 ) begin
            mem_rdata_mem   <= { mem[addr+3], mem[addr+2], mem[addr+1], mem[addr] };
            mem_ready_mem   <= 1'b1;
        end else 
            case ( mem_wstrb_mem )
                
                4'hF: begin 
                    mem_ready_mem <= 1'b1; 
                    mem[addr+3] <= mem_wdata_mem[31:24]; 
                    mem[addr+2] <= mem_wdata_mem[23:16];
                    mem[addr+1] <= mem_wdata_mem[15:8];
                    mem[addr]   <= mem_wdata_mem[7:0];
                end

                //'h3: begin mem_ready_mem <= 1'b1; mem[addr][15:0] <= mem_wdata_mem[15:0]; end
                //'h6: begin mem_ready_mem <= 1'b1; mem[addr][23:8] <= mem_wdata_mem[23:8]; end
                //'hC: begin mem_ready_mem <= 1'b1; mem[addr][31:16] <= mem_wdata_mem[31:16]; end

                4'h1: begin 
                    mem_ready_mem <= 1'b1; 
                    mem[addr] <= mem_wdata_mem[7:0]; 
                end
                4'h2: begin 
                    mem_ready_mem <= 1'b1; 
                    mem[addr + 1]<= mem_wdata_mem[15:8]; 
                end
                4'h4: begin 
                    mem_ready_mem <= 1'b1; 
                    mem[addr + 2] <= mem_wdata_mem[23:16]; 
                end
                4'h8: begin 
                    mem_ready_mem <= 1'b1; 
                    mem[addr + 3] <= mem_wdata_mem[31:24]; 
                end

                default:;
            endcase
        
    end else
        mem_ready_mem   <= 1'b0;
end

// wire we;
// wire en;

// reg [31:0] addra;
// reg        ena;
// reg [1:0]  valid;       

// assign we = mem_valid_mem && !(mem_wstrb_mem == 4'h0);
// assign en = mem_valid_mem & ( (mem_wstrb_mem == 4'h0) || mem_instr_mem);

// assign mem_ready_mem = valid[0] && mem_valid_mem;

// always_ff@( posedge clk ) begin

//     if ( (we || en) && (valid == 0) )
//         valid[1]   <= 1'b1;
//     else
//         valid[1]   <= 1'b0;

//     valid[0]   <= valid[1];

// end

// always_comb begin
    
//     if ( resetn ) begin
//         addra = (mem_addr_mem >> 2);
//         ena   = en;
//     end else begin //init
//         addra = 32'h0;
//         ena   = 1'b1;
//     end
// end

// blk_mem_gen_0 BRAM(
// .clka   ( clk              ),
// .ena    ( ena || we        ),
// .wea    ( we                ),
// .addra  ( addra             ),
// .dina   ( mem_wdata_mem     ),
// .douta  ( mem_rdata_mem     )
// );

endmodule
