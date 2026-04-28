`timescale 1ns / 1ps

module ALU_Control(
    input [1:0] ALU_Op,
    input [5:0] SignExtend,
    output reg [2:0] ALU_Control_outp
    );
    
    always @(*) begin
        case (ALU_Op)
            2'b00: ALU_Control_outp = 3'b010; // add
            
            2'b01: ALU_Control_outp = 3'b110; // sub
            
            2'b10: begin // R-type
                case (SignExtend)
                    6'b100000: ALU_Control_outp = 3'b010; // add
                    6'b100010: ALU_Control_outp = 3'b110; // sub
                    6'b100100: ALU_Control_outp = 3'b000; // AND
                    6'b100101: ALU_Control_outp = 3'b001; // OR
                    6'b101010: ALU_Control_outp = 3'b111; // set on less than
                    default: ALU_Control_outp = 3'b010; // default to add
                endcase
            end
            
            default: ALU_Control_outp = 3'b010; // default to add
        endcase
    end
    
endmodule
