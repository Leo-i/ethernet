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

/*
always@(*) begin
    
    case ( wr_addr )
        `ETHERNET_1_BASE_ADDR: begin 
            axi_led.awvalid             = 1'b0;
            axi_uart.awvalid            = 1'b0;
            axi_ethernet_1.awvalid      = axi.awvalid;
            axi_ethernet_2.awvalid      = 1'b0;

            axi.awready                 = axi_ethernet_1.awready;
            axi.wready                  = axi_ethernet_1.wready ;
            axi.bresp                   = axi_ethernet_1.bresp  ;
            axi.bvalid                  = axi_ethernet_1.bvalid ;
            axi.bready                  = axi_ethernet_1.bready ;
            axi_ethernet_1.awaddr       = axi.awaddr - `ETHERNET_1_BASE_ADDR ;
            axi_ethernet_1.wdata        = axi.wdata  ;
            axi_ethernet_1.wlast        = axi.wlast  ;
            axi_ethernet_1.wvalid       = axi.wvalid ;
        end
        `ETHERNET_2_BASE_ADDR: begin 
            axi_led.awvalid             = 1'b0;
            axi_uart.awvalid            = 1'b0;
            axi_ethernet_1.awvalid      = 1'b0;
            axi_ethernet_2.awvalid      = axi.awvalid;

            axi.awready                 = axi_ethernet_2.awready;
            axi.wready                  = axi_ethernet_2.wready ;
            axi.bresp                   = axi_ethernet_2.bresp  ;
            axi.bvalid                  = axi_ethernet_2.bvalid ;
            axi.bready                  = axi_ethernet_2.bready ;
            axi_ethernet_2.awaddr       = axi.awaddr - `ETHERNET_2_BASE_ADDR ;
            axi_ethernet_2.wdata        = axi.wdata  ;
            axi_ethernet_2.wlast        = axi.wlast  ;
            axi_ethernet_2.wvalid       = axi.wvalid ;
        end
        `UART_BASE_ADDR:       begin 
            axi_led.awvalid             = 1'b0;
            axi_uart.awvalid            = axi.awvalid;
            axi_ethernet_1.awvalid      = 1'b0;
            axi_ethernet_2.awvalid      = 1'b0;

            axi.awready                 = axi_uart.awready;
            axi.wready                  = axi_uart.wready ;
            axi.bresp                   = axi_uart.bresp  ;
            axi.bvalid                  = axi_uart.bvalid ;
            axi.bready                  = axi_uart.bready ;
            axi_uart.awaddr             = axi.awaddr - `UART_BASE_ADDR ;
            axi_uart.wdata              = axi.wdata  ;
            axi_uart.wlast              = axi.wlast  ;
            axi_uart.wvalid             = axi.wvalid ;
        end
        `LED_BASE_ADDR:        begin 
            axi_led.awvalid             = axi.awvalid;;
            axi_uart.awvalid            = 1'b0;
            axi_ethernet_1.awvalid      = 1'b0;
            axi_ethernet_2.awvalid      = 1'b0;

            axi.awready                 = axi_led.awready;
            axi.wready                  = axi_led.wready ;
            axi.bresp                   = axi_led.bresp  ;
            axi.bvalid                  = axi_led.bvalid ;
            axi.bready                  = axi_led.bready ;
            axi_led.awaddr              = axi.awaddr - `LED_BASE_ADDR ;
            axi_led.wdata               = axi.wdata  ;
            axi_led.wlast               = axi.wlast  ;
            axi_led.wvalid              = axi.wvalid ;
        end
        default: ;
    endcase

    case ( rd_addr )
        `ETHERNET_1_BASE_ADDR: begin 
            axi_led.arvalid             = 1'b0;
            axi_uart.arvalid            = 1'b0;
            axi_ethernet_1.arvalid      = axi.arvalid;
            axi_ethernet_2.arvalid      = 1'b0;

            axi.arready                 = axi_ethernet_1.arready;
            axi.rdata                   = axi_ethernet_1.rdata  ;
            axi.rlast                   = axi_ethernet_1.rlast  ;
            axi.rvalid                  = axi_ethernet_1.rvalid ;
            axi_ethernet_1.araddr       = axi.araddr - `ETHERNET_1_BASE_ADDR ;
            axi_ethernet_1.rready       = axi.rready ;
        end
        `ETHERNET_2_BASE_ADDR: begin 
            axi_led.arvalid             = 1'b0;
            axi_uart.arvalid            = 1'b0;
            axi_ethernet_1.arvalid      = 1'b0;
            axi_ethernet_2.arvalid      = axi.arvalid;

            axi.arready                 = axi_ethernet_2.arready;
            axi.rdata                   = axi_ethernet_2.rdata  ;
            axi.rlast                   = axi_ethernet_2.rlast  ;
            axi.rvalid                  = axi_ethernet_2.rvalid ;
            axi_ethernet_2.araddr       = axi.araddr - `ETHERNET_2_BASE_ADDR ;
            axi_ethernet_2.rready       = axi.rready ;
        end
        `UART_BASE_ADDR:       begin 
            axi_led.arvalid             = 1'b0;
            axi_uart.arvalid            = axi.arvalid;
            axi_ethernet_1.arvalid      = 1'b0;
            axi_ethernet_2.arvalid      = 1'b0;

            axi.arready                 = axi_uart.arready;
            axi.rdata                   = axi_uart.rdata  ;
            axi.rlast                   = axi_uart.rlast  ;
            axi.rvalid                  = axi_uart.rvalid ;
            axi_uart.araddr             = axi.araddr - `UART_BASE_ADDR ;
            axi_uart.rready             = axi.rready ;
        end
        `LED_BASE_ADDR:        begin 
            axi_led.arvalid             = axi.arvalid;;
            axi_uart.arvalid            = 1'b0;
            axi_ethernet_1.arvalid      = 1'b0;
            axi_ethernet_2.arvalid      = 1'b0;

            axi.arready                 = axi_led.arready;
            axi.rdata                   = axi_led.rdata  ;
            axi.rlast                   = axi_led.rlast  ;
            axi.rvalid                  = axi_led.rvalid ;
            axi_led.araddr              = axi.araddr - `LED_BASE_ADDR;
            axi_led.rready              = axi.rready ;
        end
        default: ;
    endcase
end
*/
endmodule
