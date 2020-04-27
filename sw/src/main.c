#include "defines.h"
#include "uart_controller.c"
#include "timer.c"
#include "led_ctrl.c"

int main(void){
	
    unsigned int i;
    unsigned int data;
    UART_send_byte(72);

    while (1){
        for ( i = 0; i<255; i++){
            delay_us(10);

            if ( UART_check() != 0)
                data = UART_read_data();
                set_led(data);

        }
    }
}


