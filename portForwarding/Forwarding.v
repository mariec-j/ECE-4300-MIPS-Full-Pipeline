`timescale 1ns / 1ps
module Forwarding(
////INPUTS/////
input [4:0] ID_EX_Rs,        // rs of current instruction
input [4:0] ID_EX_Rt,        // rt of current instruction
input [4:0] EX_MEM_RegisterRd, // destination reg of instruction in MEM
input [4:0] MEM_WB_RegisterRd, // destination reg of instruction in WB
input        EX_MEM_RegWrite,   // is MEM stage writing?
input        MEM_WB_RegWrite    // is WB stage writing?

////OUTPUTS/////
output reg [1:0] ForwardA,
output reg [1:0] ForwardB
);

always @(*) begin
    // ForwardA
    if (EX_MEM_RegWrite && EX_MEM_RegisterRd != 0 
        && EX_MEM_RegisterRd == ID_EX_Rs)
        ForwardA = 2'b10;  // forward from EX/MEM
    else if (MEM_WB_RegWrite && MEM_WB_RegisterRd != 0 
        && MEM_WB_RegisterRd == ID_EX_Rs)
        ForwardA = 2'b01;  // forward from MEM/WB
    else
        ForwardA = 2'b00;  // use register file

    // ForwardB — same logic but checks Rt
    if (EX_MEM_RegWrite && EX_MEM_RegisterRd != 0 
        && EX_MEM_RegisterRd == ID_EX_Rt)
        ForwardB = 2'b10;
    else if (MEM_WB_RegWrite && MEM_WB_RegisterRd != 0 
        && MEM_WB_RegisterRd == ID_EX_Rt)
        ForwardB = 2'b01;
    else
        ForwardB = 2'b00;
end