`timescale 1ns / 1ps

module Instr_WB(
    input MemtoReg,
    input [31:0] ReadData,
    input [31:0] Mem_ALU_Result,
    output [31:0] WriteData
    );
    
mux #(.WIDTH_inp(32)) wb_mux (
    .sel(MemtoReg),
    .in_1(Mem_ALU_Result),
    .in_2(ReadData),
    .outp(WriteData)
    );
    
endmodule
