module boot_rom #(
  parameter BOOT_FILE      = "", 
  parameter BOOT_CODE_SIZE = 234,
  parameter DATA_WIDTH     = 32,
  parameter ADDR_WIDTH     = 10
)
(
  input  logic                  clk_i,
  input  logic                  rst_n_i,

  input  logic                  en_i,
  input  logic [ADDR_WIDTH-1:0] addr_i,
  output logic [DATA_WIDTH-1:0] rdata_o
);

  reg [DATA_WIDTH-1:0] mem [0:(BOOT_CODE_SIZE/4)-1];

  initial 
  begin: InitMemory //check
    $readmemh(BOOT_FILE, mem);
  end

  always_ff @(posedge clk_i, negedge rst_n_i)
  begin: Data_Out
    if (~rst_n_i)
      rdata_o <= '0;
    else
      if (en_i)
        rdata_o <= mem[addr_i];
  end


endmodule

