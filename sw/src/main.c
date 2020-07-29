asm ("j main"); // start program

//board support
#include "defines.h"
//drivers
#include "uart_controller.c"
#include "common_functions.c"
#include "timer.c"
#include "led_ctrl.c"
#include "ethernet.c"
//ПО
#include "ethernet_protocol.h"
#include "arp_protocol.h"

int main(void);//init

void bootloader(){ // Обновляем ПО, сначала пишем длину прошивки, потом ее саму
    int min_addr = &main;
    int length;
    while(1) if (UART_check() != 0) break;
    length = UART_read_data();

    while(1) if (UART_check() != 0) break;
    length = (length << 8) + UART_read_data();

    while(1) if (UART_check() != 0) break;
    length = (length << 8) + UART_read_data();

    while(1) if (UART_check() != 0) break;
    length = (length << 8) + UART_read_data();

    int data;

    for (int i = min_addr; i <= length + min_addr ; i = i + 4){
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

char A = 0x37;

int main(void){


    int rx_data [375];
    int tx_data [375];
    char command = 0x1;

    //init_packet(&tx_data);

    set_led(A);

    while(1){
        
        // Определяем команду пришедшую с юарт
        if ( UART_check() != 0 )
            command = UART_read_data();

        switch ( command ){

            case 0x38: bootloader(); break; // обновляем ПО

            case 0x56: listener_mode(1); break; //Прослушиваем порт
            case 0x57: listener_mode(2); break; 

            case 0xA4: send_echo_query(1); break;  // Отправить эхо запрос
            case 0xA6: send_echo_query(2); break; 

            case 0x85: ETHERNET_set_RX_mode(1,0); break; // режим работы приемника
            case 0x86: ETHERNET_set_RX_mode(1,1); break;

            case 0x20: retranslator_mode(); break; // переходим в режим ретранслятора
            
            default: set_led(command); // Если пришла неизвестная команда то выводим ее на светодиоды
        }
    }
       
}

