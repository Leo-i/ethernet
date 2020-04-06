`define ETHERNET_1_BASE_ADDR                32'h00001000
`define ETHERNET_2_BASE_ADDR                32'h00002000
`define UART_BASE_ADDR                      32'h00003000
`define LED_BASE_ADDR                       32'h00004000

`define ETHERNET_TX_DATA_IN                 32'h00000001
`define ETHERNET_TX_DONE                    32'h00000002

`define ETHERNET_RX_DATA                    32'h00000004
`define ETHERNET_RX_EMPTY                   32'h00000005
`define ETHERNET_RX_DATA_COUNT              32'h00000006
`define ETHERNET_RX_PROTOCOL_TYPE           32'h00000007

`define ETHERNET_DM_MODE                    32'h00000009
`define ETHERNET_DM_START                   32'h0000000A
`define ETHERNET_DM_ADDR                    32'h0000000B
`define ETHERNET_DM_REG_ADDR                32'h0000000C
`define ETHERNET_DM_DATA_IN                 32'h0000000D
`define ETHERNET_DM_DATA_O                  32'h0000000E
`define ETHERNET_DM_DONE                    32'h0000000F

`define LED_CTRL                            32'h00000001

`define UART_RX_DATA                        32'h00000001
`define UART_TX_DATA                        32'h00000002
`define UART_TX_BUSY                        32'h00000003