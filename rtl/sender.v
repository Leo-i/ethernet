`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2020 20:41:44
// Design Name: 
// Module Name: sender
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


module sender(
    input                sys_clk,
    output [7:0]         led,
    input                rst,
    input                btn,

    // phy 1
    input                clk_out_1   ,
    input                crs_dv_1    ,
    input                led_phy_1   ,
    output               mdc_1       ,
    inout                mdio_1      ,
    output               clk_50_mhz_1,
    output               rst_n_1     ,
    input                rx_er_1     ,
    input         [1:0]  rx_d_1      ,
    output        [1:0]  tx_d_1      ,
    output               tx_e_1      ,

    // phy 2
    input                clk_out_2   ,
    input                crs_dv_2    ,
    input                led_phy_2   ,
    output               mdc_2       ,
    inout                mdio_2      ,
    output               clk_50_mhz_2,
    output               rst_n_2     ,
    input                rx_er_2     ,
    input         [1:0]  rx_d_2      ,
    output        [1:0]  tx_d_2      ,
    output               tx_e_2      ,

    output          uart_tx,
    input           uart_rx
);


assign  clk_50_mhz_1  = clk_50_mhz_90;
assign  clk_50_mhz_2  = clk_50_mhz_90;
assign  rst_n_1       = rst_n;
assign  rst_n_2       = rst_n;
assign  mdio_1        = 1'b0;
assign  mdio_2        = 1'b0;
assign  mdc_1         = clk_25_mhz;
assign  mdc_2         = clk_25_mhz;
assign  led[7]        = locked;
assign  rst_n         = !rst;


wire [7:0]  E_rx_dout;
reg         E_rx_rd_en;

reg  [31:0] E_tx_din;
reg         E_tx_wr_en;

reg         uart_wr_en;
reg  [7:0]  uart_din;
wire [7:0]  uart_dout;
reg         state = 1'b0;
reg  [4:0]  wr_state = 5'h17;


wire [7:0]  E_rx_data;
wire [7:0]  E_tx_dout;
reg  [3:0]  delay = 4'h0;
reg         first = 1'b1;


always@( posedge clk_50_mhz )begin

    if ( rst )
        first   <= 1'b1;
    else if ( delay == 4'h0 )
        if ( !uart_tx_busy ) begin

        
            case ( state )

                1'h0: begin
                    if ( !E_rx_empty ) begin
                        if ( first )
                            first   <= 1'b0;
                        else 
                            uart_wr_en  <= 1'b1;

                        state         <= 3'h1;
                        E_rx_rd_en    <= 1'b1;
                    end
                end

                1'h1: begin
                    E_rx_rd_en    <= 1'b0;                    
                    delay       <= 4'hF;
                    state       <= 1'b0;
                end
                
            endcase
        end else 
            uart_wr_en  <=1'b0;      
    else
        delay   <= delay - 1'h1;
end

reg [23:0]  delay_write = 24'h0; 

always@( posedge clk_50_mhz )begin

    if ( btn ) begin
        wr_state <= 5'h0;
        delay_write <= 24'hFFFFFF;
    end

    if ( delay_write == 24'h0 )
        case ( wr_state )
            5'h0: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h00000000; wr_state  <= 5'h1;    end
            5'h1: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h55555555; wr_state  <= 5'h2;    end
            5'h2: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h555555D5; wr_state  <= 5'h3;    end
            5'h3: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'hFFFFFFFF; wr_state  <= 5'h4;    end
            5'h4: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'hFFFF88E3; wr_state  <= 5'h5;    end
            5'h5: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h56789ABC; wr_state  <= 5'h6;    end
            5'h6: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h08004500; wr_state  <= 5'h7;    end
            5'h7: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h0024774F; wr_state  <= 5'h8;    end
            5'h8: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h00008011; wr_state  <= 5'h9;    end
            5'h9: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h59F8A9FE; wr_state  <= 5'hA;    end
            5'hA: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h1585A9FE; wr_state  <= 5'hB;    end
            5'hB: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'hFFFFDD5B; wr_state  <= 5'hC;    end
            5'hC: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h05FE0010; wr_state  <= 5'hD;    end
            5'hD: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h147D5443; wr_state  <= 5'hE;    end
            5'hE: begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h46320400; wr_state  <= 5'h16;    end
            //5'h10:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h00000204; wr_state  <= 5'h11;   end
            //5'h11:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h05b40103; wr_state  <= 5'h12;   end
            //5'h12:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h03080101; wr_state  <= 5'h13;   end
            //5'h13:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h04025024; wr_state  <= 5'h14;   end
            //5'h14:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'hD6500000; wr_state  <= 5'h15;   end
            //5'h15:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h00000000; wr_state  <= 5'h16;   end
            5'h16:begin E_tx_wr_en <= 1'b1; E_tx_din <= 32'h00000000; wr_state  <= 5'h17;   end

            5'h17:begin E_tx_wr_en <= 1'b0; end
        endcase
    else
        delay_write <= delay_write - 1'b1;
end

fifo_tx fifo_tx(
.clk            ( clk_50_mhz    ),
.srst           ( rst           ),
.din            ( E_tx_din      ),
.wr_en          ( E_tx_wr_en    ),
.rd_en          ( E_tx_rd_en    ),
.dout           ( E_tx_dout     ),
.full           ( E_tx_full     ),
.empty          ( E_tx_empty    ) 
);

transmitter ethernet_Tx(
 .ref_clk       ( clk_50_mhz    ),
 .rst_n         ( rst_n         ),
 .data_i        ( E_tx_dout     ),
 .en_i          ( !E_tx_empty   ),
 .tx_d          ( tx_d_1        ),
 .tx_e          ( tx_e_1        ),
 .done_o        ( E_tx_rd_en    )
);


uart uart(
.din            ( E_rx_dout     ),
.wr_en          ( uart_wr_en    ),
.clk_50m        ( clk_50_mhz    ),
.tx             ( uart_tx       ),
.tx_busy        ( uart_tx_busy  ),
.rx             ( uart_rx       ),
.rdy            ( uart_rdy      ),
.rdy_clr        ( uart_rdy_clr  ),
.dout           ( uart_dout     )
);

receiver ethernet_Rx(
.clk            ( clk_50_mhz    ),
.rst_n          ( rst_n         ),
.rx_er          ( rx_er_2       ),
.rx_d           ( rx_d_2        ),
.crs_dv         ( crs_dv_2      ),
.data_o         ( E_rx_data     ),
.done           ( E_rx_done     )
);

fifo_rx fifo_rx(
.clk            ( clk_50_mhz    ),
.srst           ( rst           ),
.din            ( E_rx_data     ),
.wr_en          ( E_rx_done     ),
.rd_en          ( E_rx_rd_en    ),
.dout           ( E_rx_dout     ),
.full           ( E_rx_full     ),
.empty          ( E_rx_empty    ) 
);

clk_wizard clock(
.clk_100_mhz    ( clk_100_mhz  ),
.clk_50_mhz     ( clk_50_mhz   ),
.reset          ( rst          ),
.locked         ( locked       ),
.clk_in1        ( sys_clk      ),
.clk_25_mhz     ( clk_25_mhz   ),
.clk_50_mhz_90  ( clk_50_mhz_90)
 );

endmodule

/*

// ETHERNET =========================================================
reg     [31:0]  signals                       = 32'h00000012      ;
reg     [31:0]  MAC_1                         = 32'hB888E3A7      ;
reg     [31:0]  MAC_2                         = 32'hB3411234      ;
reg     [31:0]  MAC_3                         = 32'h56789ABC      ;
reg     [15:0]  MAC_LENGTH                    = 16'h0800          ;

reg     [31:0]  Ver_IHL_TypeOfService_Length  = 32'h45000034      ;
reg     [31:0]  Id_Flags_FragmentOffset       = 32'h4d434000      ;
reg     [31:0]  LiveTime_Protocol_Checksum    = 32'h80069936      ;
reg     [31:0]  Src_addr                      = 32'hc0a80130      ;
reg     [31:0]  Dst_addr                      = 32'h57fafa77      ;
reg     [31:0]  SrcPort_DstPort               = 32'hc3fc01bb      ;
reg     [31:0]  SequenceNum                   = 32'hd259cdf5      ;
reg     [31:0]  AckNum                        = 32'h00000000      ;
reg     [31:0]  tcp_param                     = 32'h8002faf0      ;
reg     [31:0]  Checksum_urgentPointer        = 32'hf9cd0000      ;
reg     [31:0]  Options_Padding               = 32'h00000000      ;
reg     [31:0]  data_count                    = 32'h4             ;
reg     [31:0]  data                          = 32'h00000000      ;
reg     [31:0]  checksum_FCS                  = 32'h89ABCDEF      ;

wrapper_transmitter ethernet_Tx(
.clk_50_mhz                         ( clk_50_mhz                    ),
.clk_100_mhz                        ( clk_100_mhz                   ),
.rst_n                              ( rst_n                         ),
.signals                            ( signals                       ), 
.MAC_1                              ( MAC_1                         ), 
.MAC_2                              ( MAC_2                         ), 
.MAC_3                              ( MAC_3                         ), 
.MAC_LENGTH                         ( MAC_LENGTH                    ),
.Ver_IHL_TypeOfService_Length       ( Ver_IHL_TypeOfService_Length  ), 
.Id_Flags_FragmentOffset            ( Id_Flags_FragmentOffset       ),     
.LiveTime_Protocol_Checksum         ( LiveTime_Protocol_Checksum    ),
.Src_addr                           ( Src_addr                      ),
.Dst_addr                           ( Dst_addr                      ),
.SrcPort_DstPort                    ( SrcPort_DstPort               ), 
.SequenceNum                        ( SequenceNum                   ),     
.AckNum                             ( AckNum                        ),
.tcp_param                          ( tcp_param                     ),
.Checksum_urgentPointer             ( Checksum_urgentPointer        ),
.Options_Padding                    ( Options_Padding               ),
.data                               ( data                          ),
.checksum_FCS                       ( checksum_FCS                  ),
.busy                               ( busy                          ),
.tx_d                               ( tx_d_1                          ),
.tx_e                               ( tx_e_1                          )                              
);
*/