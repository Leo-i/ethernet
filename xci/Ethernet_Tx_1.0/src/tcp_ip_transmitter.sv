
module tcp_ip_transmitter(  
        input           clk,
        input           rst_n,

        input           en_i,

        input   [31:0]  MAC_1, //DST
        input   [31:0]  MAC_2, //DST-SRC
        input   [31:0]  MAC_3, //SRC
        input   [7:0]   MAC_LENGTH,

        input   [31:0]  Ver_IHL_TypeOfService_Length, 
        input   [31:0]  Id_Flags_FragmentOffset,     
        input   [31:0]  LiveTime_Protocol_Checksum,
        input   [31:0]  Src_addr,
        input   [31:0]  Dst_addr,

        input   [31:0]  SrcPort_DstPort, 
        input   [31:0]  SequenceNum,     
        input   [31:0]  AckNum,
        input   [31:0]  tcp_param,
        input   [31:0]  Checksum_urgentPointer,
        input   [31:0]  Options_Padding,

        input   [10:0]  data_count,
        input   [31:0]  data,
        output  reg     done_send,

        input   [31:0]  checksum_FCS,

        output          busy,
        output  [1:0]   tx_d,
        output          tx_e
);


reg [4:0]       state = 5'h0;   
reg [1:0]       data_send   = 2'b00;
reg [31:0]      data_to_send;
reg [1:0]       send_state = 2'b00;
reg [31:0]      current_data = 32'h0;

reg [7:0]       data_to_tx = 8'b0;
reg             en;

assign busy =  ( state != 0 ) ;

transmitter Tx(
 .ref_clk    ( clk           ),
 .rst_n      ( rst_n         ),
 .data       ( data_to_tx    ),
 .en_i       ( en            ),
 .tx_d       ( tx_d          ),
 .tx_e       ( tx_e          ),
 .done_o     ( done          )
);

always_ff@( posedge clk ) begin
    
    if ( rst_n == 0) begin
        state           <= 4'h0;  
        current_data    <= 32'b0;
        send_state      <= 2'b00;
    end else
    begin

        
        if ( done ) begin
            case ( state )

                5'h0:       begin
                    en              <= 1'b0; 
                    current_data    <= 32'b0;  
                    send_state      <= 2'b00;
                    data_send       <= 2'b00;  
                        if ( en_i ) begin
                            state  <= 4'h1;
                            data_to_send       <= 32'hAAAAAAAA;
                            data_send          <= 2'b01;
                            en                 <= 1'b1; 
                        end
                end

                5'h1:       begin data_send   <= 2'b01;  data_to_send       <= 32'hAAAAAAAA;                 end 
                5'h2:       begin data_send   <= 2'b01;  data_to_send       <= 32'hAAAAAAAB;                 end
                5'h3:       begin data_send   <= 2'b01;  data_to_send       <= MAC_1;                        end
                5'h4:       begin data_send   <= 2'b01;  data_to_send       <= MAC_2;                        end
                5'h5:       begin data_send   <= 2'b01;  data_to_send       <= MAC_3;                        end

                5'h6:       begin data_send   <= 2'b11;  state <= state + 1;     end

                5'h7:       begin data_send   <= 2'b01;  data_to_send       <= Ver_IHL_TypeOfService_Length; end
                5'h8:       begin data_send   <= 2'b01;  data_to_send       <= Id_Flags_FragmentOffset;      end
                5'h9:       begin data_send   <= 2'b01;  data_to_send       <= LiveTime_Protocol_Checksum;   end
                5'hA:       begin data_send   <= 2'b01;  data_to_send       <= Src_addr;                     end
                5'hB:       begin data_send   <= 2'b01;  data_to_send       <= Dst_addr;                     end
                5'hC:       begin data_send   <= 2'b01;  data_to_send       <= SrcPort_DstPort;              end
                5'hD:       begin data_send   <= 2'b01;  data_to_send       <= SequenceNum;                  end
                5'hE:       begin data_send   <= 2'b01;  data_to_send       <= AckNum;                       end
                5'hF:       begin data_send   <= 2'b01;  data_to_send       <= tcp_param;                    end
                5'h10:      begin data_send   <= 2'b01;  data_to_send       <= Checksum_urgentPointer;       end
                5'h11:      begin data_send   <= 2'b01;  data_to_send       <= Options_Padding;              end
                5'h12:      begin data_send   <= 2'b10;  data_to_send       <= data;                         end
                5'h13:      begin data_send   <= 2'b01;  data_to_send       <= checksum_FCS;                 end

                default:    begin 
                    data_send   <= 2'b00;
                    en          <= 1'b0;
                    state       <= 5'h0;         
                end
                
            endcase

            case( data_send )

                2'b01: begin     // send 32 bit

                    en <= 1'b1;
                    case ( send_state )
                        2'b00: begin 
                            data_to_tx <= data_to_send[31:24]; 
                            send_state <= 2'b01; 
                            if ( state == 5'h14 )
                                en  <= 1'b0;
                            else
                                en  <= 1'b1;
                        end
                        2'b01: begin 
                            data_to_tx <= data_to_send[23:16]; 
                            send_state <= 2'b10; 
                        end
                        2'b10: begin

                            data_to_tx <= data_to_send[15:8];  
                            send_state <= 2'b11;

                            if ( (state == 5'h11) && ( data_count == 0 ) )
                                state   <= 5'h13;
                            else
                                state   <= state + 1; 

                        end
                        2'b11: begin 
                            data_to_tx <= data_to_send[7:0];  
                            send_state <= 2'b00;
                            if ( state == 5'h14 )
                                en  <= 1'b0;
                            else
                                en  <= 1'b1;
                        end
                    endcase

                end
                2'b10: begin     // send data

                    en <= 1'b1;

                    if ( ( data_count - 2'h2 ) == current_data ) begin
                        state           <= state + 1;
                        current_data    <= 32'b0;
                        send_state      <= 2'b00;
                    end else
                        current_data    <= current_data + 1'b1;
                    
                    case ( send_state )
                        2'b00: begin data_to_tx <= data_to_send[31:24]; send_state <= 2'b01;  end
                        2'b01: begin data_to_tx <= data_to_send[23:16]; send_state <= 2'b10;  end
                        2'b10: begin data_to_tx <= data_to_send[15:8];  send_state <= 2'b11; done_send <= 1'b1; end
                        2'b11: begin data_to_tx <= data_to_send[7:0];   send_state <= 2'b00;  end
                    endcase
                    
                end

                2'b11: begin
                    data_to_tx  <= MAC_LENGTH;  
                end

                default: ;

            endcase
            
        end
    end
end

endmodule