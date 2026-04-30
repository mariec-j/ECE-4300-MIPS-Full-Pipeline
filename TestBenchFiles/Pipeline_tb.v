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

        #500 $finish;
    end
    
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Pipeline_tb);
end
endmodule