module fetch (
  input clk,    // Clock
  input clk_en, // Clock Enable
  input rst_n,  // Asynchronous reset active low
  output out
);

assign out = ~rst_n & clk_en ? 1'b0 : 1'b1;
endmodule