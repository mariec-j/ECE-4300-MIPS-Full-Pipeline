`timescale 1ns / 1ps

module Instr_WB(
    input MemtoReg,
    input [31:0] ReadData,
    input [31:0] Mem_ALU_Result,
    input M_RegWrite,
    input [4:0] M_MemWriteReg,
    output [31:0] WriteData,
    output RegWrite,
    output [4:0] MemWriteReg
    );
    
mux #(.WIDTH_inp(32)) wb_mux (
    .sel(MemtoReg),
    .in_1(Mem_ALU_Result),
    .in_2(ReadData),
    .outp(WriteData)
    );
    
assign RegWrite = M_RegWrite;
assign MemWriteReg = M_MemWriteReg;
    
endmodule
