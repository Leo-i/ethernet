
module SoC_Wrapper(

input           clk,
input           clk_50_mhz,
input           clk_25_mhz,
input           resetn,

RMII.master     rmii_1,
RMII.master     rmii_2,
output          uart_tx,
input           uart_rx,
output  [7:0]   led,
input   [3:0]   btn

);

AXI_LITE        core_master(clk, resetn);
wire    [31:0]  irq;
wire            eoi;

core_region core_region(
.clk            ( clk         ),
.resetn         ( resetn      ),
.irq            ( irq         ),
.eoi            ( eoi         ),
.core_master    ( core_master )
);

peripherals peripherals(
.clk            ( clk         ),
.resetn         ( resetn      ),
.clk_50_mhz     ( clk_50_mhz  ),
.clk_25_mhz     ( clk_25_mhz  ),
.core_master    ( core_master ),
.rmii_1         ( rmii_1      ),
.rmii_2         ( rmii_2      ),
.uart_tx        ( uart_tx     ),
.uart_rx        ( uart_rx     ),
.led            ( led         ),
.btn            ( btn         ),
.irq            ( irq         ),
.eoi            ( eoi         )
);

endmodule