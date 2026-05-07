`timescale 1ns / 1ps

module Pipeline_tb();

    reg clk;
    reg rst;

    MIPS_Pipeline uut (
        .clk(clk),
        .rst(rst)
    );
    
    integer i;

    initial begin
        $readmemb("data.txt", uut.u_Instruction_Mem.datamem01.DMEM);
        for(i = 0; i < 8; i = i + 1)
        $display("\tDMEM[%0d] = %0b", i, uut.u_Instruction_Mem.datamem01.DMEM[i]);
    end
    
    initial begin
        $readmemb("instr.mem", uut.u_instrFetch.instrMem0.mem);
            for(i = 0; i < 25; i = i + 1)
                $display("\tmem[%0d] = %0b", i, uut.u_instrFetch.instrMem0.mem[i]); 
    end
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        rst = 0;
        #10 rst = 1;

       #300 $finish;
    end
    
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Pipeline_tb);
end
endmodule