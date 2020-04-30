`define IRQADDR                             32'h00000000
`define PROGADDR                            32'h00000064
`define STACKADDR                           32'h00008000

`define ETHERNET_1_BASE_ADDR                32'h00008000
`define ETHERNET_2_BASE_ADDR                32'h00008100
`define UART_BASE_ADDR                      32'h00008200
`define LED_BASE_ADDR                       32'h00008300

`define ETHERNET_TX_DATA_IN                 32'h00000000
`define ETHERNET_TX_DONE                    32'h00000004

`define ETHERNET_RX_DATA                    32'h00000008
`define ETHERNET_RX_EMPTY                   32'h0000000C
`define ETHERNET_RX_DATA_COUNT              32'h00000010
`define ETHERNET_RX_PROTOCOL_TYPE           32'h00000014

`define ETHERNET_DM_MODE                    32'h00000018
`define ETHERNET_DM_START                   32'h0000001C
`define ETHERNET_DM_ADDR                    32'h00000020
`define ETHERNET_DM_REG_ADDR                32'h00000024
`define ETHERNET_DM_DATA_IN                 32'h00000028
`define ETHERNET_DM_DATA_O                  32'h0000002C
`define ETHERNET_DM_DONE                    32'h00000030

`define LED_CTRL                            32'h00000000

`define UART_RX_DATA                        32'h00000000
`define UART_TX_DATA                        32'h00000004
`define UART_TX_BUSY                        32'h00000008
`define UART_READY                          32'h0000000C