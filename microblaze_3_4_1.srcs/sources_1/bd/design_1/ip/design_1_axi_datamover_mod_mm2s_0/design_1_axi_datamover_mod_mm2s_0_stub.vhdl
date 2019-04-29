-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Thu Jun 21 23:44:02 2018
-- Host        : RIEMANN running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top design_1_axi_datamover_mod_mm2s_0 -prefix
--               design_1_axi_datamover_mod_mm2s_0_ design_1_axi_datamover_mod_mm2s_0_stub.vhdl
-- Design      : design_1_axi_datamover_mod_mm2s_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_axi_datamover_mod_mm2s_0 is
  Port ( 
    m_axi_mm2s_aclk : in STD_LOGIC;
    m_axi_mm2s_aresetn : in STD_LOGIC;
    mm2s_err : out STD_LOGIC;
    m_axis_mm2s_cmdsts_aclk : in STD_LOGIC;
    m_axis_mm2s_cmdsts_aresetn : in STD_LOGIC;
    s_axis_mm2s_cmd_tvalid : in STD_LOGIC;
    s_axis_mm2s_cmd_tready : out STD_LOGIC;
    s_axis_mm2s_cmd_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
    m_axis_mm2s_sts_tvalid : out STD_LOGIC;
    m_axis_mm2s_sts_tready : in STD_LOGIC;
    m_axis_mm2s_sts_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_mm2s_sts_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_mm2s_sts_tlast : out STD_LOGIC;
    m_axi_mm2s_arid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_mm2s_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_mm2s_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_aruser : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_mm2s_arvalid : out STD_LOGIC;
    m_axi_mm2s_arready : in STD_LOGIC;
    m_axi_mm2s_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_mm2s_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_mm2s_rlast : in STD_LOGIC;
    m_axi_mm2s_rvalid : in STD_LOGIC;
    m_axi_mm2s_rready : out STD_LOGIC;
    m_axis_mm2s_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_mm2s_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_mm2s_tlast : out STD_LOGIC;
    m_axis_mm2s_tvalid : out STD_LOGIC;
    m_axis_mm2s_tready : in STD_LOGIC
  );

end design_1_axi_datamover_mod_mm2s_0;

architecture stub of design_1_axi_datamover_mod_mm2s_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "m_axi_mm2s_aclk,m_axi_mm2s_aresetn,mm2s_err,m_axis_mm2s_cmdsts_aclk,m_axis_mm2s_cmdsts_aresetn,s_axis_mm2s_cmd_tvalid,s_axis_mm2s_cmd_tready,s_axis_mm2s_cmd_tdata[71:0],m_axis_mm2s_sts_tvalid,m_axis_mm2s_sts_tready,m_axis_mm2s_sts_tdata[7:0],m_axis_mm2s_sts_tkeep[0:0],m_axis_mm2s_sts_tlast,m_axi_mm2s_arid[3:0],m_axi_mm2s_araddr[31:0],m_axi_mm2s_arlen[7:0],m_axi_mm2s_arsize[2:0],m_axi_mm2s_arburst[1:0],m_axi_mm2s_arprot[2:0],m_axi_mm2s_arcache[3:0],m_axi_mm2s_aruser[3:0],m_axi_mm2s_arvalid,m_axi_mm2s_arready,m_axi_mm2s_rdata[31:0],m_axi_mm2s_rresp[1:0],m_axi_mm2s_rlast,m_axi_mm2s_rvalid,m_axi_mm2s_rready,m_axis_mm2s_tdata[31:0],m_axis_mm2s_tkeep[3:0],m_axis_mm2s_tlast,m_axis_mm2s_tvalid,m_axis_mm2s_tready";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "axi_datamover,Vivado 2017.4";
begin
end;