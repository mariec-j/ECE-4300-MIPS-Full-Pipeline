`timescale 1ns / 1ps

module instrMem(
    input clk,
    input rst,
    input [31:0] addr,
    output [31:0] data
);

reg [31:0] mem [0:39];
integer i;
initial begin
    for(i = 0; i < 32; i = i+1) mem[i] = 0;  
end

reg [31:0] tempDat;

always @(posedge clk or negedge rst) begin
    if(!rst) tempDat <= 32'h00000000;
    else tempDat <= mem[addr];
end

assign data = tempDat;

//assign data = mem[addr];

endmodule
