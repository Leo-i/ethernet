`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2020 19:07:41
// Design Name: 
// Module Name: core2axi
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


module core2axi(
    input           clk,
    input           resetn,

    input               mem_valid_axi    ,
    input               mem_instr_axi    ,
    output  reg         mem_ready_axi    ,
    input       [31:0]  mem_addr_axi     ,
    input       [31:0]  mem_wdata_axi    ,
    input       [3:0]   mem_wstrb_axi    ,
    output  reg [31:0]  mem_rdata_axi    ,

    AXI_LITE.master     core_master
);

parameter brust_begin = 32'hA0A00B08;

reg [31:0]  data;
reg [31:0]  addr;
reg [2:0]   mode;

reg [2:0]   wr_state;
reg [2:0]   rd_state;

always_ff@( posedge clk ) begin
    if ( resetn == 0) begin
        data            <= 32'h0;
        addr            <= 32'h0;
        mode            <= 3'b000;
        wr_state        <= 3'h0;
        rd_state        <= 3'h0;
    end else

        case( mode )
            3'b000: begin // idle

                if ( mem_valid_axi ) 

                    if ( !(mem_wstrb_axi == 4'h0) )  //write
                        
                        if ( mem_addr_axi == brust_begin ) begin
                            mode          <= 3'b100;
                            mem_ready_axi <= 1'b1;
                        end else begin
                            mode    <= 3'b001;
                            addr    <= mem_addr_axi;
                            data    <= mem_wdata_axi;
                        end

                    else //read

                        if ( mem_addr_axi == brust_begin ) begin
                            mode    <= 3'b101;
                            mem_ready_axi <= 1'b1;
                        end else begin
                            mode    <= 3'b010;
                            addr    <= mem_addr_axi;
                        end
                    
                else
                    mem_ready_axi   <= 1'b0;

            end
            3'b010: begin //read state
                case( rd_state )
                    3'h0: begin
                        
                        if ( core_master.arready ) begin
                            rd_state            <= 3'h1;
                            core_master.rready  <= 1'b1;
                            core_master.arvalid <= 1'b0;
                        end else begin
                            core_master.araddr  <= addr;
                            core_master.arvalid <= 1'b1;
                            core_master.rready  <= 1'b0;
                        end
                    end
                    3'h1:
                        if ( core_master.rvalid ) begin
                            mem_rdata_axi   <= core_master.rdata;
                            mem_ready_axi   <= 1'b1;
                            rd_state        <= 3'h2;
                        end
                    3'h2: begin
                        mode            <= 3'b000;
                        rd_state        <= 3'h0;
                        core_master.rready  <= 1'b0;
                    end
                endcase
            end
            3'b001: begin //write single

                case( wr_state )
                    3'h0: begin
                        core_master.wvalid  <= 1'b0;
                        core_master.wlast   <= 1'b0;
                        core_master.awaddr  <= addr;
                        core_master.awvalid <= 1'b1;
                        if ( core_master.awready )
                            wr_state    <= 3'h1;
                    end
                    3'h1: begin
                        core_master.awvalid <= 1'b0;
                        core_master.wvalid  <= 1'b1;
                        core_master.wdata   <= data;
                        core_master.wlast   <= 1'b1;
                        if ( core_master.wready ) begin
                            wr_state        <= 3'h2;
                            mem_ready_axi   <= 1'b1;
                        end
                    end
                    3'h2: begin
                        wr_state        <= 3'h0;
                        mode            <= 3'b000;
                    end
                endcase
            end
            3'b100: begin //write brust
                case( wr_state )
                    3'h0: begin
                        mem_ready_axi <= 1'b1;
                        wr_state      <= 3'h7;
                        
                        core_master.wlast   <= 1'b0;
                        core_master.wvalid  <= 1'b0;
                    end

                    3'h1: begin

                         if ( mem_valid_axi ) begin
                            core_master.awaddr  <= mem_addr_axi;
                            core_master.awvalid <= 1'b1;

                            if ( core_master.awready ) begin
                                wr_state    <= 3'h2;
                                core_master.awvalid <= 1'b0;
                            end
                        end

                    end

                    3'h2: begin
                        
                        if ( mem_valid_axi ) 
                            if ( mem_addr_axi == brust_begin ) begin
                                wr_state            <= 3'h4;
                                core_master.wlast   <= 1'b1;
                                mem_ready_axi       <= 1'b1;
                                core_master.wvalid  <= 1'b1;
                            end else begin
                                core_master.wdata   <= mem_wdata_axi;
                                wr_state            <= 3'h3;
                                core_master.wvalid  <= 1'b1;
                                core_master.wlast   <= 1'b0;
                            end                            
                        
                    end

                    3'h3: begin
                        
                        if ( core_master.wready ) begin
                            wr_state            <= 3'h5;
                            mem_ready_axi       <= 1'b1;
                            core_master.wvalid  <= 1'b0;
                        end

                    end

                    3'h5: begin
                        mem_ready_axi       <= 1'b0;
                        wr_state            <= 3'h2;
                    end


                    3'h4: begin
                        if ( core_master.wready ) begin
                            wr_state            <= 3'h0;
                            mode                <= 3'b000;
                            core_master.wvalid  <= 1'b0;
                        end
                    end

                     3'h7: begin
                        wr_state        <= 3'h1;
                        mem_ready_axi   <= 1'b0;
                    end

                endcase
            end
            3'b101: begin //read brust
                case ( rd_state )

                    3'h0:begin //init
                        mem_ready_axi       <= 1'b0;
                        core_master.rready  <= 1'b0;
                        if ( mem_valid_axi )
                            rd_state        <= 3'h1;
                    end
                    3'h1: begin //send addr
                        if ( core_master.arready ) begin
                            rd_state            <= 3'h2;
                            core_master.arvalid <= 1'b0;
                            core_master.rready  <= 1'b1;
                        end else begin
                            core_master.araddr  <= mem_addr_axi;
                            core_master.arvalid <= 1'b1;
                        end
                    end
                    3'h2: begin //rdata
                        if ( core_master.rvalid ) begin
                            mem_rdata_axi       <= core_master.rdata;
                            mem_ready_axi       <= 1'b1;
                            core_master.rready  <= 1'b0;
                            if ( core_master.rlast )
                                rd_state        <= 3'h7;
                            else
                                rd_state        <= 3'h5;
                        end
                    end
                    3'h3: begin//send data to core
                        if ( mem_valid_axi ) begin
                            rd_state            <= 3'h2;
                            core_master.rready  <= 1'b1;
                            
                        end
                    end
                    3'h5: begin//wait
                        mem_ready_axi       <= 1'b0;
                        if ( !mem_valid_axi)
                            rd_state            <= 3'h3;
                    end
                    3'h7: begin
                        rd_state        <= 3'h6;
                        mem_ready_axi   <= 1'b0;
                    end
                    3'h6: begin
                        if ( mem_valid_axi ) begin
                            mem_rdata_axi   <= brust_begin;
                            mem_ready_axi   <= 1'b1;
                            rd_state        <= 3'h4;
                        end else begin
                            mem_ready_axi   <= 1'b0;
                        end
                    end
                    3'h4: begin//end transaction
                        rd_state        <= 3'h0;
                        mode            <= 3'b000;
                        mem_ready_axi   <= 1'b0;
                    end
                endcase
            end
        endcase
end

endmodule
