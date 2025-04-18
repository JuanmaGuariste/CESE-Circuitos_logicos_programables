// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Thu Apr 17 00:49:46 2025
// Host        : DESKTOP-NG7OJN9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Juanma/Documents/CESE/CLP/TPs_CLP/TP_Final/FIR_Filter_VIO/Sintesis/FIR_Filter.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2018.1" *)
module ila_0(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[11:0],probe1[11:0]" */;
  input clk;
  input [11:0]probe0;
  input [11:0]probe1;
endmodule
