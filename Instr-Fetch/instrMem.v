`timescale 1ns / 1ps

module instrMem(
    input clk,
    input rst,
    input [31:0] addr,
    output [31:0] data
);

reg [31:0] mem [0:39];

initial begin
    mem[36] = 32'h90000099;
    mem[32] = 32'h80000088;
    mem[28] = 32'h70000077;
    mem[24] = 32'h60000066;
    mem[20] = 32'h50000055;
    mem[16] = 32'h40000044;
    mem[12] = 32'h30000033;
    mem[8] = 32'h20000022;
    mem[4] = 32'h10000011;
    mem[0] = 32'hA00000AA;    
end

reg [31:0] tempDat;

always @(posedge clk or negedge rst) begin
    if(!rst) tempDat <= 32'h00000000;
    else tempDat <= mem[addr];
end

assign data = tempDat;

endmodule
