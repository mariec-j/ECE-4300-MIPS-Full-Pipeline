`timescale 1ns / 1ps


module ID_EX_Latch(

//Input:
input [1:0] WB,
input [2:0] M,
input [1:0] ALUOp,
input ALUSrc,
input RegDst,
input [31:0] IFID_Fetch_Latch_NPC,
input [31:0] ReadData1,
input [31:0] ReadData2,
input [31:0] SignExtend,
input [4:0] Instr_2016,
input [4:0] Instr_1511,
input clk,
input rst,

//Output:
output reg [1:0] IDEX_Latch_WB,
output reg [2:0] IDEX_Latch_M,
output reg [1:0] IDEX_Latch_ALUOp,
output reg IDEX_Latch_ALUSrc,
output reg IDEX_Latch_RegDst,
output reg IDEX_Latch_NPC,
output reg [31:0] IDEX_Latch_ReadData1,
output reg [31:0] IDEX_Latch_ReadData2,
output reg [31:0] IDEX_Latch_SignExtend,
output reg [4:0] IDEX_Latch_Instr_2016,
output reg [4:0] IDEX_Latch_Instr_1511
);


always @(posedge clk or negedge rst)begin
    if(!rst)begin
        IDEX_Latch_WB <= 2'b0;
        IDEX_Latch_M <= 3'b0;
        IDEX_Latch_ALUOp <= 2'b0;
        IDEX_Latch_ALUSrc <= 0;
        IDEX_Latch_RegDst <= 0;
        IDEX_Latch_NPC <= 0;
        IDEX_Latch_ReadData1<= 32'b0;
        IDEX_Latch_ReadData2 <= 32'b0;
        IDEX_Latch_SignExtend <= 32'b0;
        IDEX_Latch_Instr_2016 <= 5'b0;
        IDEX_Latch_Instr_1511 <= 5'b0;
    end

    else begin
        IDEX_Latch_WB <= WB;
        IDEX_Latch_M <= M;
        IDEX_Latch_ALUOp <= ALUOp;
        IDEX_Latch_ALUSrc <= ALUSrc;
        IDEX_Latch_RegDst <= RegDst;
        IDEX_Latch_NPC <= IFID_Fetch_Latch_NPC;
        IDEX_Latch_ReadData1<= ReadData1;
        IDEX_Latch_ReadData2 <= ReadData2;
        IDEX_Latch_SignExtend <= SignExtend;
        IDEX_Latch_Instr_2016 <= Instr_2016;
        IDEX_Latch_Instr_1511 <= Instr_1511;
    end
end

endmodule
