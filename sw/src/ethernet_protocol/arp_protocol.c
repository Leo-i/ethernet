#include "arp_protocol.h"
void init_arp(int * tx_data){
    // hardware type
    tx_data[14] = 0x00;
    tx_data[15] = 0x01;
    //protocol type
    tx_data[16] = 0x08;
    tx_data[17] = 0x00;
    //hardware length
    tx_data[18] = 0x06;
    //protocol_length
    tx_data[19] = 0x04;
    //operation
    tx_data[20] = 0x00;
    tx_data[21] = 0x01;
    // own MAC addr 
    tx_data[22] = 0x36;
    tx_data[23] = 0x36;
    tx_data[24] = 0x36;
    tx_data[25] = 0x36;
    tx_data[26] = 0x36;
    tx_data[27] = 0x36;
    // own IP
    tx_data[28] = 0x36;
    tx_data[29] = 0x36;
    tx_data[30] = 0x36;
    tx_data[31] = 0x36;
    // target MAC addr 
    tx_data[32] = 0x00;
    tx_data[33] = 0x00;
    tx_data[34] = 0x00;
    tx_data[35] = 0x00;
    tx_data[36] = 0x00;
    tx_data[37] = 0x00;
    // target IP
    tx_data[38] = 0x00;
    tx_data[39] = 0x01;
    tx_data[40] = 0x10;
    tx_data[41] = 0x11;
    // padding
    tx_data[42] = 0x00;
    tx_data[43] = 0x00;
    tx_data[44] = 0x00;
    tx_data[45] = 0x00;
    tx_data[46] = 0x00;
    tx_data[47] = 0x00;
    tx_data[48] = 0x00;
    tx_data[49] = 0x00;
    tx_data[50] = 0x00;
    tx_data[51] = 0x00;
    tx_data[52] = 0x00;
    tx_data[53] = 0x00;
    tx_data[54] = 0x00;
    tx_data[55] = 0x00;
    tx_data[56] = 0x00;
    tx_data[57] = 0x00;
    tx_data[58] = 0x00;
    tx_data[59] = 0x00;
}

// void set_hardware_type(int * tx_data,int * type){

// }
