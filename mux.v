`timescale 1ns / 1ps

module mux #(parameter WIDTH_inp =  32)(
    input sel,
    input [(WIDTH_inp-1):0] in_1,
    input [(WIDTH_inp-1):0] in_2,
    output [(WIDTH_inp-1):0] outp
    );
    
    assign outp = sel? in_2:in_1;
    
endmodule