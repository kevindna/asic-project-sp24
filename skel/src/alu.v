// Module: ALU.v
// Desc:   32-bit ALU for the RISC-V Processor
// Inputs: 
//    op1: 32-bit value
//    op2: 32-bit value
//    ALUop: Selects the ALU's operation 
//            
// Outputs:
//    Out: The chosen function mapped to op1 and op2.

`include "aluop.vh"
module alu (
  input [3:0] aluop,
  input [`DWIDTH-1:0] op1,
  input [`DWIDTH-1:0] op2 ,
  output reg [`DWIDTH-1:0] out
);
  always @(*) begin : proc_alu
    case(aluop)
      `ALU_ADD:    out = op1 + op2;
      `ALU_SUB:    out = op1 - op2;
      `ALU_AND:    out = op1 & op2;
      `ALU_OR :    out = op1 | op2;
      `ALU_XOR:    out = op1 ^ op2;
      `ALU_SLT:    out = $signed(op1) < $signed(op2) ;
      `ALU_SLTU:   out = $unsigned(op1) < $unsigned(op2);
      `ALU_SLL:    out = op1 << op2[5:0];
      `ALU_SRA:    out = $signed(op1) >>> op2[5:0];
      `ALU_SRL:    out = $unsigned(op1) >> op2[5:0];
      `ALU_COPY_B: out = op2;
      default:     out = 'X; // should never be reached, will be optimzed by synthesis tool
    endcase // ALUop
  end

endmodule
