`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2020 16:12:05
// Design Name: 
// Module Name: tb_scr
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


module tb_scr();


scr1_core_top i_core_top (
    // Control
    .pwrup_rst_n    (pwrup_rst_n_sync   ),
    .rst_n          (rst_n_sync         ),
    .cpu_rst_n      (cpu_rst_n_sync     ),
    .test_mode      (test_mode          ),
    .test_rst_n     (test_rst_n         ),
    .clk            (clk                ),
    .core_rst_n_out (core_rst_n_local   ),
`ifdef SCR1_DBGC_EN
    .ndm_rst_n_out  (ndm_rst_n_out      ),
`endif // SCR1_DBGC_EN
    .fuse_mhartid   (fuse_mhartid       ),
`ifdef SCR1_DBGC_EN
    .fuse_idcode    (fuse_idcode        ),
`endif // SCR1_DBGC_EN
    // IRQ
`ifdef SCR1_IPIC_EN
    .irq_lines      (irq_lines          ),
`else // SCR1_IPIC_EN
    .ext_irq        (ext_irq            ),
`endif // SCR1_IPIC_EN
    .soft_irq       (soft_irq           ),
    .timer_irq      (timer_irq          ),
    .mtime_ext      (timer_val          ),
`ifdef SCR1_DBGC_EN
    // JTAG interface
    .trst_n         (trst_n             ),
    .tck            (tck                ),
    .tms            (tms                ),
    .tdi            (tdi                ),
    .tdo            (tdo                ),
    .tdo_en         (tdo_en             ),
`endif // SCR1_DBGC_EN
    // Instruction memory interface
    .imem_req_ack   (core_imem_req_ack  ),
    .imem_req       (core_imem_req      ),
    .imem_cmd       (core_imem_cmd      ),
    .imem_addr      (core_imem_addr     ),
    .imem_rdata     (core_imem_rdata    ),
    .imem_resp      (core_imem_resp     ),
    // Data memory interface
    .dmem_req_ack   (core_dmem_req_ack  ),
    .dmem_req       (core_dmem_req      ),
    .dmem_cmd       (core_dmem_cmd      ),
    .dmem_width     (core_dmem_width    ),
    .dmem_addr      (core_dmem_addr     ),
    .dmem_wdata     (core_dmem_wdata    ),
    .dmem_rdata     (core_dmem_rdata    ),
    .dmem_resp      (core_dmem_resp     )
);

endmodule
