`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 11:32:49
// Design Name: 
// Module Name: led_ctrl
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

//`include "addr_defines.sv"
//`include "axi_lite_bus.sv"

module led_ctrl(
    AXI_LITE.slave      axi,

    output reg  [7:0]   led
);

reg     [3:0]       wr_state;
reg     [31:0]      write_addr;

always@( posedge axi.aclk ) begin
    if ( axi.aresetn == 1'b0 ) begin
        led         <= 8'h0;
        wr_state    <= 4'h0;
    end
        case ( wr_state )
            4'h0: 
                
                if ( axi.awvalid )begin
                    wr_state    <= 4'h1;
                    write_addr  <= axi.awaddr;
                    axi.awready <= 1'b1;
                end else begin
                    axi.awready <= 1'b0;
                end

            4'h1: 
                if ( axi.wvalid )
                    case ( write_addr )
                        `LED_CTRL : begin
                            led         <= axi.wdata;
                            axi.wready  <= 1'b1;

                            if ( axi.wlast )
                                wr_state    <= 4'h2;
                        end
                        default: wr_state   <= 4'h0;
                    endcase
            4'h2: begin
                axi.bvalid  <= 1'b1;
                axi.bresp   <= 2'b00;
                wr_state    <= 4'h3;
            end
            4'h3: begin
                wr_state    <= 4'h0;
                axi.bvalid  <= 1'b0;
            end
        endcase
end

endmodule
