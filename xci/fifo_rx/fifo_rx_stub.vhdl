-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1756540 Mon Jan 23 19:11:23 MST 2017
-- Date        : Sat Mar 14 15:39:07 2020
-- Host        : DESKTOP-0U9RJHC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub d:/projects/Ethernet_50T/src/xci/fifo_rx/fifo_rx_stub.vhdl
-- Design      : fifo_rx
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a50tftg256-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo_rx is
  Port ( 
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC
  );

end fifo_rx;

architecture stub of fifo_rx is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,srst,din[7:0],wr_en,rd_en,dout[7:0],full,empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_1_3,Vivado 2016.4";
begin
end;
