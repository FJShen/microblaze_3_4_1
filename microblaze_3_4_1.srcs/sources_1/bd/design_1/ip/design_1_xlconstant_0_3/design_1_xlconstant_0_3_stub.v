// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue May 29 00:18:02 2018
// Host        : RIEMANN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/HUST_study/FPGA_based_DSP/nexys_microblaze_with_mig_with_tft/nexys_microblaze_with_mig_with_tft.srcs/sources_1/bd/design_1/ip/design_1_xlconstant_0_3/design_1_xlconstant_0_3_stub.v
// Design      : design_1_xlconstant_0_3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconstant_v1_1_3_xlconstant,Vivado 2017.4" *)
module design_1_xlconstant_0_3(dout)
/* synthesis syn_black_box black_box_pad_pin="dout[71:0]" */;
  output [71:0]dout;
endmodule