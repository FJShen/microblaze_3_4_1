-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu Jun 21 23:54:41 2018
-- Host        : RIEMANN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/HUST_study/FPGA_based_DSP/microblaze_3_4_1/microblaze_3_4_1.srcs/sources_1/bd/design_1/ip/design_1_xlslice_real_0/design_1_xlslice_real_0_sim_netlist.vhdl
-- Design      : design_1_xlslice_real_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_xlslice_real_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_xlslice_real_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_xlslice_real_0 : entity is "design_1_xlslice_real_0,xlslice_v1_0_1_xlslice,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_xlslice_real_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_xlslice_real_0 : entity is "xlslice_v1_0_1_xlslice,Vivado 2017.4";
end design_1_xlslice_real_0;

architecture STRUCTURE of design_1_xlslice_real_0 is
  signal \^din\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  Dout(15 downto 0) <= \^din\(15 downto 0);
  \^din\(15 downto 0) <= Din(15 downto 0);
end STRUCTURE;
