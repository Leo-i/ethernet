
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

char ETHERNET_check_done( unsigned int module ){ // TX done
    
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

char ETHERNET_rx_ready( unsigned int module ){
    
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_RX_EMPTY );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_RX_EMPTY );

    return (int)*p;
}

void ETHERNET_set_RX_mode(
                        unsigned int module,
                        unsigned int mode ) // bytes count
{
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_RX_MODE );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_RX_MODE );

    *p = mode;
    
    
}

void DM_set_reg( unsigned int module, unsigned int addr_mode, unsigned int data){
    int *addr_mode_ptr;
    int *data_ptr;

    if ( module == 1)
        addr_mode_ptr = ( ETHERNET_1_BASE_ADDR + ETHERNET_DM_ADDR_MODE );
    else
        addr_mode_ptr = ( ETHERNET_2_BASE_ADDR + ETHERNET_DM_ADDR_MODE );

    if ( module == 1)
        data_ptr = ( ETHERNET_1_BASE_ADDR + ETHERNET_DM_DATA_WRITE );
    else
        data_ptr = ( ETHERNET_2_BASE_ADDR + ETHERNET_DM_DATA_WRITE );

    *data_ptr = data;
    *addr_mode_ptr = addr_mode;
}

char DM_busy( unsigned int module ){
    int *p;
    if ( module == 1)
        p = ( ETHERNET_1_BASE_ADDR + ETHERNET_DM_BUSY );
    else
        p = ( ETHERNET_2_BASE_ADDR + ETHERNET_DM_BUSY );

    return (int)*p;
}

int DM_get_reg( unsigned int module, unsigned int addr_mode ){
    int *addr_mode_ptr;
    int *data;

    if ( module == 1)
        addr_mode_ptr = ( ETHERNET_1_BASE_ADDR + ETHERNET_DM_ADDR_MODE );
    else
        addr_mode_ptr = ( ETHERNET_2_BASE_ADDR + ETHERNET_DM_ADDR_MODE );

    while(1)
        if ( DM_busy(module) == 0 ) break;

    if ( module == 1)
        data = ( ETHERNET_1_BASE_ADDR + ETHERNET_DM_DATA_READ );
    else
        data = ( ETHERNET_2_BASE_ADDR + ETHERNET_DM_DATA_READ );

    return (int)*data;
}
