`include "const.vh"
`include "EECS151.v"

module async_2r1wram_jwstyle
  #(  parameter DEPTH = 128,
      parameter WIDTH = 32) (
    input wire clk,
    input wire rst, 
    input wire we,
    // Read port 1
    input [$clog2(DEPTH)-1:0] raddr0,
    output [WIDTH-1:0] rdata0,
    // Read port 2
    input [$clog2(DEPTH)-1:0] raddr1,
    output [WIDTH-1:0] rdata1,
    // Write port 1
    input [$clog2(DEPTH)-1:0] waddr0,
    input [WIDTH-1:0] wdata
  );


  genvar i;
  reg [WIDTH-1:0] reg_d [DEPTH-1:0]; // Register din
  reg [WIDTH-1:0] reg_q [DEPTH-1:0]; // Register

  // Register file
  generate
    for (i = 0; i < DEPTH; i++) begin
      REGISTER #(.N(WIDTH)) reg_x (.clk(clk), .d(reg_d[i]), .q(reg_q[i]));

      // Write
      always @(*) begin 
        if (rst == 1'b1) begin
          // for (i = 0; i < DEPTH; i = i + 1) begin
            reg_d[i] <= {WIDTH{1'b0}};
          // end
        end else begin
          // for (i = 0; i < DEPTH; i = i + 1) begin
            if ((we == 1'b1) && (i == waddr0)) begin
              reg_d[waddr0] <= wdata;
            end
          // end
        end
      end
    end
  endgenerate



  // Read
  assign rdata0 = reg_q[raddr0];
  assign rdata1 = reg_q[raddr1];

endmodule : async_2r1wram_jwstyleam_jwstyle                                                                 