`timescale 1ns / 1ps

module incrementer(
    input [31:0] PC_in,
    output [31:0] PC_out
    );
// Add + 1 to PC_in and output it
assign PC_out = PC_in + 3'b001;
    
endmodule
