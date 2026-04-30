`timescale 1ns / 1ps

/*
32 general purpose registers
If regwrite == 1, then write the "writedata" value into the "write reg" location
Else read the data from "read reg1" and "read reg2" as their respective "read data"
*/
module RegisterFile(
    input [4:0] readReg1, readReg2, writeReg,
    input [31:0] writeData,
    input RegWrite, clk, rst,
    
    output reg [31:0] RegFile_readData1, RegFile_readData2
);
reg [31:0] gen_purpose_reg [31:0]; // the general purpose registers of width 32 bits depth 32
initial begin
gen_purpose_reg[0] = 32'h00000000;
gen_purpose_reg[1] = 32'h00000000;
gen_purpose_reg[2] = 32'h00000000;
gen_purpose_reg[3] = 32'h00000000;
gen_purpose_reg[4] = 32'h00000000;
gen_purpose_reg[5] = 32'h00000000;
gen_purpose_reg[6] = 32'h00000000;
gen_purpose_reg[7] = 32'h00000000;
gen_purpose_reg[8] = 32'h00000000;
gen_purpose_reg[9] = 32'h00000000;
gen_purpose_reg[10] = 32'h00000000;
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin 
        RegFile_readData1 = 0;
        RegFile_readData2 = 0;
    end
    if (RegWrite)
        gen_purpose_reg[writeReg] = writeData;
    else begin
        RegFile_readData1 = gen_purpose_reg[readReg1];
        RegFile_readData2 = gen_purpose_reg[readReg2];
    end
end

endmodule
