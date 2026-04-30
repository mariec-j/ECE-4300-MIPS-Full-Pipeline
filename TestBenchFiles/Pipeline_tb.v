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
        $readmemb("data.txt", uut.u_InstructionDecode.rf0.gen_purpose_reg);
        $readmemb("instr.mem", uut.u_instrFetch.instrMem0.mem);
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        rst = 1;
        #10 rst = 0;

        #1000 $finish;
    end
    
    
endmodule