`timescale 1ns / 1ps

module SignExtend(
    input [15:0] signExtIn,
    output [31:0] signExtOut
);
  
    assign signExtOut = {{16{signExtIn[15]}}, signExtIn};
    
endmodule
