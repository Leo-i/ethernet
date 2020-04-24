
interface AXI_LITE
#(
    parameter AXI_ADDR_WIDTH = 32,
    parameter AXI_DATA_WIDTH = 32
) (
    input       aclk,
    input       aresetn
);

// write
logic      [AXI_ADDR_WIDTH-1:0] awaddr  ;
logic                           awvalid ;
logic                           awready ;

logic      [AXI_DATA_WIDTH-1:0] wdata   ;
logic                           wlast   ;
logic                           wvalid  ;
logic                           wready  ;

logic      [1:0]                bresp   ;
logic                           bvalid  ;
logic                           bready  ;
// read
logic      [AXI_ADDR_WIDTH-1:0] araddr  ;
logic                           arvalid ;
logic                           arready ;

logic      [AXI_DATA_WIDTH-1:0] rdata   ;
logic                           rlast   ;
logic                           rvalid  ;
logic                           rready  ;


modport master(
    input
        awready ,
        wready  ,
        bresp   ,
        bvalid  ,
        bready  ,
        arready ,
        rdata   ,
        rlast   ,
        rvalid  ,
        aclk    ,
        aresetn ,

    output
        awaddr  ,
        awvalid ,
        wdata   ,
        wlast   ,
        wvalid  ,
        araddr  ,
        arvalid ,
        rready  
        
);
modport slave(
    output
        awready,
        wready,
        bresp,
        bvalid,
        bready,
        arready,
        rdata,
        rlast,
        rvalid,
       
        
    input
        awaddr,
        awvalid,
        wdata,
        wlast,
        wvalid,
        araddr,
        arvalid,
        rready,
        aclk,
        aresetn
);

endinterface