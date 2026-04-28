`timescale 1ns / 1ps

module and_gate #(parameter WIDTH = 1) (
    input [(WIDTH-1):0] in0,
    input [(WIDTH-1):0] in1,
    output [(WIDTH-1):0] out
    );

   assign out =  in0 & in1;
    
endmodule
