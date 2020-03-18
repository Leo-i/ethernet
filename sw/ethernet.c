/*
 * ethernet.c
 *
 *  Created on: 9 ����� 2020 �.
 *      Author: lev_i
 */

//#include "ethernet.h"
#include "Ethernet_Tx.h"

u32 signals                      = 0 ; 
u32 MAC_1                        = 0 ; 
u32 MAC_2                        = 0 ; 
u32 MAC_3                        = 0 ; 
u32 MAC_LENGTH                   = 0 ; 
u32 Ver_IHL_TypeOfService_Length = 0 ; 
u32 Id_Flags_FragmentOffset      = 0 ; 
u32 LiveTime_Protocol_Checksum   = 0 ; 
u32 Src_addr                     = 0 ; 
u32 Dst_addr                     = 0 ; 
u32 SrcPort_DstPort              = 0 ; 
u32 SequenceNum                  = 0 ; 
u32 AckNum                       = 0 ; 
u32 tcp_param                    = 0 ; 
u32 Checksum_urgentPointer       = 0 ; 
u32 Options_Padding              = 0 ; 
u32 data                         = 0 ; 
u32 checksum_FCS                 = 0 ; 
u32 busy                         = 0 ; 

u32 base_addr                    = 0x441A0000;

void initialization(){
    Ver_IHL_TypeOfService_Length = 0;
    Id_Flags_FragmentOffset      = 0;
    LiveTime_Protocol_Checksum   = 0;
    Src_addr                     = 0;
    Dst_addr                     = 0;
    SrcPort_DstPort              = 0;
    SequenceNum                  = 0;
    AckNum                       = 0;
    tcp_param                    = 0;
    Checksum_urgentPointer       = 0;
    Options_Padding              = 0;
}

void update_ethernet(){

    ETHERNET_TX_mWriteReg(base_addr,
        ETHERNET_TX_S00_AXI_SLV_REG0_OFFSET, signals);

    ETHERNET_TX_mWriteReg(base_addr, 
        ETHERNET_TX_S00_AXI_SLV_REG1_OFFSET, MAC_1);

    ETHERNET_TX_mWriteReg(base_addr, 
        ETHERNET_TX_S00_AXI_SLV_REG2_OFFSET, MAC_2);

    ETHERNET_TX_mWriteReg(base_addr, 
        ETHERNET_TX_S00_AXI_SLV_REG3_OFFSET, MAC_3);

    ETHERNET_TX_mWriteReg(base_addr, 
        ETHERNET_TX_S00_AXI_SLV_REG4_OFFSET, MAC_LENGTH);

    ETHERNET_TX_mWriteReg(base_addr, 
        ETHERNET_TX_S00_AXI_SLV_REG17_OFFSET, checksum_FCS);
}

void send(){
    signals = signals | 0x00000001;
}

void enable_FCS_calculator(){
    signals = signals | 0x00000002;
}
void disable_FCS_calculator(){
    signals = signals & 0xFFFFFFFD;
}
void set_MAC_DST_addr(u32 mac_1, u16 mac_2){
    u32 mac_part = mac_2 << 16;
    MAC_1 = mac_1;
    MAC_2 = ( MAC_2 & 0x0000FFFF ) + mac_part;
}

void set_MAC_SRC_addr(u16 mac_1, u32 mac_2){
    MAC_2 = ( MAC_2 & 0xFFFF0000 ) + mac_1;
    MAC_3 = mac_2;
}

void set_ip_type(){
    MAC_LENGTH = 0x00000800;
}

void set_FCS(u32 fcs){
    checksum_FCS < fcs;
}

void set_data_count(u16 count){
    signals = ( signals && 0x00000003 ) + count;
}

void set_data(u32 data_32){
    data = data_32;
}
