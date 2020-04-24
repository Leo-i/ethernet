#include "defines.h"

void UART_INTERUPT_HANDLER();
void ETH1_INTERUPT_HANDLER();
void ETH2_INTERUPT_HANDLER();
void delay(int time);
void delay_ms(int time);
void delay_us(int time);

void INTERUPT_HANDLER(){
    int *p = IRQ_ADDR;

    if ( (*p) == 0x00000001 ){
        UART_INTERUPT_HANDLER();
    }
    if ( (*p) == 0x00000002 ){
        ETH1_INTERUPT_HANDLER();
    }
    if ( (*p) == 0x00000004 ){
        ETH2_INTERUPT_HANDLER();
    }
}

int main(void){
	int *p = (LED_BASE_ADDR + LED_CTRL);

    *p = 10;
    
    int i = 0;

    while (1){
        for(i = 0; i < 255; i = i + 1){
        delay_ms(1000);
        *p = i;
        }
    }
}
void delay_ms(int time){
    int delay = time*1964;
    for(int i = 0; i<delay;i++); // ms
}
void delay_us(int time){
    int delay = time << 1;
    for(int i = 0; i<delay;i++); // ms
}
void delay(int time){
    for(int i = 0; i<time;i++); // 509 ns
}

void UART_INTERUPT_HANDLER(){

}

void ETH1_INTERUPT_HANDLER(){

}

void ETH2_INTERUPT_HANDLER(){

}