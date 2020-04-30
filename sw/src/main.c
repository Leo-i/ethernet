#include "defines.h"
#include "uart_controller.c"
#include "timer.c"
#include "led_ctrl.c"
#include "ethernet.c"

int main(void){
	/*
    unsigned int protocol;
    unsigned int data_count;

    unsigned int array_to_send[20];
    unsigned int recieved_array[375];

    array_to_send[0] = 0xc0c0c0c0;
    array_to_send[1] = 0xc0c0c0c0;
    array_to_send[2] = 0xc0c0c0c0;
    array_to_send[3] = 0xc0c0c0c0;
    array_to_send[4] = 0xc0c0c0c0;
    ETHERNET_send_data(2,array_to_send,5); // initialize

    unsigned int i;

    array_to_send[0]  = 0xFFFF88E3;
    array_to_send[1]  = 0xFFFF88E3;
    array_to_send[2]  = 0x56789ABC;
    array_to_send[3]  = 0x08004500;
    array_to_send[4]  = 0x002488E3;
    array_to_send[5]  = 0x56789ABC;
    array_to_send[6]  = 0xa9fe1032;
    array_to_send[7]  = 0x00000000;
    array_to_send[8]  = 0x0000c0a8;
    array_to_send[9]  = 0x01010000;
    array_to_send[10]  = 0x46320400;
    array_to_send[10] = 0x00000204;
    array_to_send[11] = 0x05b40103;
    array_to_send[12] = 0x03080101;
    array_to_send[13] = 0x04025024;
    array_to_send[14] = 0xD6500000;
    array_to_send[15] = 0x00000000;
    array_to_send[16] = 0x00000000;
    array_to_send[17] = 0xD6500000;
    array_to_send[18] = 0x00000000;
    array_to_send[20] = 0x00000000;
    array_to_send[21] = 0x00000000;

    
    delay_us(10);
    ETHERNET_send_data(2,array_to_send,22);

    while(1){
        control_led_via_uart();

        if ( !ETHERNET_rx_empty(1) ){
            data_count = ETHERNET_data_count(1);
            protocol   = ETHERNET_protocol(1);

            UART_send_word(data_count);
            UART_send_word(protocol);
            
            ETHERNET_read_data(1,recieved_array, ( data_count >> 2) );



            for( i=0; i< (data_count >> 2) ;i++){
                while(1){
                    if ( UART_check_busy() == 0)
                        break;
                } // ждем пока законяатся транзакции

                UART_send_word(recieved_array[i]);
            }

        }
    }
    // ETHERNET_check_done(1);
    // ETHERNET_data_count(1);
    // ETHERNET_protocol(1);
    // ETHERNET_rx_empty(1);
    */
   while(1){
       control_led_via_uart();
   }
}

void control_led_via_uart(){
    
    unsigned int data;

    if ( UART_check() != 0){
        data = UART_read_data();
        set_led(data);
    }
        
    
}


