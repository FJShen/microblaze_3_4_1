-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Wed Jun  6 13:46:19 2018
-- Host        : RIEMANN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/HUST_study/FPGA_based_DSP/nexys_microblaze_with_mig_with_tft/nexys_microblaze_with_mig_with_tft.srcs/sources_1/bd/design_1/ip/design_1_dtmv_mod_mm2s_cmd_0/design_1_dtmv_mod_mm2s_cmd_0_stub.vhdl
-- Design      : design_1_dtmv_mod_mm2s_cmd_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_dtmv_mod_mm2s_cmd_0 is
  Port ( 
    dout : out STD_LOGIC_VECTOR ( 71 downto 0 )
  );

end design_1_dtmv_mod_mm2s_cmd_0;

architecture stub of design_1_dtmv_mod_mm2s_cmd_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "dout[71:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "xlconstant_v1_1_3_xlconstant,Vivado 2017.4";
begin
end;
