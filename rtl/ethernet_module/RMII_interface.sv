

interface RMII();


logic     [1:0]     tx_d    ;
logic               tx_e    ;
logic               rx_er   ;
logic     [1:0]     rx_d    ;
logic               crs_dv  ;
logic               MDIO    ;
logic               MDC     ;

modport master(
    input
        rx_er,
        rx_d,
        crs_dv,
    output
        tx_d,
        tx_e,
        MDC,
    inout
        MDIO
);
modport slave(
    output
        rx_er,
        rx_d,
        crs_dv,
    input
        tx_d,
        tx_e,
        MDC,
    inout
        MDIO
);

endinterface