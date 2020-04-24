#define IRQ_ADDR                            0x00000000

#define ETHERNET_1_BASE_ADDR                0x00008000
#define ETHERNET_2_BASE_ADDR                0x00008100
#define UART_BASE_ADDR                      0x00008200
#define LED_BASE_ADDR                       0x00008300

#define ETHERNET_TX_DATA_IN                 0x00000000
#define ETHERNET_TX_DONE                    0x00000004

#define ETHERNET_RX_DATA                    0x00000008
#define ETHERNET_RX_EMPTY                   0x0000000C
#define ETHERNET_RX_DATA_COUNT              0x00000010
#define ETHERNET_RX_PROTOCOL_TYPE           0x00000014

#define ETHERNET_DM_MODE                    0x00000018
#define ETHERNET_DM_START                   0x0000001C
#define ETHERNET_DM_ADDR                    0x00000020
#define ETHERNET_DM_REG_ADDR                0x00000024
#define ETHERNET_DM_DATA_IN                 0x00000028
#define ETHERNET_DM_DATA_O                  0x0000002C
#define ETHERNET_DM_DONE                    0x00000030

#define LED_CTRL                            0x00000000

#define UART_RX_DATA                        0x00000000
#define UART_TX_DATA                        0x00000004
#define UART_TX_BUSY                        0x00000008