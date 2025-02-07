-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Tue May 29 00:16:25 2018
-- Host        : RIEMANN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/HUST_study/FPGA_based_DSP/nexys_microblaze_with_mig_with_tft/nexys_microblaze_with_mig_with_tft.srcs/sources_1/bd/design_1/ip/design_1_xlconstant_0_2/design_1_xlconstant_0_2_sim_netlist.vhdl
-- Design      : design_1_xlconstant_0_2
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_xlconstant_0_2 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_xlconstant_0_2 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_xlconstant_0_2 : entity is "design_1_xlconstant_0_2,xlconstant_v1_1_3_xlconstant,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_xlconstant_0_2 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_xlconstant_0_2 : entity is "xlconstant_v1_1_3_xlconstant,Vivado 2017.4";
end design_1_xlconstant_0_2;

architecture STRUCTURE of design_1_xlconstant_0_2 is
  signal \<const1>\ : STD_LOGIC;
begin
  dout(0) <= \<const1>\;
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
end STRUCTURE;
