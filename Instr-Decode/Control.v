`timescale 1ns / 1ps

module Control(
    input [5:0] controlInput, //opcode
    output reg [1:0] control_WB, control_ALUOp,
    output reg [2:0] control_M,
    output reg ALUSrc, RegDst
);

/* instruction type --> opcode number
R-format --> 5'b00000
lw --> 5'b100011
sw --> 5'101011
beq --> 5'b00010
*/

always@(*) begin
    case (controlInput)
        6'b000000: begin // R-type
            RegDst       = 1;
            ALUSrc       = 0;
            control_WB   = 2'b10; // RegWrite=1, MemtoReg=0
            control_M    = 3'b000;
            control_ALUOp = 2'b10;
        end

        6'b100011: begin // lw
            RegDst       = 0;
            ALUSrc       = 1;
            control_WB   = 2'b11; // RegWrite=1, MemtoReg=1
            control_M    = 3'b010; // MemRead=1
            control_ALUOp = 2'b00;
        end

        6'b101011: begin // sw
            RegDst       = 1'bX;
            ALUSrc       = 1;
            control_WB   = 2'b00; // RegWrite = 0, MemtoReg = 0
            control_M    = 3'b001; // MemWrite=1
            control_ALUOp = 2'b00;
        end

        6'b000100: begin // beq
            RegDst       = 1'bX;
            ALUSrc       = 0;
            control_WB   = 2'b00;
            control_M    = 3'b100; // Branch=1
            control_ALUOp = 2'b01;
        end
        default: begin
            RegDst       = 0;
            ALUSrc       = 0;
            control_WB   = 2'b00; // RegWrite=1, MemtoReg=0
            control_M    = 3'b000;
            control_ALUOp = 2'b00;
        end

    endcase
end

endmodule
