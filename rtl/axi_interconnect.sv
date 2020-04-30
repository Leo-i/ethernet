`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2020 12:39:18
// Design Name: 
// Module Name: axi_interconnect
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


module axi_interconnect(
    AXI_LITE.slave      axi,

    AXI_LITE.master     axi_led         ,
    AXI_LITE.master     axi_uart        ,
    AXI_LITE.master     axi_ethernet_1  ,
    AXI_LITE.master     axi_ethernet_2

);


wire    [31:0]  wr_addr;
assign wr_addr = axi.awaddr & 32'hFFFFFF00;

wire    [31:0]  rd_addr;
assign rd_addr = axi.araddr & 32'hFFFFFF00;

// write
assign axi.awready  =   (wr_addr == `LED_BASE_ADDR)  ? axi_led.awready:
                        (wr_addr == `UART_BASE_ADDR) ? axi_uart.awready:
                        (wr_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.awready:
                        (wr_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.awready: 0;

assign axi.wready   =   (wr_addr == `LED_BASE_ADDR)  ? axi_led.wready :
                        (wr_addr == `UART_BASE_ADDR) ? axi_uart.wready:
                        (wr_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.wready:
                        (wr_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.wready: 0;
                        
assign axi.bresp    =   (wr_addr == `LED_BASE_ADDR)  ? axi_led.bresp  :
                        (wr_addr == `UART_BASE_ADDR) ? axi_uart.bresp:
                        (wr_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.bresp:
                        (wr_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.bresp: 0;
                        
assign axi.bvalid   =   (wr_addr == `LED_BASE_ADDR)  ? axi_led.bvalid :
                        (wr_addr == `UART_BASE_ADDR) ? axi_uart.bvalid:
                        (wr_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.bvalid:
                        (wr_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.bvalid: 0;
                        
assign axi.bready   =   (wr_addr == `LED_BASE_ADDR)  ? axi_led.bready :
                        (wr_addr == `UART_BASE_ADDR) ? axi_uart.bready:
                        (wr_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.bready:
                        (wr_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.bready: 0;

// read
assign axi.arready  =   (rd_addr == `LED_BASE_ADDR)  ? axi_led.arready:
                        (rd_addr == `UART_BASE_ADDR) ? axi_uart.arready:
                        (rd_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.arready:
                        (rd_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.arready: 0;

assign axi.rdata    =   (rd_addr == `LED_BASE_ADDR)  ? axi_led.rdata:
                        (rd_addr == `UART_BASE_ADDR) ? axi_uart.rdata:
                        (rd_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.rdata:
                        (rd_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.rdata: 0; 

assign axi.rlast    =   (rd_addr == `LED_BASE_ADDR)  ? axi_led.rlast:
                        (rd_addr == `UART_BASE_ADDR) ? axi_uart.rlast:
                        (rd_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.rlast:
                        (rd_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.rlast: 0; 

assign axi.rvalid   =   (rd_addr == `LED_BASE_ADDR)  ? axi_led.rvalid:
                        (rd_addr == `UART_BASE_ADDR) ? axi_uart.rvalid:
                        (rd_addr == `ETHERNET_1_BASE_ADDR) ? axi_ethernet_1.rvalid:
                        (rd_addr == `ETHERNET_2_BASE_ADDR) ? axi_ethernet_2.rvalid: 0; 
                        
                        
// led controller
assign axi_led.awvalid = (wr_addr == `LED_BASE_ADDR ) ? axi.awvalid : 0;
assign axi_led.awaddr  = (wr_addr == `LED_BASE_ADDR ) ? axi.awaddr - `LED_BASE_ADDR  : 0;
assign axi_led.wdata   = (wr_addr == `LED_BASE_ADDR ) ? axi.wdata   : 0;
assign axi_led.wlast   = (wr_addr == `LED_BASE_ADDR ) ? axi.wlast   : 0;
assign axi_led.wvalid  = (wr_addr == `LED_BASE_ADDR ) ? axi.wvalid  : 0;
assign axi_led.arvalid = (rd_addr == `LED_BASE_ADDR ) ? axi.arvalid : 0;  
assign axi_led.araddr  = (rd_addr == `LED_BASE_ADDR ) ? axi.araddr - `LED_BASE_ADDR  : 0;
assign axi_led.rready  = (rd_addr == `LED_BASE_ADDR ) ? axi.rready  : 0;

// uart
assign axi_uart.awvalid = (wr_addr == `UART_BASE_ADDR ) ? axi.awvalid : 0;
assign axi_uart.awaddr  = (wr_addr == `UART_BASE_ADDR ) ? axi.awaddr - `UART_BASE_ADDR  : 0;
assign axi_uart.wdata   = (wr_addr == `UART_BASE_ADDR ) ? axi.wdata   : 0;
assign axi_uart.wlast   = (wr_addr == `UART_BASE_ADDR ) ? axi.wlast   : 0;
assign axi_uart.wvalid  = (wr_addr == `UART_BASE_ADDR ) ? axi.wvalid  : 0;
assign axi_uart.arvalid = (rd_addr == `UART_BASE_ADDR ) ? axi.arvalid : 0;  
assign axi_uart.araddr  = (rd_addr == `UART_BASE_ADDR ) ? axi.araddr - `UART_BASE_ADDR  : 0;
assign axi_uart.rready  = (rd_addr == `UART_BASE_ADDR ) ? axi.rready  : 0;

// ethernet 1
assign axi_ethernet_1.awvalid = (wr_addr == `ETHERNET_1_BASE_ADDR ) ? axi.awvalid : 0;
assign axi_ethernet_1.awaddr  = (wr_addr == `ETHERNET_1_BASE_ADDR ) ? axi.awaddr - `ETHERNET_1_BASE_ADDR  : 0;
assign axi_ethernet_1.wdata   = (wr_addr == `ETHERNET_1_BASE_ADDR ) ? axi.wdata   : 0;
assign axi_ethernet_1.wlast   = (wr_addr == `ETHERNET_1_BASE_ADDR ) ? axi.wlast   : 0;
assign axi_ethernet_1.wvalid  = (wr_addr == `ETHERNET_1_BASE_ADDR ) ? axi.wvalid  : 0;
assign axi_ethernet_1.arvalid = (rd_addr == `ETHERNET_1_BASE_ADDR ) ? axi.arvalid : 0;  
assign axi_ethernet_1.araddr  = (rd_addr == `ETHERNET_1_BASE_ADDR ) ? axi.araddr - `ETHERNET_1_BASE_ADDR  : 0;
assign axi_ethernet_1.rready  = (rd_addr == `ETHERNET_1_BASE_ADDR ) ? axi.rready  : 0;

// ethernet 2
assign axi_ethernet_2.awvalid = (wr_addr == `ETHERNET_2_BASE_ADDR ) ? axi.awvalid : 0;
assign axi_ethernet_2.awaddr  = (wr_addr == `ETHERNET_2_BASE_ADDR ) ? axi.awaddr - `ETHERNET_2_BASE_ADDR  : 0;
assign axi_ethernet_2.wdata   = (wr_addr == `ETHERNET_2_BASE_ADDR ) ? axi.wdata   : 0;
assign axi_ethernet_2.wlast   = (wr_addr == `ETHERNET_2_BASE_ADDR ) ? axi.wlast   : 0;
assign axi_ethernet_2.wvalid  = (wr_addr == `ETHERNET_2_BASE_ADDR ) ? axi.wvalid  : 0;
assign axi_ethernet_2.arvalid = (rd_addr == `ETHERNET_2_BASE_ADDR ) ? axi.arvalid : 0;  
assign axi_ethernet_2.araddr  = (rd_addr == `ETHERNET_2_BASE_ADDR ) ? axi.araddr - `ETHERNET_2_BASE_ADDR  : 0;
assign axi_ethernet_2.rready  = (rd_addr == `ETHERNET_2_BASE_ADDR ) ? axi.rready  : 0;

endmodule
