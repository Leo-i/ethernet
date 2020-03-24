`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2020 22:16:42
// Design Name: 
// Module Name: tb_crc_32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_crc_32();

reg [31:0]  data_1 = 32'hABCDEF12;
reg [31:0]  data_2 = 32'h12345678;
reg [31:0]  data_3 = 32'hABCDEF12;
reg [7:0]   data_4 = 8'hABCD;
reg [31:0]  data_5 = 32'hABCDEF12;
reg [31:0]  data_6 = 32'h12345678;

reg         rst_n       = 1'b1;
reg [4:0]   state       = 5'b0;
reg [1:0]   data_send   = 2'b0;
reg [31:0]  data_to_send;
reg         done = 1'b0;
reg [5:0]   i;
reg [4:0]   j    = 5'hF; ;

reg         clk    = 1'b1 ; 
reg         clear  = 1'b0 ; 
reg         BITVAL = 1'b0 ; 
reg         valid  = 1'b0 ;

reg         en = 1'b0;

wire    [31:0]  CRC;

reg [31:0]  input_data = 32'h8;

initial begin
    #30
    rst_n   <= 1'b0;
    #20
    rst_n   <= 1'b1;
    #200
    
    en = 1'b1;
    #20
    en = 1'b0;
    #2000
    $finish;
end

always@( posedge clk ) begin

    if  ( rst_n == 0 ) begin
        state           <= 4'h0;
        clear           <= 1'b0;
        data_send       <= 2'b0;
        data_to_send    <= 32'b0;
        done            <= 1'b0;
        i               <= 6'h1F;
        j               <= 5'hF;
    end  else if ( en )
    begin
        state  <= 4'h1;
        clear  <= 1'b1;
    end
    
    case ( state )
        5'h0:       begin valid       <= 1'b0;   i <= 6'h1F;   j <= 5'hF;   done <= 1'b0; data_send   <= 2'b0;                  end
        5'h1:       begin data_send   <= 2'b01;  data_to_send       <= 32'hB888E3A7; clear  <= 1'b0;                                  end
        5'h2:       begin data_send   <= 2'b01;  data_to_send       <= 32'hB3411234; clear  <= 1'b0;                                  end
        5'h3:       begin data_send   <= 2'b01;  data_to_send       <= 32'h56789ABC; clear  <= 1'b0;                                  end
        5'h4:       begin data_send   <= 2'b01;  data_to_send       <= 32'h08004500; clear  <= 1'b0;                                  end
        5'h5:       begin data_send   <= 2'b01;  data_to_send       <= 32'h00347284; clear  <= 1'b0;                                  end
        5'h6:       begin data_send   <= 2'b01;  data_to_send       <= 32'h40008006; clear  <= 1'b0;                                  end
        5'h7:       begin data_send   <= 2'b01;  data_to_send       <= 32'h0000C0A8; clear  <= 1'b0;                                  end
        5'h8:       begin data_send   <= 2'b01;  data_to_send       <= 32'h013A3472; clear  <= 1'b0;                                  end
        5'h9:       begin data_send   <= 2'b01;  data_to_send       <= 32'h4D21D3F7; clear  <= 1'b0;                                  end
        5'hA:       begin data_send   <= 2'b01;  data_to_send       <= 32'h01bbbe71; clear  <= 1'b0;                                  end
        5'hB:       begin data_send   <= 2'b01;  data_to_send       <= 32'hF26a0000; clear  <= 1'b0;                                  end
        5'hC:       begin data_send   <= 2'b01;  data_to_send       <= 32'h00008002; clear  <= 1'b0;                                  end
        5'hD:       begin data_send   <= 2'b01;  data_to_send       <= 32'hFAF0439C; clear  <= 1'b0;                                  end
        5'hE:       begin data_send   <= 2'b01;  data_to_send       <= 32'h00000204; clear  <= 1'b0;                                  end
        5'hF:       begin data_send   <= 2'b01;  data_to_send       <= 32'h05b40103; clear  <= 1'b0;                                  end
        5'h10:      begin data_send   <= 2'b10;  data_to_send[15:0] <= 16'h0402; clear  <= 1'b0;                                  end
        default:    begin valid       <= 1'b0;   state <=  4'h0;    data_send   <= 2'b0;  clear  <= 1'b0; done <= 1'b1;         end
    endcase

    case( data_send )
        2'b01: begin    // send 32 bit

            if ( i == 6'b1 ) begin
                state   <= state + 1'b1;
                BITVAL  <= data_to_send[i];
                i       <= 6'b0;
                valid   <= 1'b1;
            end if ( i == 6'b0 ) begin
                valid   <= 1'b1;
                BITVAL  <= data_to_send[i];
                i       <= 6'h1F;
            end else 
            begin
                i       <= i - 1;
                valid   <= 1'b1;
                BITVAL  <= data_to_send[i];
            end

        end
        2'b10: begin    // send 16 bit

            if ( j == 6'b1 ) begin
                state   <= state + 1'b1;
                BITVAL  <= data_to_send[j];
                j       <= 6'b0;
                valid   <= 1'b1;
            end if ( j == 3'b0 ) begin
                valid   <= 1'b1;
                BITVAL  <= data_to_send[j];
                j       <= 5'hF;
            end else 
            begin
                j       <= j - 1;
                valid   <= 1'b1;
                BITVAL  <= data_to_send[j];
            end
        end
        default: valid  <= 1'b0;
    endcase
    
end


CRC_32_calculator crc_32(
.clk        ( clk    ),
.clear      ( clear  ),
.BITVAL     ( BITVAL ),
.CRC        ( CRC    ),
.valid      ( valid  )
);

initial begin
    forever begin
        #5
        clk <= !clk;
    end
end
endmodule
