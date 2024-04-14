`ifndef _riscv_cpu_vh_
`define _riscv_cpu_vh_

  `define DWIDTH      32  // Data width
  `define INSTR_WIDTH 32  // INSTR_WIDTH-bit processor

  /******************************/
  // OPCODES
  /******************************/
  `define R_TYPE_OPCODE0 'h33
  `define R_TYPE_OPCODE1 'h3B
  `define I_TYPE_OPCODE0 'h03
  `define I_TYPE_OPCODE1 'h0F
  `define I_TYPE_OPCODE2 'h13
  `define I_TYPE_OPCODE3 'h1B
  `define I_TYPE_OPCODE4 'h73
  `define S_TYPE_OPCODE  'h23
  `define B_TYPE_OPCODE  'h63
  `define U_TYPE_OPCODE  'h37
  `define J_TYPE_OPCODE  'H67

`endif //_riscv_cpu_vh_