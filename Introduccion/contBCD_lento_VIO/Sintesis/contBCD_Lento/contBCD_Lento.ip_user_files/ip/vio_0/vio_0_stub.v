// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Sun Apr  6 18:43:53 2025
// Host        : DESKTOP-NG7OJN9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Juanma/Documents/CESE/CLP/TPs_CLP/Introduccion/contBCD_lento_VIO/Sintesis/contBCD_Lento/contBCD_Lento.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.1" *)
module vio_0(clk, probe_in0, probe_in1, probe_out0, 
  probe_out1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[3:0],probe_in1[0:0],probe_out0[0:0],probe_out1[0:0]" */;
  input clk;
  input [3:0]probe_in0;
  input [0:0]probe_in1;
  output [0:0]probe_out0;
  output [0:0]probe_out1;
endmodule
