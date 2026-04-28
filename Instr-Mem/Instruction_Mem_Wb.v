`timescale 1ns / 1ps

module Instruction_Mem(
// - - - - - - Inputs - - - - - -
    input [1:0] WB,
    input M_ctlout,
    input Zero,
    input MemWrite,
    input [31:0] ALU_Result,
    input [31:0] ReadData2_ex_mem,
    input MemRead,
    input [4:0] muxOut_5bit,
    input clk,
    input rst,
// - - - - - - Outputs - - - - - -
    output RegWrite,
    output MemtoReg,
    output [31:0] ReadData,
    output [31:0] Mem_ALU_Result,
    output [4:0] MemWriteReg,
    output PCSrc
    );
    
// determines Branch
and_gate #(.WIDTH(1)) and04 (
    .in0(M_ctlout),
    .in1(Zero),
    .out(PCSrc)    
    );

wire [31:0] Mem_ReadData_out;
Data_Mem datamem01 ( 
    .MemWrite(MemWrite),
    .Addr(ALU_Result),
    .WriteData(ReadData2_ex_mem),
    .MemRead(MemRead),
    .clk(clk),
    .rst(rst),
    .DataMem_ReadData(Mem_ReadData_out)

    );
    
Mem_Wb_Latch M_W_Latch(
// - - - - - - Inputs - - - - - -
    .WB(WB),
    .ALU_Result(ALU_Result),
    .ReadData(Mem_ReadData_out),
    .clk(clk), .rst(rst),
    .muxOut_5bit(muxOut_5bit),
// - - - - - - Outputs - - - - - -
    .Mem_Wb_Latch_RegWrite(RegWrite),
    .Mem_Wb_Latch_MemtoReg(MemtoReg),
    .Mem_Wb_Latch_ReadData(ReadData),
    .Mem_Wb_Latch_Mem_ALU_Result(Mem_ALU_Result),
    .Mem_Wb_Latch_MemWriteReg(MemWriteReg)
    );
    
endmodule
