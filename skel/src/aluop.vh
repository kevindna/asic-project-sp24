/**
 * List of ALU operations.
*/


`include "Opcode.vh"

`ifndef ALUOP
`define ALUOP

`define ALU_ADD     {1'b0, `FNC_ADD_SUB}
`define ALU_SUB     {1'b1, `FNC_ADD_SUB}
`define ALU_AND     {1'b0, `FNC_AND}
`define ALU_OR      {1'b0, `FNC_OR}
`define ALU_XOR     {1'b0, `FNC_XOR}
`define ALU_SLT     {1'b0, `FNC_SLT}
`define ALU_SLTU    {1'b0, `FNC_SLTU}
`define ALU_SLL     {1'b0, `FNC_SLL}
`define ALU_SRA     {1'b1, `FNC_SRL_SRA}
`define ALU_SRL     {1'b0, `FNC_SRL_SRA}
`define ALU_COPY_B  4'hE
`define ALU_XXX     4'hF

`endif //ALUOP
