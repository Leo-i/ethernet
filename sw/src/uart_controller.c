#include "defines.h"

int UART_check_busy(){
    int *p = (UART_BASE_ADDR + UART_TX_BUSY);
    return (int)*p;
}

int UART_read_data(){
    int *p = (UART_BASE_ADDR + UART_RX_DATA);
    return (int)*p;
}

void UART_send_byte(int data){
    int *p = (UART_BASE_ADDR + UART_TX_DATA);
    *p = data;
}

void UART_send_word(int data){
    int *p = (UART_BASE_ADDR + UART_TX_DATA);
    *p = data << 24;
    *p = data << 16;
    *p = data << 8;
    *p = data;
}

int UART_check(){
    int *p = (UART_BASE_ADDR + UART_READY);
    return (int)*p;
}