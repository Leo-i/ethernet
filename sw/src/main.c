#include "defines.h"
#include "uart_controller.c"
#include "timer.c"
#include "led_ctrl.c"
#include "ethernet.c"

int main(void){

    int rx_data[375];
    int tx_data[375];

    tx_data[0] = 0xc0c0c0c0;
    tx_data[1] = 0xc0c0c0c0;
    tx_data[2] = 0xc0c0c0c0;
    tx_data[3] = 0xc0c0c0c0;
    tx_data[4] = 0xc0c0c0c0;

    ETHERNET_send_data(2,tx_data,20); // initialize

    delay_us(500);

    tx_data[0]  = 0xFFFF88E3;
    tx_data[1]  = 0xFFFF88E3;
    tx_data[2]  = 0x56789ABC;
    tx_data[3]  = 0x08004500;
    tx_data[4]  = 0x002488E3;
    tx_data[5]  = 0x56789ABC;
    tx_data[6]  = 0xa9fe1032;
    tx_data[7]  = 0x00000000;
    tx_data[8]  = 0x0000c0a8;
    tx_data[9]  = 0x01010000;
    tx_data[10] = 0x46320400;
    tx_data[11] = 0x00000204;
    tx_data[12] = 0x05b40103;
    tx_data[13] = 0x03080101;
    tx_data[14] = 0x04025024;
    tx_data[15] = 0xD6500000;
    tx_data[16] = 0x00000000;
    tx_data[17] = 0x00000000;
    tx_data[18] = 0xD6500000;
    tx_data[20] = 0x00000000;
    tx_data[21] = 0x00000000;
    tx_data[22] = 0x00000000;

    int command = 0;
	
   while(1){
       //control_led_via_uart();
        
        if ( UART_check() != 0){
            command = UART_read_data();
            set_led(command);

            if ( command = 0x26 )
                ETHERNET_send_data(2,tx_data,92);
        }



       if (!ETHERNET_rx_empty(1)){
           int protocol = ETHERNET_protocol(1);
           ETHERNET_read_data(1,rx_data);

            while (1)
                if ( UART_check_busy() == 0)
                    break;
           
           UART_send_byte(protocol >> 8);
           UART_send_byte(protocol);
       }
   }
}

void control_led_via_uart(){
    
    if ( UART_check() != 0)
        set_led(UART_read_data());   
    
}




