`timescale 1ns / 1ps

module InstructionDecode(
    input clk, rst, RegWrite,
    input [31:0] IFID_instruction,
    input [31:0] IFID_NPC,
    input [4:0] MemWBLatch_WriteReg,
    input [31:0] WBMux_WriteData,
    
    output [1:0] InstructionDecode_WB,
    output [2:0] InstructionDecode_M,
    output [1:0] InstructionDecode_ALUOp,
    output InstructionDecode_ALUSrc,
    output InstructionDecode_RegDst,
    output InstructionDecode_NPC,
    output [31:0] InstructionDecode_ReadData1,
    output [31:0] InstructionDecode_ReadData2,
    output [31:0] InstructionDecode_SignExtend,
    output [4:0] InstructionDecode_Instr_2016,
    output [4:0] InstructionDecode_Instr_1511
);

wire [1:0] control_WB, control_ALUOp;
wire [2:0] control_M;
wire ALUSrc, RegDst;

Control c0(
    .controlInput(IFID_instruction[31:26]), //opcode
    .control_WB(control_WB), .control_ALUOp(control_ALUOp),
    .control_M(control_M),
    .ALUSrc(ALUSrc), .RegDst(RegDst)
);

wire [31:0] signExtOut;

SignExtend se0(
    .signExtIn(IFID_instruction[15:0]),
    .signExtOut(signExtOut)
);

wire [31:0] RegFile_readData1, RegFile_readData2;

RegisterFile rf0(
    .readReg1(IFID_instruction[25:21]), 
    .readReg2(IFID_instruction[20:16]), 
    .writeReg(MemWBLatch_WriteReg),
    .writeData(WBMux_WriteData),
    .RegWrite(RegWrite), 
    .clk(clk), 
    .rst(rst),
    
    .RegFile_readData1(RegFile_readData1), 
    .RegFile_readData2(RegFile_readData2)
);


ID_EX_Latch latch1(

//Input:
    .WB(control_WB),
    .M(control_M),
    .ALUOp(control_ALUOp),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .IFID_Fetch_Latch_NPC(IFID_NPC),
    .ReadData1(RegFile_readData1),
    .ReadData2(RegFile_readData2),
    .SignExtend(signExtOut),
    .Instr_2016(IFID_instruction[20:16]),
    .Instr_1511(IFID_instruction[15:11]),
    .clk(clk),
    .rst(rst),

//Output:
    .IDEX_Latch_WB(InstructionDecode_WB),
    .IDEX_Latch_M(InstructionDecode_M),
    .IDEX_Latch_ALUOp(InstructionDecode_ALUOp),
    .IDEX_Latch_ALUSrc(InstructionDecode_ALUSrc),
    .IDEX_Latch_RegDst(InstructionDecode_RegDst),
    .IDEX_Latch_NPC(InstructionDecode_NPC),
    .IDEX_Latch_ReadData1(InstructionDecode_ReadData1),
    .IDEX_Latch_ReadData2(InstructionDecode_ReadData2),
    .IDEX_Latch_SignExtend(InstructionDecode_SignExtend),
    .IDEX_Latch_Instr_2016(InstructionDecode_Instr_2016),
    .IDEX_Latch_Instr_1511(InstructionDecode_Instr_1511)
);

endmodule