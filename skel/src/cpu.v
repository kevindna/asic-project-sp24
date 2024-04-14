`include "Opcode.vh"
`include "const.vh"

module cpu # ( parameter INSTR_WIDTH = 32) (
  input wire clk,
  input wire rst,
  // Data Memory
  output dcache_re,
  output [3:0] dcache_we,
  output [`CPU_ADDR_BITS-1:0] dcache_addr,
  input  [`CPU_DATA_BITS-1:0] dcache_dout,
  output [`CPU_DATA_BITS-1:0] dcache_din,
  // Instruction Memory
  output icache_re,
  input [`CPU_DATA_BITS-1:0] icache_dout,
  output [`CPU_ADDR_BITS-1:0] icache_addr,
  // Control Signals
  input mem_stall,
  output [31:0] csr);

  /*************************************************/
  // Signals
  /*************************************************/

  /* Pipeline Registers ***/
  /////////////////////////////////
  // Stage 1:
  reg s1_f_bpred_reg;
  reg [`CPU_ADDR_BITS-1:0] s1_pc_reg;           // Instructions are 4-bit aligned
  // Stage 2:
  reg store_instr_reg;
  reg [`CPU_ADDR_BITS-1:0] s2_pc_reg;
  reg [`CPU_DATA_BITS-1:0] s2_rs1data_reg;
  reg [`CPU_DATA_BITS-1:0] s2_rs2data_reg;
  reg [4:0] s2_rd_reg;
  reg [`CPU_DATA_BITS-1:0] s2_imm_reg;
  reg [`CPU_ADDR_BITS-1:0] s2_mem_addr_reg;
  reg s2_kill_reg;                              // Must delay kill signal, to kill instruction coming out of I$ on next cycle
  reg [6:0] s2_opcode;
  reg [3:0] s2_aluop_reg;


  // Hazards
  wire stall;


  // Fetch 
  wire [`INSTR_WIDTH-1:0] f_instr;  // Instruction fed to decode (form I$ or killed instruction) 
  wire f_branch_pred;   // '1' indicates branch was predicted, '0' otherwise
  wire [`CPU_ADDR_BITS-1:0]  f_pc_nxt;

  // Decode 
  wire d_kill;
  wire [6:0] d_opcode;
  wire take_branch;

  // Decode to Execute
  wire [3:0] aluopcode;
  wire store_instr;
  wire [`CPU_INST_BITS-1:0] dec_instr;
  wire [`CPU_DATA_BITS-1:0] dec_rs1;
  wire [`CPU_DATA_BITS-1:0] dec_rs2;
  wire [4:0] dec_rd;
  wire [`CPU_DATA_BITS-1:0] imm_gen;
  wire [`CPU_ADDR_BITS-1:0] mem_addr;
  wire [`CPU_ADDR_BITS-1:0] cntrl_addr;

  // Writeback
  reg wb_en;
  wire [1:0] wb_op_sel;
  reg [`CPU_DATA_BITS-1:0] wb_data;
  wire [`CPU_DATA_BITS-1:0] alu_out;

  // Memory

  // Dcache
  // wire dcache_re;
  // wire [3:0] dcache_we;
  // wire [`MEM_ADDR_BITS-1:0] dcache_addr;
  // wire [`MEM_DATA_BITS-1:0] dcache_din;
  // wire [`MEM_DATA_BITS-1:0] dcache_dout;
  // Icache
  // wire icache_re;
  // wire [`MEM_ADDR_BITS-1:0] icache_addr;
  // wire [`MEM_DATA_BITS-1:0]  icache_dout;
  `ifdef DEBUG
    // reg 
    wire [`CPU_INST_BITS-1:0] s2_instr_dbg;
    reg [`CPU_INST_BITS-1:0] s3_instr_dbg;

  `endif



  /*************************************************/
  // Pipeline
  /*************************************************/
  //////////////////////////////////
  // Stage 1: Fetch
  // Implemented as signal assignment
  //////////////////////////////////


  // Pipeline registers 1   //////////////////////////////////
  always @(posedge clk) begin
    if(rst == 1'b1) begin
      s1_pc_reg <= `PC_RESET-`CPU_ADDR_BITS'h4;
      s1_f_bpred_reg <= 1'b0;
    end else begin
      if ((stall & mem_stall) == 1'b0) begin
        s1_pc_reg      <= f_pc_nxt;
        s1_f_bpred_reg <= f_branch_pred;
      end
    end
  end


  //////////////////////////////////
  // Stage 2: Decode
  //////////////////////////////////
  decode decode0 (
    // General
    .clk            (clk),  // Clock
    .rst            (rst),  // Asynchronous reset active low
    // Control
    .pc             (s1_pc_reg),
    .stall          (stall),
    .instr          (f_instr),
    .bpred          (s1_f_bpred_reg),             // Prediction; 1 branch was predicted, 0 otherwise
    .kill           (d_kill),
    .br_j           (take_branch),
    .cntrl_addr     (cntrl_addr),  // Branch address
    .funct7_sel     (),            // 1 indicates add/srl, otherwise sub/sra (opcode shared)
    //
    .csr_out        (csr),
    //
    .alu_predecode  (aluopcode),
    .ex_opcode      (d_opcode),
    // 
    .ex_rs1data     (dec_rs1),
    .ex_rs2data     (dec_rs2),
    .ex_rd          (dec_rd),
    .imm_gen        (imm_gen),
    // Memory
    .mem_stall      (mem_stall),
    .mem_re         (dcache_re),
    .mem_we         (dcache_we),       // Not piplined into register; SRAM synchronous
    .mem_addr       (dcache_addr),   // Not piplined into register; SRAM synchronous
    //
    .wb_we          (wb_en),
    .wb_rd          (s2_rd_reg),
    .store          (store_instr),
    .wb_op_sel      (wb_op_sel),
    .wb_data        (wb_data));


  // Pipeline registers 2   //////////////////////////////////
  always @(posedge clk) begin 
    if(rst == 1'b1) begin
      s2_pc_reg       <= s1_pc_reg;
      s2_opcode       <= `OPC_ARI_ITYPE;      
      s2_imm_reg      <= 'b0;
      s2_rs1data_reg  <= 'b0;
      s2_rs2data_reg  <= 'b0;
      s2_rd_reg       <= 5'd0;
      s2_kill_reg     <= 1'b0;
      store_instr_reg <= 'b0;
      s2_aluop_reg    <= `ALU_XXX;
    end else begin
      if (stall == 1'b0) begin 
        s2_pc_reg       <= s1_pc_reg;
        s2_opcode       <= d_opcode;
        s2_imm_reg      <= imm_gen;
        s2_rs1data_reg  <= dec_rs1;
        s2_rs2data_reg  <= dec_rs2;
        s2_rd_reg       <= dec_rd;
        s2_kill_reg     <= d_kill;
        store_instr_reg <= dcache_re;
        s2_aluop_reg    <= aluopcode;
      end
    end
  end


  //////////////////////////////////
  // Stage 3: X/Mem/WB
  //////////////////////////////////
  
  // Execute
  execute execute0 (
    .clk        (clk),
    .rst        (rst),
    .aluopcode  (s2_aluop_reg),
    .opcode     (s2_opcode),
    .pc         (s2_pc_reg),
    .rs1data    (s2_rs1data_reg),
    .rs2data    (s2_rs2data_reg),
    .imm        (s2_imm_reg),
    .alu_out    (alu_out),
    .mem_addr   (),
    .mem_data   ());

  // Memory
  // Memory access is handled be assigning connections directly

  // Writeback
  always @(*) begin : proc_wb
    case (wb_op_sel)
      0: wb_data = alu_out;       // R-type, I-type
      1: wb_data = s2_pc_reg;     // jal/jalr
      2: wb_data = dcache_dout;   // Loads
      default : wb_data = s2_pc_reg;
    endcase

    case (s2_opcode)
      `OPC_ARI_RTYPE , `OPC_ARI_ITYPE , `OPC_JALR , `OPC_CSR: wb_en = 1'b1;
      `OPC_LOAD: wb_en = ~mem_stall;
      default  : wb_en = 1'b0;
    endcase
  end

  `ifdef DEBUG
    always @(posedge clk ) begin : proc_debug
      if(~rst) begin
        // s2_instr_dbg <= 'haaaa_aaaa;
        s3_instr_dbg <= 'haaaa_aaaa;
      end else begin
         // s2_instr_dbg <= ;
         s3_instr_dbg <= s2_instr_dbg;
      end
    end

    assign s2_instr_dbg = icache_dout;
  `endif



  /*************************************************/
  // Signal Assignments
  /*************************************************/
  // Fetch
  assign f_branch_pred = 1'b1; // Always predict branch is taken
  assign f_instr  = (s2_kill_reg == 1'b1) ? `INSTR_NOP : icache_dout;  // TODO!!!!!!!
  assign f_pc_nxt = (stall == 1'b1) ? s1_pc_reg : (d_kill == 1'b1) ? cntrl_addr : s1_pc_reg + 'd4 ;

  // Decode 
  assign mem_addr = imm_gen + dec_rs1;

  // Instruction memory
  assign icache_re   = ~mem_stall ;  // Always fetch; TODO: ADD condition for stall for hazards
  assign icache_addr = f_pc_nxt;

  // Data memory


  // Writeback 
endmodule

