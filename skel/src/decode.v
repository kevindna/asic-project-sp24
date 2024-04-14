`include "const.vh"
`include "Opcode.vh"
`include "aluop.vh"

module decode (
  input clk,  // Clock
  input rst,  // Asynchronous reset active low
  // Fetch Stage
  input [`CPU_ADDR_BITS-1:0] pc,
  input [`INSTR_WIDTH-1:0] instr,
  output stall,
  // Branch/Jump
  input  bpred,    // Prediction; 1 branch was predicted, 0 otherwise
  output kill,
  output reg br_j,        // Asserted means take the branch
  output wire jump_instr,   // Asserted means jump instruction
  output [`CPU_ADDR_BITS-1:0] cntrl_addr,  // Branch address
  // Execution Stage
  output funct7_sel,   // 1 indicates add/srl, otherwise sub/sra (opcode shared)
  // CSR
  output [`CPU_DATA_BITS-1:0] csr_out,
  //
  output [6:0] ex_opcode,
  output [4:0] ex_rd,
  output [`CPU_DATA_BITS-1:0] ex_rs1data,
  output [`CPU_DATA_BITS-1:0] ex_rs2data,
  output reg [3:0] alu_predecode,
  output [`DWIDTH-1:0] imm_gen,
  // Memory
  output mem_re,
  input mem_stall,
  output [3:0] mem_we,
  output [`CPU_ADDR_BITS-1:0] mem_addr,
  // Writeback
  input wb_we,
  input [4:0] wb_rd,
  output store, 
  output [1:0] wb_op_sel,
  input [`DWIDTH-1:0] wb_data);

  /*************************************************/
  // Signals
  /*************************************************/
  // Decode
  wire [6:0] opcode;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [4:0] rd;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [11:0] csr;
  // CSR
  reg [`DWIDTH-1:0] csr_51e;
  // Register File Access
  wire [`DWIDTH-1:0] rs1data;
  wire [`DWIDTH-1:0] rs2data;
  wire wb_we_int; 
  // Immediate generation
  reg [`DWIDTH-1:0] imm;
  wire [`DWIDTH-1:0] imm_ext;
  // Branch
  reg br_kill;   // Signal indicating a branch instruction so kill stage 1
  wire br_instr;  // Asserted if branch instruction
  wire beq;   // Branch equal, bne is negation
  wire bge;   // Branch greater or equal, blt is negation
  wire bgeu;  // Branch greater or equal UNSIGNED, blt is negation
  wire [`CPU_ADDR_BITS-1:0] branch_addr; // Address for branch or data memory
  // Jump
  // wire jump_instr; // Signal indicating a jump instruction
  reg j_kill;                         // Signal indication a jump instruction for kill stage 1 
  reg [`CPU_ADDR_BITS-1:0] jump_addr; // Address for branch or data memory
  // Stall
  reg data_dep;
  reg stall_dly;
  wire data_dep_check_rs1;
  wire data_dep_check_rs2;

  // CSR registers
  always @(posedge clk) begin : proc_csr
    if (rst == 1'b1) begin
			csr_51e <= 'b0;
    end else if ((opcode == `OPC_CSR) && (csr == `CSR_TOHOST)) begin 
      case(funct3)
        `FNC_RW:  csr_51e <= (stall != 1'b1) ? rs1data :csr_51e;
        `FNC_RWI: csr_51e <= {27'b0, rs1};
        default:  csr_51e <= csr_51e;// Case never hit
      endcase
    end else begin
			csr_51e <= csr_51e;
		end
  end

  // Register File
  async_2r1wram #(
    .DEPTH(32), 
    .WIDTH(`DWIDTH)) rf (
    .clk(clk),
    .rst(rst),
    // Read port 1
    .raddr0(rs1),
    .rdata0(rs1data),
    // Read port 2
    .raddr1(rs2),
    .rdata1(rs2data),
    // Write port 1
    .we(wb_we_int),
    .waddr0(wb_rd),
    .wdata(wb_data));


  // Immediate generation
  always @(*) begin : proc_imm_gen
    case (opcode)
      `OPC_ARI_RTYPE:             imm <= {{20{instr[31]}}, instr[31:20]};
      `OPC_STORE:                 imm <= {{20{instr[31]}}, instr[31:25], instr[11:7]};
      `OPC_BRANCH:                imm <= {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
      `OPC_JAL, `OPC_JALR:        imm <= {{12{instr[31]}}, instr[31], instr[18:12], instr[19], instr[30:20]};
      `OPC_LUI, `OPC_AUIPC:       imm <= {instr[31:12],12'b0};
      `OPC_ARI_ITYPE,`OPC_LOAD:   imm <= {{20{instr[31]}}, instr[31:20]};
      // `OPC_CSR :                  imm <= {20'b0, instr[31:20]};
      default:                    imm <= {{20{instr[31]}}, instr[31:20]};
    endcase
  end

  // Branch resolution
  always @(*) begin : proc_branch
    if (opcode == `OPC_BRANCH) begin
      case (funct3)
        `FNC_BEQ:   br_kill = beq;
        `FNC_BNE:   br_kill = ~beq;
        `FNC_BGE:   br_kill = bge;
        `FNC_BLT:   br_kill = ~bge;
        `FNC_BGEU:  br_kill = bgeu;
        `FNC_BLTU:  br_kill = ~bgeu;
        default:    br_kill = 1'b0;
      endcase
      br_kill = (bpred == 1'b1) ? br_kill : ~br_kill;  // Flip depending on prediction
      // branch = br_kill;
    end else begin
      br_kill = 1'b0;
    end
  end

  // Jumnp kill
  always @(*) begin : proc_jkill
    case (opcode)
      `OPC_JAL,`OPC_JALR: j_kill = 1'b1;
      default           : j_kill = 1'b0;  
    endcase
  end


  // Jump Addrr
  always @(*) begin : proc_jump
    case (opcode)
      `OPC_JAL  : jump_addr = pc + $signed(imm);
      `OPC_JALR : jump_addr = rs1data + $signed(imm);
      default   : jump_addr = 32'hA5A5_A5A5;  // Default case for easy debug
    endcase
  end

  // ALU Decode
  // Predecode the instruction ALU
  always @(*) begin : proc_alu_decode
    case (opcode)
      `OPC_ARI_RTYPE : begin
                        if (funct3 == `FNC_ADD_SUB) begin
                          alu_predecode <= (instr[30] == 1'b0)  ? `ALU_ADD : `ALU_SUB;
                        end else begin
                          alu_predecode <= {funct7[5], funct3};
                        end
                      end                 
      `OPC_ARI_ITYPE: alu_predecode <= {1'b0, funct3};          
      `OPC_LUI:       alu_predecode <= `ALU_COPY_B;
      `OPC_BRANCH:    alu_predecode <= `ALU_ADD;
      `OPC_JAL:       alu_predecode <= `ALU_ADD;
      `OPC_JALR:      alu_predecode <= `ALU_ADD;
      `OPC_AUIPC:     alu_predecode <= `ALU_ADD;
      `OPC_STORE:     alu_predecode <= `ALU_ADD;
      `OPC_LOAD:      alu_predecode <= `ALU_ADD;
      default :       alu_predecode <= `ALU_ADD;  // including OPC_CSR
    endcase
  end

  always @(*) begin : proc_data_dep
    case (opcode)
      `OPC_ARI_RTYPE, 
        `OPC_ARI_ITYPE, 
        `OPC_JALR, 
        `OPC_CSR: data_dep = (((rs1 == wb_rd) && data_dep_check_rs1) || 
                              ((rs2 == wb_rd) && data_dep_check_rs2)) && (wb_rd != 'b0) ? 1'b1 : 1'b0;
        `OPC_LOAD, `OPC_STORE: data_dep = mem_stall;
      default : data_dep = 1'b0;
    endcase
  end


  // In this microarchitecture, if an instruction has a register as both
  // the destination and a source AND must stall, a deadlock will occur
  // since the rd is passed to the third stage. However, any data dependencies
  always @(posedge clk) begin : proc_stall_dly
    if(rst) begin
      stall_dly <= 1'b0;
    end else begin
       stall_dly <= stall;
    end
  end
  // will be resolved after the third stage

  // TODO: BRANCH TAKEN LOGIC NEED TO PASS TO NEXT STAGE 

  /*************************************************/
  // Signal Assignments
  /*************************************************/
  
  // Flow Control
  assign kill =  ((br_kill == 1'b1) || (j_kill == 1'b1)) ? 1'b1 : 1'b0;
  assign cntrl_addr  = ((opcode == `OPC_JAL) || (opcode == `OPC_JALR)) ? jump_addr : (opcode == `OPC_BRANCH) ? branch_addr : 'b0;
  // Stall
  assign stall = data_dep & (~stall_dly == 1'b1 );
  assign data_dep_check_rs1 = ((opcode == `OPC_LUI) || (opcode == `OPC_AUIPC) || (opcode == `OPC_JAL)) ? 1'b0 : 1'b1;
  assign data_dep_check_rs2 = ((opcode == `OPC_ARI_ITYPE) || (opcode == `OPC_CSR) || (data_dep_check_rs1 == 1'b0))  ? 1'b0 : 1'b1;

  // Decode
  assign opcode     = instr[6:0];
  assign rs1        = instr[19:15];
  assign rs2        = instr[24:20];
  assign rd         = instr[11:7];
  assign funct3     = instr[14:12];
  assign funct7     = instr[31:25];
  assign funct7_sel = instr[30];  // Extract bit to distinguish between add/srl or sub/sra
  assign csr        = instr[31:20];

  // CSR
  assign csr_out = csr_51e;   // Pass CSR to top level

  // Execute 
  assign ex_opcode  = opcode;
  assign ex_rs1data = rs1data;
  assign ex_rs2data = rs2data;
  assign ex_rd      = rd;
  assign imm_gen    = imm;

  // Memory 
  assign mem_re   = (opcode == `OPC_LOAD) ? 1'b1 : 1'b0;
  assign mem_we   = (opcode == `OPC_STORE) ? 1'b1 : 1'b0;
  assign mem_addr = rs1data + imm; // COMBINE WITH BRANCH and JUMP ADDER TO SAVE SPACE

  // Writeback
  assign wb_we_int = (wb_rd == 'b0) ? 1'b0 : wb_we;   // Never write to register 0
  assign wb_op_sel = (opcode == `OPC_LOAD) ? 2'd2 : ((opcode == `OPC_JAL) || (opcode == `OPC_JALR)) ? 2'd1 : 2'd0;
  assign store     = (opcode == `OPC_STORE) ? 1'b1 : 1'b0;

  // Branching
  assign beq  = (rs1data == rs2data) ? 1'b1 : 1'b0;
  assign bge  = ((rs1data > rs2data) & beq) ? 1'b1 : 1'b0;
  assign bgeu = (($unsigned(rs1data) > $unsigned(rs2data)) & beq) ? 1'b1 : 1'b0;
  assign branch_addr = pc + $signed(imm); // pc + imm;

  // Jump
  assign jump_instr = (opcode == `OPC_JAL) || (opcode == `OPC_JALR) ? 1'b1 : 1'b0;


endmodule : decode

