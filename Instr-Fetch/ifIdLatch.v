`timescale 1ns / 1ps

module ifIdLatch(
    input [31:0] addr, data,
    input clk, rst,
    output [31:0] addr_out, data_out
);

reg [31:0] tempAddr, tempData;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        tempAddr <= 0;
        tempData <= 0;
    end 
    else begin
        tempAddr <= addr;
        tempData <= data;
    end
end

assign addr_out = tempAddr;
assign data_out = tempData;

endmodule
