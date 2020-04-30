// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


module peripherals
  (
    input                     clk,
    input                     clk_50_mhz,
    input                     clk_25_mhz,
    input                     resetn,

    AXI_LITE.slave           core_master,

    RMII.master               rmii_1,
    RMII.master               rmii_2,

    output                    uart_tx,
    input                     uart_rx,

    output       [7:0]        led,

    input        [3:0]        btn,

    output       [31:0]       irq,
    input                     eoi
);

AXI_LITE axi_led(clk,resetn);
AXI_LITE axi_uart(clk,resetn);
AXI_LITE axi_ethernet_1(clk,resetn);
AXI_LITE axi_ethernet_2(clk,resetn);

// irq_module irq_module(
// .btn        ( btn       ),
// .uart_int   ( uart_int  ),
// .eth_1_int  ( eth_1_int ),
// .eth_2_int  ( eth_2_int ),
// .irq        ( irq       )
// );

axi_interconnect axi_interconnect(
.axi                 ( core_master       ),
.axi_led             ( axi_led           ),
.axi_uart            ( axi_uart          ),
.axi_ethernet_1      ( axi_ethernet_1    ),
.axi_ethernet_2      ( axi_ethernet_2    )  
);

led_ctrl led_ctrl(
.axi                  ( axi_led          ),
.led                  ( led              )
);

AXI_uart AXI_uart(
.clk_50_mhz           ( clk_50_mhz       ),
.axi                  ( axi_uart         ),
.uart_tx              ( uart_tx          ),
.uart_rx              ( uart_rx          ),
.rdy                  ( uart_int         )
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


endmodule
