`timescale 1ns / 1ps

module adder(
    input [31:0] inp_1,
    input [31:0] inp_2,
    output [31:0] Add_Result
    );
    
    assign Add_Result = inp_1 + inp_2;
    
endmodule