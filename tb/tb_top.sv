`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2020 13:11:49
// Design Name: 
// Module Name: tb_top
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


`define CLK_PERIOD  5.00ns
`define UART_DELAY  8.70us
`define ETH_DELAY   20.00ns

module tb_top();

logic   clk_200_mhz = 1'b1;
logic   rst         = 1'b0;
wire    [7:0]       led;
reg                 uart_rx = 1;

reg     [1:0]       rx_d_1;
wire    [1:0]       tx_d_1;
reg                 crs_dv_1;


/////////////////////////////////////////////////////// SEND VIA ETHERNET //////////////////////////////////////////////
int fd;
int i;
string line;
string str;
int length;
int j;
reg [7:0] data_eth;
task send_ethernet(
    input   [7:0] data_count
);
    begin
             
    fd = $fopen ("D:/projects/PicoRV32/src/tb/tb_pack", "r");   
    if (fd) begin

        $display("File was opened successfully : %0d", fd);
        for (j = 0; j < data_count; j++) begin
            #(5*`ETH_DELAY)
            crs_dv_1 <= 1'b0;
            #(10000*`CLK_PERIOD)
            crs_dv_1 <= 1'b1;
            $fgets(line, fd);
            $display ("%s", line );

            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;

            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b01;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b11;

            length = line.len();
            

            for (i = 0; i < length; i=i+4) begin

                
                str = line.substr(i,i+1);
                data_eth = str.atohex();
                // $display("data: %h",data_eth);

                #(`ETH_DELAY)
                rx_d_1  <= data_eth[1:0];
                #(`ETH_DELAY)
                rx_d_1  <= data_eth[3:2];
                
                #(`ETH_DELAY)
                rx_d_1  <= data_eth[5:4];
                #(`ETH_DELAY)
                rx_d_1  <= data_eth[7:6];

                str = line.substr(i+2,i+3);
                data_eth = str.atohex();
                // $display("data: %h",data_eth);


                #(`ETH_DELAY)
                rx_d_1  <= data_eth[1:0];
                #(`ETH_DELAY)
                rx_d_1  <= data_eth[3:2];
                
                #(`ETH_DELAY)
                rx_d_1  <= data_eth[5:4];
                #(`ETH_DELAY)
                rx_d_1  <= data_eth[7:6];

            end

            #(`ETH_DELAY)
            rx_d_1  <= 2'b00;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b00;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b00;
            #(`ETH_DELAY)
            rx_d_1  <= 2'b00;

            
        end

        crs_dv_1 <= 1'b0;

    end else
        $display("File was NOT opened successfully : %0d", fd);
    

    $fclose(fd);

    end
endtask

/////////////////////////////////////////////////////// SEND VIA UART //////////////////////////////////////////////
int uart_iteration;
task send_uart(
    input   [7:0] data
);
    begin
        #(`UART_DELAY*4)
        uart_rx <= 1'b0;
    
        for (int uart_iteration = 0; uart_iteration < 8; uart_iteration++) begin
            #(`UART_DELAY)
            uart_rx <= data[uart_iteration];
        end
        #(`UART_DELAY)
        uart_rx <= 1'b1;

        $display("data was sent via uart : %0h", data);
    end
endtask

/////////////////////////////////////////////////////// SEND FILE VIA UART //////////////////////////////////////////////


int iteration;
reg [31:0] data_to_rx;
task send_data_file_uart(
    string          path
);
    begin
        fd = $fopen (path, "r");   
        if (fd) begin
            $display("File was opened successfully : %0s", fd);
            
            while (!$feof(fd)) begin

                $fgets(line, fd);
                $display ("%d", line );
                data_to_rx = line.atohex();

                send_uart(data_to_rx[31:24]);
                send_uart(data_to_rx[23:16]);
                send_uart(data_to_rx[15:8]);
                send_uart(data_to_rx[7:0]);

            end
        end else
            $display("File was NOT opened successfully : %0d", fd);
    end
endtask


///////////////////////////////////////// START //////////////////////////////////////////////////
initial begin
    rst     <= 1'b1;
    #(100*`CLK_PERIOD);
    rst     <= 1'b0;

    send_uart(8'h12);
    send_uart(8'h78);

    send_uart(8'h38); // start bootloader
    send_uart(8'h00); // end addr 32 bit
    send_uart(8'h00);
    send_uart(8'h07);
    send_uart(8'h14);
    //send_data_file_uart("D:/projects/PicoRV32/src/sw/set_led_dat.txt");

end
/////////////////////////////////////////////////////////////////////////////////////////////////

assign rx_er_1  = 0;
wire [1:0] tx_d_2;

top top(
.clk_200_mhz    ( clk_200_mhz  ),
.rst            ( rst          ),

.uart_tx        ( uart_tx      ),
.uart_rx        ( uart_rx      ),

.crs_dv_1       ( crs_dv_1     ),
.mdc_1          ( mdc_1        ),
.mdio_1         ( mdio_1       ),
.clk_50_mhz_1   ( clk_50_mhz_1 ),
.rst_n_1        ( rst_n_1      ),
.rx_er_1        ( rx_er_1      ),
.rx_d_1         ( rx_d_1       ),
.tx_d_1         ( tx_d_1       ),
.tx_e_1         ( tx_e_1       ),

.crs_dv_2       ( crs_dv_2     ),
.mdc_2          ( mdc_2        ),
.mdio_2         ( mdio_2       ),
.clk_50_mhz_2   ( clk_50_mhz_2 ),
.rst_n_2        ( rst_n_2      ),
.rx_er_2        ( rx_er_2      ),
.rx_d_2         ( rx_d_2       ),
.tx_d_2         ( tx_d_2       ),
.tx_e_2         ( tx_e_2       ),

.btn            ( btn          ),
.led            ( led          )

);




always begin
    #(`CLK_PERIOD/2) clk_200_mhz = ~clk_200_mhz;
end
endmodule
