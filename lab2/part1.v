module part1 (SW, HEX1, HEX0);
  input [3:0] SW;
  output [6:0] HEX1;
  output [6:0] HEX0;

  wire [3:0] V;
  wire [3:0] M;	 
endmodule


module 7seg_decoder (M, Display);
  input [3:0] M;
  output [6:0] Display;
  
  
endmodule


module comparator (V, z);
  input [3:0] V;
  output z;
  
  // Checks if the value of V is greater than 9
endmodule


module circuit_A (V, W);
  input [2:0] V;
  output [2:0] W;
  
  // If comparator output is 1, then this determines
  // what value is set as the first BCD digit.
endmodule


module circuit_B (z, Display);
  input z;
  output [6:0] Display;
  
  assign Display[0] = ~z;
  assign Display[1] = 1;
  assign Display[2] = 1;
  assign Display[3] = ~z;
  assign Display[4] = ~z;
  assign Display[5] = ~z;
  assign Display[6] = 0;
endmodule


module mux_2to1 (s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule
