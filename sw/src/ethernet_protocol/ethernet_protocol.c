#include "ethernet_protocol.h"

// задает параметры по умолчанию для отправляемой датаграммы
void init_packet(int *tx_data){

    char dest_MAC [6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00 };
    char own_MAC  [6] = { 0x12, 0x34, 0x56, 0x78, 0xAB, 0xCD, 0x00, 0x00 };
    char type     [2] = { 0x08, 0x06 };

    set_destanation_MAC_addr(*tx_data,*dest_MAC);
    set_source_MAC_addr(*tx_data,*own_MAC);
    set_protocol_type(*tx_data,*type);

    init_arp(&tx_data);
}

void set_destanation_MAC_addr(int *tx_data,int *MAC){
    copy_array(tx_data,MAC,0,5);
}
void set_source_MAC_addr(int *tx_data,int *MAC){
    copy_array(tx_data,MAC,6,11);
}
void set_protocol_type(int *tx_data,int *type){
    copy_array(tx_data,type,12,13);
}


// Отправляет все полученные пакеты через юарт
void listener_mode( char module ){

    if (ETHERNET_rx_ready( module )){
        
        int rx_data[375];
        int data_count = ETHERNET_data_count(module);

        ETHERNET_read_data(1,rx_data);
        
        for ( int byte = 0; byte < ( data_count >> 2 ); byte = byte + 1){

            while (UART_check_busy());
            UART_send_word(rx_data[byte]);
        }
    }
}

// Получает пакеты с одного порта и отправляет на другой
void retranslator_mode(){

    if (ETHERNET_rx_ready(1)){
        int rx_data[375];
        ETHERNET_read_data(1,rx_data);
        int data_count = ETHERNET_data_count(1);
        ETHERNET_send_data(2,rx_data,data_count+4);
    }

    if (ETHERNET_rx_ready(2)){
        int rx_data[375];
        ETHERNET_read_data(2,rx_data);
        int data_count = ETHERNET_data_count(2);
        ETHERNET_send_data(1,rx_data,data_count+4);
    }

}

void send_echo_query( char module ){
    return;
}