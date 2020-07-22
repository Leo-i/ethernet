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
#define UART_READY                          0x0000000C

// regs description 
// https://www.ti.com/lit/ds/symlink/dp83630.pdf?ts=1594928586430&ref_url=https%253A%252F%252Fwww.google.com%252F

#define PHY_REG_BMCR                        0x00000000
#define PHY_REG_BMSR                        0x00000001
#define PHY_REG_PHYIDR1                     0x00000002
#define PHY_REG_PHYIDR2                     0x00000003
#define PHY_REG_ANAR                        0x00000004
#define PHY_REG_ANLPAR                      0x00000005
#define PHY_REG_ANER                        0x00000006
#define PHY_REG_ANNPTR                      0x00000007
#define PHY_REG_PHYSTS                      0x00000010
#define PHY_REG_MICR                        0x00000011
#define PHY_REG_MISR                        0x00000012
#define PHY_REG_PAGESEL                     0x00000013