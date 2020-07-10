#include "defines.h"
#include "uart_controller.c"
#include "timer.c"
#include "led_ctrl.c"
#include "ethernet.c"

void bootloader(){
    int min_addr = 0x000006e8;
    int max_addr;
    while(1) if (UART_check() != 0) break;
    max_addr = UART_read_data();

    while(1) if (UART_check() != 0) break;
    max_addr = (max_addr << 8) + UART_read_data();

    while(1) if (UART_check() != 0) break;
    max_addr = (max_addr << 8) + UART_read_data();

    while(1) if (UART_check() != 0) break;
    max_addr = (max_addr << 8) + UART_read_data();

    int data;

    for (int i = min_addr; i <= max_addr; i = i + 4)
    {
        int *p = i;

        while(1) if (UART_check() != 0) break;
        data = UART_read_data();

        while(1) if (UART_check() != 0) break;
        data = (data << 8) + UART_read_data();
        
        while(1) if (UART_check() != 0) break;
        data = (data << 8) + UART_read_data();
        
        while(1) if (UART_check() != 0) break;
        data = (data << 8) + UART_read_data();

        *p = data;
    }

    asm ("j main");
    
}
int main(void){
    set_led(0x8E);
}

// int main(void){

//     while(1){

//         while(1) if (UART_check() != 0) break;

//         int data = UART_read_data();

//         if ( data == 0x38)
//             bootloader();
//         else
//             set_led(data);
        
//     }
// }
















// int main(void){

//     int rx_data[375];
//     int tx_data[375];

//     tx_data[0] = 0xc0c0c0c0;
//     tx_data[1] = 0xc0c0c0c0;
//     tx_data[2] = 0xc0c0c0c0;
//     tx_data[3] = 0xc0c0c0c0;
//     tx_data[4] = 0xc0c0c0c0;

//     ETHERNET_send_data(2,tx_data,20); // initialize

//     delay_us(100);


//     tx_data[0]  = 0xFFFFFFFF;
//     tx_data[1]  = 0xFFFF0003;
//     tx_data[2]  = 0x47a49ABC;
//     tx_data[3]  = 0x08060001;
//     tx_data[4]  = 0x08000604;
//     tx_data[5]  = 0x00020003;
//     tx_data[6]  = 0x47a49ABC;
//     tx_data[7]  = 0xc0a8016e;
//     tx_data[8]  = 0x0000c0a9;
//     tx_data[9]  = 0x00000000;
//     tx_data[10] = 0x0000c0a8;
//     tx_data[11] = 0x01010000;
//     tx_data[12] = 0x00000000;


//     int command = 0;
//     int mode    = 0;
//     int byte;
//     int data_count;
//     int protocol;
	
//     while(1){
        
//         if ( UART_check() != 0){
//             command = UART_read_data();

//             switch ( command )
//             {
//             case 208:
//                 ETHERNET_send_data(2,tx_data,52);
//                 break;
//             case 240:
//                 ETHERNET_send_data(2,tx_data[2],44);
//                 break;
//             case 156: //listener
//                 mode = 156;
//                 break;
//             case 68://retranslator
//                 mode = 68;
//                 break;
//             // case 215:
//             //     while (1){

//             //         if ( UART_check() != 0){

//             //         }
//             //     }
//             //     break;
//             default:
//                 set_led(command);
//                 break;
//             }
//         }

//         if ( mode == 68 ){ //retranslator mode

//             if (ETHERNET_rx_ready(1)){
//                 ETHERNET_read_data(1,rx_data);
//                 data_count = ETHERNET_data_count(1);
//                 ETHERNET_send_data(2,rx_data,data_count+4);
//             }

//             if (ETHERNET_rx_ready(2)){
//                 ETHERNET_read_data(2,rx_data);
//                 data_count = ETHERNET_data_count(2);
//                 ETHERNET_send_data(1,rx_data,data_count+4);
//             }


//         } else //listener mode

//             if (ETHERNET_rx_ready(1)){
        
//                 protocol   = ETHERNET_protocol(1);
//                 data_count = ETHERNET_data_count(1);
//                 ETHERNET_read_data(1,rx_data);

//                 // while (UART_check_busy());
                
//                 // for ( int byte = 0; byte < ( data_count >> 2 ); byte = byte + 1){

//                 //     while (UART_check_busy());
//                 //     UART_send_word(rx_data[byte]);
//                 // }
//             }
        
//    }
// }






