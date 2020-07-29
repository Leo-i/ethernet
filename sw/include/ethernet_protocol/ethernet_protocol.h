
void listener_mode( char module );
void retranslator_mode();
void send_echo_query( char module );
void init_packet(int *tx_data);
void set_destanation_MAC_addr(int *tx_data,int *MAC);
void set_source_MAC_addr(int *tx_data,int *MAC);
void set_protocol_type(int *tx_data,int *type);



typedef char mac[6];
typedef char type[2];