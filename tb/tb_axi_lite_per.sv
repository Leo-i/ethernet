`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2020 17:30:24
// Design Name: 
// Module Name: tb_axi_lite_per
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
`include "addr_defines.sv"
`include "axi_lite_bus.sv"
`include "RMII_interface.sv"

`define CLK_PERIOD_100_MHZ     10.00ns
`define CLK_PERIOD_50_MHZ      20.00ns
`define CLK_PERIOD_25_MHZ      40.00ns


module tb_axi_lite_per();

reg                 clk_100_mhz = 1'b1;
reg                 clk_50_mhz  = 1'b1;
reg                 clk_25_mhz  = 1'b1;
reg                 rst_n       = 1'b1;

AXI_LITE axi();
AXI_LITE axi_led();
AXI_LITE axi_uart();
AXI_LITE axi_ethernet_1();
AXI_LITE axi_ethernet_2();
RMII     rmii();

wire                awready;
wire                wready ;
wire       [1:0]    bresp  ;
wire                bvalid ;
wire                bready ;
wire                arready;
wire       [31:0]   rdata  ;
wire                rlast  ;
wire                rvalid ;
wire                aclk   ;
wire                aresetn;

reg        [31:0]   awaddr  = 1'b0;
reg                 awvalid = 1'b0;
reg        [31:0]   wdata   = 1'b0;
reg                 wlast   = 1'b0;
reg                 wvalid  = 1'b0;
reg        [31:0]   araddr  = 1'b0;
reg                 arvalid = 1'b0;
reg                 rready  = 1'b0;

assign axi.awaddr   = awaddr ;
assign axi.awvalid  = awvalid;
assign axi.wdata    = wdata  ;
assign axi.wlast    = wlast  ;
assign axi.wvalid   = wvalid ;
assign axi.araddr   = araddr ;
assign axi.arvalid  = arvalid;
assign axi.rready   = rready ;

assign axi.aclk     = clk_100_mhz;
assign axi.aresetn  = rst_n;


reg     [31:0]  rdata_q;
task receive_data(
    input [31:0]    addr
);
    begin
        araddr  <= addr;
        arvalid <= 1'b1;

        while ( !arready ) 
            #(`CLK_PERIOD_100_MHZ);

        #(`CLK_PERIOD_100_MHZ);
        arvalid <= 1'b0;
        rready  <= 1'b1;

        while ( 1 ) begin
            
            if ( rvalid ) begin
                $display("data received %h", rdata);
                
                if ( rlast )
                    break;
            end
                
            #(`CLK_PERIOD_100_MHZ);
        end

        #(`CLK_PERIOD_100_MHZ);
        rready  <= 1'b0;

        
    end
endtask
int i = 0;

task send_data(
    input [31:0]    addr,
    input [31:0]    data,
    input [31:0]    data_count
);
    begin
        awaddr  <= addr;
        awvalid <= 1'b1;

        while ( !(awready == 1) ) 
            #(`CLK_PERIOD_100_MHZ);
        
        #(`CLK_PERIOD_100_MHZ);
        awvalid <= 1'b0;

        i   <= 0;
        while (1) begin

            if ( i == data_count ) begin
                wlast   <= 1'b1;
            end
            i = i + 1;
            wdata   <= data;
            wvalid  <= 1'b1;
            
            #(`CLK_PERIOD_100_MHZ);
            if ( i == data_count ) 
               break;

            while ( !(wready == 1) )
                #(`CLK_PERIOD_100_MHZ);

        end
        $display("data sended ");
    end
endtask

initial begin
    rst_n     <= 1'b0;
    #(100*`CLK_PERIOD_100_MHZ);
    rst_n     <= 1'b1;

    #(100*`CLK_PERIOD_100_MHZ);
    receive_data(`UART_BASE_ADDR+`UART_TX_BUSY);
    //send_data(`LED_BASE_ADDR+`LED_CTRL, 32'h00000005,1); // set led 
    
    
end


axi_interconnect axi_interconnect(
.axi                 ( axi               ),
.axi_led             ( axi_led           ),
.axi_uart            ( axi_uart          ),
.axi_ethernet_1      ( axi_ethernet_1    ),
.axi_ethernet_2      ( axi_ethernet_2    )  
);

led_ctrl led_ctrl(
.axi                 ( axi_led          ),
.led                 ( led              )
);

AXI_uart AXI_uart(
.clk_50_mhz           ( clk_50_mhz       ),
.axi                  ( axi_uart         ),
.uart_tx              ( uart_tx          ),
.uart_rx              ( uart_rx          ),
.rx_ready_int         ( uart_int         )
);

AXI_ethernet AXI_ethernet_1(
.clk_25_mhz          ( clk_25_mhz       ),
.clk_50_mhz          ( clk_50_mhz       ),
.axi                 ( axi_ethernet_1   ),
.rmii                ( rmii             ),
.rx_ready_int        ( eth_1_int        )
);

AXI_ethernet AXI_ethernet_2(
.clk_25_mhz          ( clk_25_mhz       ),
.clk_50_mhz          ( clk_50_mhz       ),
.axi                 ( axi_ethernet_2   ),
.rmii                ( rmii             ),
.rx_ready_int        ( eth_2_int        )
);

initial begin
    fork
        forever #(`CLK_PERIOD_100_MHZ/2) clk_100_mhz    = ~clk_100_mhz;
        forever #(`CLK_PERIOD_50_MHZ/2) clk_50_mhz      = ~clk_50_mhz;
        forever #(`CLK_PERIOD_25_MHZ/2) clk_25_mhz      = ~clk_25_mhz;
    join_none
end


endmodule
