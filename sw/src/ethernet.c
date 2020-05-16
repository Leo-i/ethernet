#include "defines.h"

void ETHERNET_send_data(
                        unsigned int module,
                        unsigned int *data,
                        unsigned int data_count ) // bytes count
{
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_TX_DATA_IN );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_TX_DATA_IN );
    
    int *brust_en = 0xA0A00B08; //enable brust mode
    *brust_en = 64;

    int i;
    int c_data_count = data_count >> 2;

    for (i = 0; i <= c_data_count; i++){

        if ( i == c_data_count )
            *brust_en = data[i];           //disable brust and close transaction
        else
            *p = data[i];
    }
    
}

void ETHERNET_read_data(
                        unsigned int module,
                        unsigned int *data)
{
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_RX_DATA );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_RX_DATA );

    int *brust_en = 0xA0A00B08; 
    
    int i = *brust_en;//enable brust mode

    int iteration = 0;
    int r_data;

    while (1){
        r_data = *p;
        if ( r_data ==  0xA0A00B08)
            return;

        data[iteration] = r_data;
        iteration = iteration + 1;
    }
}

int ETHERNET_check_done( unsigned int module ){
    
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_TX_DONE );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_TX_DONE );

    return (int)*p;
}

int ETHERNET_data_count( unsigned int module ){
    
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_RX_DATA_COUNT );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_RX_DATA_COUNT );

    return (int)*p;
}

int ETHERNET_protocol( unsigned int module ){
    
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_RX_PROTOCOL_TYPE );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_RX_PROTOCOL_TYPE );

    return (int)*p;
}

int ETHERNET_rx_ready( unsigned int module ){
    
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_RX_EMPTY );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_RX_EMPTY );

    return (int)*p;
}