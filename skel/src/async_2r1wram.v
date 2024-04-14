`include "const.vh"

module async_2r1wram 
  #(parameter DEPTH = 128,
    parameter WIDTH = 32  ) (
    input wire clk,
    input wire rst, 
    input wire we,
    // Read port 1
    input  [$clog2(DEPTH)-1:0] raddr0,
    output [`DWIDTH-1:0] rdata0,
    // Read port 2
    input  [$clog2(DEPTH)-1:0] raddr1,
    output [`DWIDTH-1:0] rdata1,
    // Write port 1
    input [$clog2(DEPTH)-1:0] waddr0,
    input [`DWIDTH-1:0] wdata
  );


  integer i;
  reg [`DWIDTH-1:0] ram [DEPTH-1:0]; // RAM 

  always @(posedge clk) begin 
    if (rst == 1'b1) begin
      for (i = 0; i < DEPTH; i = i + 1) begin
        ram[i] = `DWIDTH'b0;
      end
    end else begin
      if (we == 1'b1) begin
        ram[waddr0] <= wdata;
      end
    end
  end

  assign rdata0 = ram[raddr0];
  assign rdata1 = ram[raddr1];

endmodule : async_2r1wram
