`include "const.vh"

module execute (
  input clk,
  input rst,
  // Opcode
  input [3:0] aluopcode,
  input [6:0] opcode,
  // Operands
  input [`CPU_ADDR_BITS-1:0] pc,
  input [`DWIDTH-1:0] rs1data,
  input [`DWIDTH-1:0] rs2data,
  input [`DWIDTH-1:0] imm,
  // ALU
  output [`DWIDTH-1:0] alu_out,
  // Memory 
  output [`DWIDTH-1:0] mem_addr,
  output [`DWIDTH-1:0] mem_data);


  /*************************************************/
  // Signals
  /*************************************************/
  wire [`DWIDTH-1:0] alu_op0;  
  wire [`DWIDTH-1:0] alu_op1;  
  wire alu_op0_sel;  
  wire alu_op1_sel;

  /*************************************************/
  // Instantiations
  /*************************************************/
  // ALU
  alu alu0(
    .aluop(aluopcode),
    .op1(alu_op0),
    .op2(alu_op1),
    .out(alu_out));

  /*************************************************/
  // Signal Assignments
  /*************************************************/
  assign alu_op0 = (alu_op0_sel == 1'b1) ? pc  : rs1data;
  assign alu_op1 = (alu_op1_sel == 1'b1) ? imm : rs2data;
  assign alu_op0_sel = (opcode == `OPC_AUIPC) || (opcode == `OPC_JAL) || (opcode == `OPC_JALR) ? 1'b1 : 1'b0;
  assign alu_op1_sel = ((opcode == `OPC_LOAD) || (opcode == `OPC_ARI_ITYPE) || (opcode == `OPC_AUIPC) || (opcode == `OPC_LUI) || (opcode == `OPC_JAL) || (opcode == `OPC_JALR))? 1'b1 : 1'b0;

  // TODO: Placeholder
  assign mem_addr = 'b0;
  assign mem_data = 'b0;

endmodule : execute
