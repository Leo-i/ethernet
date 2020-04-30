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
RMII     rmii_1();
RMII     rmii_2();

assign rmii_1.rx_d[1:0] = rmii_1.tx_d[1:0];
assign rmii_1.rx_er     = !rmii_1.tx_e;
assign rmii_1.crs_dv    = rmii_1.tx_e;



wire [7:0]  led;

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

assign awready      = axi.awready;
assign wready       = axi.wready ;
assign bresp        = axi.bresp  ;
assign bvalid       = axi.bvalid ;
assign bready       = axi.bready ;
assign arready      = axi.arready;
assign rdata        = axi.rdata  ;
assign rlast        = axi.rlast  ;
assign rvalid       = axi.rvalid ;
assign aclk         = axi.aclk   ;
assign aresetn      = axi.aresetn;

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
                $display("data received %h, with addres %h", rdata, addr);
                
                if ( rlast )
                    break;
            end
                
            #(`CLK_PERIOD_100_MHZ);
        end
        #(`CLK_PERIOD_100_MHZ);
        rready  <= 1'b0;

        
    end
endtask
reg     [31:0] i = 32'h0;

reg     [31:0]  data_1  = 32'hFFFF88E3;
reg     [31:0]  data_2  = 32'h56789ABC;
reg     [31:0]  data_3  = 32'h08004500;
reg     [31:0]  data_4  = 32'h002488E3;
reg     [31:0]  data_5  = 32'h56789ABC;
reg     [31:0]  data_6  = 32'ha9fe1032;
reg     [31:0]  data_7  = 32'h00000000;
reg     [31:0]  data_8  = 32'h0000c0a8;
reg     [31:0]  data_9  = 32'h01010000;
reg     [31:0]  data_A  = 32'h46320400;
reg     [31:0]  data_B  = 32'h00000204;
reg     [31:0]  data_C  = 32'h05b40103;
reg     [31:0]  data_D  = 32'h03080101;
reg     [31:0]  data_E  = 32'h04025024;
reg     [31:0]  data_F  = 32'hD6500000;
reg     [31:0]  data_10 = 32'h00000000;
reg     [31:0]  data_11 = 32'h00000000;
reg     [31:0]  data_12 = 32'hD6500000;
reg     [31:0]  data_13 = 32'h00000000;
reg     [31:0]  data_14 = 32'h00000000;
reg     [31:0]  data_15 = 32'h00000000;

task send_data(
    input [31:0]    addr,
    input [31:0]    data,
    input [31:0]    data_count
);
    begin
        wlast   <= 1'b0;
        awaddr  <= addr;
        awvalid <= 1'b1;
        i   <= 0;

        while ( !(awready == 1) ) 
            #(`CLK_PERIOD_100_MHZ);
        
        #(`CLK_PERIOD_100_MHZ);
        awvalid <= 1'b0;

        
        while (1) begin
             #1;
            if ( i == data_count - 1 ) begin
                wlast   <= 1'b1;
            end
            
            case ( i )
                0:  wdata   <= data;
                1:  wdata   <= data_1;
                2:  wdata   <= data_2;    
                3:  wdata   <= data_3;
                4:  wdata   <= data_4;
                5:  wdata   <= data_5;
                6:  wdata   <= data_6;    
                7:  wdata   <= data_7;
                8:  wdata   <= data_8;
                9:  wdata   <= data_9;
                10: wdata   <= data_A;    
                11: wdata   <= data_B;
                12: wdata   <= data_C;
                13: wdata   <= data_D;
                14: wdata   <= data_E;    
                15: wdata   <= data_F;
                16: wdata   <= data_10;
            endcase
            wvalid  <= 1'b1;

            
            
            #(`CLK_PERIOD_100_MHZ-1);

            while ( !(wready == 1) )
                #(`CLK_PERIOD_100_MHZ);

            
            

            if ( i == data_count ) 
               break;
            else begin           
                i <= i + 1;
                $display("data: %h, sended to: %h, iteration %D",wdata,addr,i); 
            end
        
        end
        
        wvalid  <= 1'b0;

        
    end
endtask
reg     [7:0]   data_uart;
int j = 0;
initial begin
    $display("start initial block");
    
    rst_n     <= 1'b0;
    #(100*`CLK_PERIOD_100_MHZ);
    rst_n     <= 1'b1;


    //led control
    $display("================== set led =========================");
    #(`CLK_PERIOD_100_MHZ);
    send_data(`LED_BASE_ADDR+`LED_CTRL, 32'h00000003,1);

    // check uart ====================================================
    $display("================== check uart ======================");
    data_uart   <= 8'h3B;

    #(100*`CLK_PERIOD_100_MHZ);
    receive_data(`UART_BASE_ADDR+`UART_TX_BUSY);

    #(`CLK_PERIOD_100_MHZ);
    send_data(`UART_TX_DATA+`UART_BASE_ADDR, {24'h0,data_uart },1);

    while( !uart_int )  #(`CLK_PERIOD_100_MHZ);

    receive_data(`UART_BASE_ADDR+`UART_RX_DATA);
    $display("send: %h, receive: %h",data_uart,rdata);


    //check ethernet module=============================================
    $display("======================= check ethernet module =========================");
    receive_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_RX_DATA_COUNT);
    receive_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_RX_EMPTY);
    receive_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_TX_DONE);
    send_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_TX_DATA_IN, 32'h12345678,5);
    #(1000*`CLK_PERIOD_100_MHZ);

    $display("======================== ethernet tx ======================================");
    send_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_TX_DATA_IN, 32'hFFFFFFFF,15);

    $display("======================== ethernet rx ======================================");
    while( !eth_1_int ) #(`CLK_PERIOD_100_MHZ);
    $display("============ data count: ");
    receive_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_RX_DATA_COUNT);
    $display("============ data: ");
    receive_data(`ETHERNET_1_BASE_ADDR+`ETHERNET_RX_DATA);
    
    #(`CLK_PERIOD_100_MHZ);
    $finish();
    
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
.uart_rx              ( uart_tx          ),
.rx_ready_int         ( uart_int         )
);

AXI_ethernet AXI_ethernet_1(
.clk_25_mhz          ( clk_25_mhz       ),
.clk_50_mhz          ( clk_50_mhz       ),
.axi                 ( axi_ethernet_1   ),
.rmii                ( rmii_1           ),
.rx_ready_int        ( eth_1_int        )
);

AXI_ethernet AXI_ethernet_2(
.clk_25_mhz          ( clk_25_mhz       ),
.clk_50_mhz          ( clk_50_mhz       ),
.axi                 ( axi_ethernet_2   ),
.rmii                ( rmii_2           ),
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
