/*
 * ethernet.h
 *
 *  Created on: 9 ����� 2020 �.
 *      Author: lev_i
 */

#ifndef SRC_ETHERNET_H_
#define SRC_ETHERNET_H_

#include "Ethernet_Tx.h"


void send(); // start transaction
void initialization(); // set tcp/ip reg -> 0
u8 chek_busy();

//Ethernet
void update_ethernet();
void enable_FCS_calculator();
void disable_FCS_calculator();
void set_MAC_DST_addr(u32 mac_1, u16 mac_2); //first and second part of MAC addr
void set_MAC_SRC_addr(u16 mac_1, u32 mac_2); //first and second part of MAC addr
void set_ip_type();
void set_FCS(u32 fcs);
u32  get_FCS();

// tcp
void set_version(u8 version); //4 bits
void set_IHL(u8 ihl);         //4 bits
void set_type_of_service(u8 type); // 8 bits
void set_total_length(u16 length);
void set_identification(u16 id);
void set_flags(u8 flags); // 3 bit
void set_fragmet_offset(u16 offset); //13 bit
void set_time_to_live(u8 time);
void set_protocol(u8 protocol);
void set_header_checksum(u16 schecksum);
void set_src_ip(u32 ip);
void set_dst_ip(u32 ip);

//ip
void set_src_port(u16 port);
void set_dst_port(u16 port);
void set_sequence_number(u32 number);
void set_ack_number(u32 number);
void set_data_offset(u8 offset);//4 bit
void set_reserved(u8 reserved); //6 bits, must be 0
void enable_flag_URG();
void enable_flag_ACK();
void enable_flag_PSH();
void enable_flag_RST();
void enable_flag_SYN();
void enable_flag_FIN();
void disable_flag_URG();
void disable_flag_ACK();
void disable_flag_PSH();
void disable_flag_RST();
void disable_flag_SYN();
void disable_flag_FIN();
void set_window(u16 window);
void set_checksum(u16 checksum);
void set_urgent_pointer(u16 pointer);
void set_options(u32 options); //variable from 8 bits
void set_UDP(u8 udp);

//data
void set_data_count(u16 count);
void set_data(u32 data_32);


#endif /* SRC_ETHERNET_H_ */
