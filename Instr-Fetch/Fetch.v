`timescale 1ns / 1ps

module instrFetch (
    input clk, rst, ex_mem_pc_src, //ex_mem_pc_src is what does mux selection
    input [31:0] ex_mem_npc, //also from outside Fetch & where it jumps to if sel=1 
    output [31:0] if_id_instr, if_id_npc
);
wire [31:0] mux_outp, incr_outp, instrMem_outp, pc_outp;

pc pc0(
    .clk(clk), .rst(rst),
    .pc_in(mux_outp),
    .pc_out(pc_outp)
);

incrementer inc0(
    .PC_in(pc_outp),
    .PC_out(incr_outp)
);

mux m0(
    .a_true(ex_mem_npc),
    .b_false(incr_outp),
    .y(mux_outp),
    .sel(ex_mem_pc_src)
);

mux #(.WIDTH_inp(32)) m0_fetch(
    .sel(ex_mem_pc_src),
    .in_1(incr_outp),
    .in_2(ex_mem_npc),
    .outp(mux_outp)
);

instrMem instrMem0(
    .clk(clk),
    .rst(rst),
    .addr(pc_outp),
    .data(instrMem_outp)
);

ifIdLatch ifIdLatch0(
    .addr(incr_outp), 
    .data(instrMem_outp),
    .clk(clk), 
    .rst(rst),
    .addr_out(if_id_npc), 
    .data_out(if_id_instr)
);


endmodule