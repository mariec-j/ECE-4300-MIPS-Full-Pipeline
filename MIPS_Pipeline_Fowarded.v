`timescale 1ns / 1ps

module MIPS_Pipeline_Forwarded (
input clk,
input rst    
); 

//Fetch.v wires
wire [31:0] if_id_instr, if_id_npc;

//InstructionDecode.v wires
wire [1:0]  InstructionDecode_WB;
wire [2:0]  InstructionDecode_M;
wire [1:0]  InstructionDecode_ALUOp;
wire        InstructionDecode_ALUSrc;
wire        InstructionDecode_RegDst;
wire [31:0] InstructionDecode_NPC;
wire [31:0] InstructionDecode_ReadData1;
wire [31:0] InstructionDecode_ReadData2;
wire [31:0] InstructionDecode_SignExtend;
wire [4:0]  InstructionDecode_Instr_2016;
wire [4:0]  InstructionDecode_Instr_1511;
    
//Instruction_Execute.v wires
wire [1:0]    IE_WB;
wire [2:0]    IE_Mem;
wire [31:0]   Add_Result;
wire          Zero;
wire [31:0]   ALU_Result;
wire [31:0]   ReadData2_ex_mem;
wire [4:0]    muxOut_5bit;

wire        w_Branch;
wire        w_MemRead;
wire        w_MemWrite;

//Instruction_Mem_Wb.v wires
wire        RegWrite;
wire        MemtoReg;
wire [31:0] ReadData;
wire [31:0] Mem_ALU_Result;
wire [4:0]  MemWriteReg;
wire        PCSrc;
wire        M_RegWrite;
wire [4:0]  M_MemWriteReg;

//Instruction_WB.v wires
wire [31:0] WriteData;

// - - - - - - Instruction Fetch
instrFetch u_instrFetch(
// Inputs - - - - - - - - - - - - -
    .clk           	(clk            ),
    .rst           	(rst            ),
    .ex_mem_pc_src 	(PCSrc          ),//input from Instruction_Mem_Wb.v
    .ex_mem_npc    	(Add_Result     ),//input from Instruction_Execute.v
// Outputs - - - - - - - - - - - - -
    .if_id_instr   	(if_id_instr    ),
    .if_id_npc     	(if_id_npc      )
);
reg [4:0] Rs;

always @(posedge clk) Rs <= if_id_instr[25:21];

// - - - - - - Instruction Decode
InstructionDecode u_InstructionDecode(
// Inputs - - - - - - - - - - - - -
    .clk                          	(clk                     ),
    .rst                          	(rst                     ),
    .RegWrite                     	(RegWrite                ),
    .IFID_instruction             	(if_id_instr             ),//fetch.v
    .IFID_NPC                     	(if_id_npc               ),//fetch.v
    .MemWBLatch_WriteReg          	(MemWriteReg             ),//instruction_Mem_Wb.v
    .WBMux_WriteData              	(WriteData               ),//instruction_Mem_Wb.v
// Outputs - - - - - - - - - - - - -
    .InstructionDecode_WB         	(InstructionDecode_WB          ),
    .InstructionDecode_M          	(InstructionDecode_M           ),
    .InstructionDecode_ALUOp      	(InstructionDecode_ALUOp       ),
    .InstructionDecode_ALUSrc     	(InstructionDecode_ALUSrc      ),
    .InstructionDecode_RegDst     	(InstructionDecode_RegDst      ),
    .InstructionDecode_NPC        	(InstructionDecode_NPC         ),
    .InstructionDecode_ReadData1  	(InstructionDecode_ReadData1   ),
    .InstructionDecode_ReadData2  	(InstructionDecode_ReadData2   ),
    .InstructionDecode_SignExtend 	(InstructionDecode_SignExtend  ),
    .InstructionDecode_Instr_2016 	(InstructionDecode_Instr_2016  ),
    .InstructionDecode_Instr_1511 	(InstructionDecode_Instr_1511  )
);

wire EX_MEM_RegWrite = IE_WB[1];

//  - - - - - - Instruction Execution
Instruction_Execute_Forwarded u_Instruction_Execute(
// Inputs - - - - - - - - - - - - -
    .NPC              	(InstructionDecode_NPC               ),
    .ReadData1        	(InstructionDecode_ReadData1         ),
    .ReadData2        	(InstructionDecode_ReadData2         ),
    .ALU_Src          	(InstructionDecode_ALUSrc            ),
    .SignExtend       	(InstructionDecode_SignExtend        ),
    .ALU_Op           	(InstructionDecode_ALUOp             ),
    .Instr_2016       	(InstructionDecode_Instr_2016        ),
    .Instr_1511       	(InstructionDecode_Instr_1511        ),
    .RegDst           	(InstructionDecode_RegDst            ),
    .WB               	(InstructionDecode_WB                ),
    .Mem              	(InstructionDecode_M                 ),
    .Rs                 (Rs                                 ), // rs from decode
    .EX_MEM_Rd          (muxOut_5bit                        ), // Rd in MEM stage
    .MEM_WB_Rd          (M_MemWriteReg                      ), // Rd in WB stage
    .EX_MEM_RegWrite    (EX_MEM_RegWrite                    ), // RegWrite from EX/MEM latch
    .MEM_WB_RegWrite    (RegWrite                           ), // RegWrite from MEM/WB latch
    .EX_MEM_value       (ALU_Result                         ), // ALU result in MEM stage
    .MEM_WB_value       (WriteData                          ), // write data in WB stage
    .clk              	(clk               ),
    .rst              	(rst               ),
// Outputs - - - - - - - - - - - - -
    .IE_WB            	(IE_WB             ),
    .IE_Mem           	(IE_Mem            ),
    .Add_Result       	(Add_Result        ),
    .Zero             	(Zero              ),
    .ALU_Result       	(ALU_Result        ),
    .ReadData2_ex_mem 	(ReadData2_ex_mem  ),
    .muxOut_5bit      	(muxOut_5bit       )
);

assign w_Branch   = IE_Mem[2];
assign w_MemRead  = IE_Mem[1];
assign w_MemWrite = IE_Mem[0];

//  - - - - - - Instruction Memory
Instruction_Mem u_Instruction_Mem(
// Inputs - - - - - - - - - - - - -
    .WB               	(IE_WB             ),
    .M_ctlout         	(w_Branch          ),
    .Zero             	(Zero              ),
    .MemWrite         	(w_MemWrite        ),
    .ALU_Result       	(ALU_Result        ),
    .ReadData2_ex_mem 	(ReadData2_ex_mem  ),
    .MemRead          	(w_MemRead         ),
    .M_muxOut_5bit      (muxOut_5bit       ),
    .clk              	(clk               ),
    .rst              	(rst               ),
// Outputs - - - - - - - - - - - - -
    .M_RegWrite         (M_RegWrite          ),
    .MemtoReg         	(MemtoReg          ),
    .ReadData         	(ReadData          ),
    .Mem_ALU_Result   	(Mem_ALU_Result    ),
    .M_MemWriteReg      (M_MemWriteReg       ),
    .PCSrc            	(PCSrc             )
);

//  - - - - - -  Instruction Write Back
Instr_WB u_Instr_WB(
    .MemtoReg       (MemtoReg),
    .ReadData       (ReadData),
    .M_RegWrite     (M_RegWrite),
    .M_MemWriteReg  (M_MemWriteReg),
    .Mem_ALU_Result (Mem_ALU_Result),
    .WriteData      (WriteData),
    .RegWrite       (RegWrite),
    .MemWriteReg    (MemWriteReg)
);
    
endmodule