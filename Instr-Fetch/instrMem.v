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
    $readmemb("instr.mem", mem);
        for(i = 0; i < 25; i = i + 1)
            $display("\tmem[%0d] = %0b", i, mem[i]); 
end

reg [31:0] tempDat;

always @(posedge clk or negedge rst) begin
    if(!rst) tempDat <= 32'h00000000;
    else tempDat <= mem[addr];
end

assign data = tempDat;

//assign data = mem[addr];

endmodule
