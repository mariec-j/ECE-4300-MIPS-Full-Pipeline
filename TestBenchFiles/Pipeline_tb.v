`timescale 1ns / 1ps
module Pipeline_tb();

    reg clk;
    reg rst;

    MIPS_Pipeline uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        rst = 0;
        #10 rst = 1;

        #300 $finish;
    end
    
    
endmodule