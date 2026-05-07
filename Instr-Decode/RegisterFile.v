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
reg [31:0] gen_purpose_reg [0:31]; // the general purpose registers of width 32 bits depth 32
integer j;
initial begin
    for (j = 0; j < 32; j = j + 1)
        gen_purpose_reg[j] = 32'h00000000;
end

always @(*) begin
    if(!rst) begin 
        RegFile_readData1 <= 0;
        RegFile_readData2 <= 0;
    end
    else if (RegWrite)
        gen_purpose_reg[writeReg] <= writeData;
//    else begin
        RegFile_readData1 <= gen_purpose_reg[readReg1];
        RegFile_readData2 <= gen_purpose_reg[readReg2];
//    end
end

endmodule
