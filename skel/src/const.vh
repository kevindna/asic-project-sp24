`ifndef CONST
`define CONST

`define MEM_DATA_BITS 128
`define MEM_TAG_BITS 5
`define MEM_ADDR_BITS 28
`define MEM_DATA_CYCLES 4

`define CPU_ADDR_BITS 32
`define CPU_INST_BITS 32
`define CPU_DATA_BITS 32
`define CPU_OP_BITS 4
`define CPU_WMASK_BITS 16
`define CPU_TAG_BITS 15

// PC address on reset
`define PC_RESET 32'h00002000

// The NOP instruction
`define INSTR_NOP {12'd0, 5'd0, `FNC_ADD_SUB, 5'd0, `OPC_ARI_ITYPE}

`define CSR_TOHOST 12'h51E
`define CSR_HARTID 12'h50B
`define CSR_STATUS 12'h50A

////// KA ADDED

`define INPUT_DELAY (`CLOCK_PERIOD / 5)

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



`endif //CONST
