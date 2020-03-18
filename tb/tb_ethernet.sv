`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2020 15:07:52
// Design Name: 
// Module Name: tb_ethernet
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


module tb_ethernet();

reg         clk_25_mhz   = 1'b1;
reg         clk_100_mhz  = 1'b1;
reg         rst_n        = 1'b1;

reg [31:0]  tx_buf       = 32'h9229C2C3; 
reg         tx_valid     = 1'b0;
reg         tx_new_data  = 1'b0;

reg         rx_er        = 1'b0;
reg         crs_dv       = 1'b0;
reg [1:0]   rx_d         = 2'b00;
reg [31:0]  data_to_rx   = 32'h9229C2C3;

reg         start        = 1'b0;
reg         mode         = 1'b1;
reg [4:0]   addr         = 5'b11011;
reg [4:0]   reg_addr     = 5'b11011;
reg [15:0]  data         = 16'hCC33;

wire    [1:0]   tx_d;
wire            tx_en;
wire    [31:0]  rx_buf;


RMII        rmii_bus();

assign  tx_d            = rmii_bus.tx_d;
assign  tx_en           = rmii_bus.tx_en;

assign  rmii_bus.rx_er      =    rx_er ;    
assign  rmii_bus.rx_d       =    rx_d  ;     
assign  rmii_bus.crs_dv     =    crs_dv;   
int i;

ethernet ethernet(
.clk_25_mhz         ( clk_25_mhz    ),
.rst_n              ( rst_n         ),
.rmii               ( rmii_bus      ),   
  
.tx_buf             ( tx_buf        ),
.tx_valid           ( tx_valid      ),
.tx_new_data        ( tx_new_data   ),
.tx_empty           ( tx_empty      ),
  
.rx_buf             ( rx_buf        ),
.rx_full            ( rx_full       ),
  
.MD_start           ( start         ),  
.MD_mode            ( mode          ),
.MD_addr            ( addr          ),
.MD_reg_addr        ( reg_addr      ),
.MD_data_to         ( data          ),
.MD_data_from       ( MD_data_from  ),
.MD_done            ( MD_done       )
);


initial begin
    #30
    rst_n       <= 1'b0;
    #40
    rst_n       <= 1'b1;
    #20
    
    fork
        // transmitter
        begin 
            tx_valid    <= 1'b1;
            #60
            tx_valid    <= 1'b0;

            while ( 1 ) begin
            #10
                if ( tx_empty )
                    break;
            end
            tx_buf      <= 32'h4F524860;
            tx_new_data <= 1'b1;
            #20

            while ( 1 ) begin
            #10
                if ( tx_empty )
                    break;
            end
            tx_valid    <= 1'b1;
            while ( 1 ) begin
            #10
                if ( !tx_empty )
                    break;
            end
            tx_valid    <= 1'b0;
            tx_new_data <= 1'b0;
        end
        //  receiver
        begin
            rx_d    <= data_to_rx[31:30];
            rx_er   <= 1'b0;
            crs_dv  <= 1'b1;
            
            for ( i = 15 ; i > 0 ; i-- ) begin
                #40
                rx_d[1]    <= data_to_rx[2*i-1];//31 29 27
                rx_d[0]    <= data_to_rx[2*i-2];//30 28 26
            end
            
        end
    join_none
    #2000
    $finish;
end

//========= clk =====================
initial begin
    fork
    forever begin
        #5
        clk_100_mhz <= !clk_100_mhz;
    end
    forever begin
        #20
        clk_25_mhz  <= !clk_25_mhz;
    end
    join
end

endmodule
