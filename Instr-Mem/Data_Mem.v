`timescale 1ns / 1ps
/*Instantiates and serves as the data memory.
- If memread is true, then read_data is re-assigned
as the value in current address. 

- If memwrite is true, then read_data is unaltered,
and instead, the value in the current address is
changed to rdata2out. 
*/

module Data_Mem(
    input MemWrite,
    input [31:0] Addr,
    input [31:0] WriteData,
    input MemRead,
    input clk,
    input rst,
    output reg [31:0] DataMem_ReadData
    );

reg [31:0] DMEM [0:128];
integer i;

initial begin
    DataMem_ReadData <= 0;
    $readmemb("data.txt",DMEM);
    for(i = 0; i < 8; i = i + 1)
    $display("\tDMEM[%0d] = %0b", i, DMEM[i]);
end

always @(posedge clk or negedge rst) begin
    if(!rst)
        DataMem_ReadData <= 0; // ReadData is null/0
    else begin
        if (MemRead)
            DataMem_ReadData <= DMEM[Addr]; // ReadData reads DMEM
        if(MemWrite)
            DMEM[Addr] <= WriteData; // put readdat2 to DMEM[ALU_Result]
    end
end

endmodule
