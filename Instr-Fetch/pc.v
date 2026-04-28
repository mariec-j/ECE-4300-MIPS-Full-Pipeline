`timescale 1ns / 1ps

module pc(
    input clk, rst,
    input [31:0] pc_in,
    output [31:0] pc_out
);
reg [31:0] pc_temp;

always @(posedge clk or negedge rst) begin
    if (!rst) pc_temp <= 32'h00000000;
    else pc_temp <= pc_in;
end

assign pc_out = pc_temp;
// passes input as output for every clock cycle 

endmodule
