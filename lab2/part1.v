module part1 (SW, HEX1, HEX0);
  input [3:0] SW;
  output [6:0] HEX1;
  output [6:0] HEX0;

  BCD_conversion_circuit(SW, HEX1, HEX0);
endmodule


module BCD_conversion_circuit (V, Display1, Display0);
  input [3:0] V;
  output [6:0] Display1;
  output [6:0] Display0;
  
  wire [3:0] M;
  wire [2:0] W;
  wire z;
  
  comparator_gt9 (V, z);
  char_7seg (M, Display0);
  circuit_A (V[2:0], W);
  circuit_B (z, Display1);
  
  mux_2to1 (z, V[3], 0, M[3]);
  mux_2to1 (z, V[2], W[2], M[2]);
  mux_2to1 (z, V[1], W[1], M[1]);
  mux_2to1 (z, V[0], W[0], M[0]);
endmodule


module char_7seg (M, Display);
  input [3:0] M;
  output [6:0] Display;
  
  assign Display[0] = (M[1] & ~M[3]) | (~M[0] & ~M[2]) | (~M[3] & M[0]);
  assign Display[1] = ~M[2] | (M[1] ^~ M[0]);
  assign Display[2] = M[2] | M[0] | ~M[1];
  assign Display[3] = (~M[2] & ~M[0] | M[1]) | (M[1] & ~M[0]) | (M[0] & ~M[1] & M[2]);
  assign Display[4] = (~M[2] & ~M[0]) | (M[1] & ~M[0]);
  assign Display[5] = M[3] | (~M[1] & ~M[0]) | (M[2] & (~M[0] | ~M[1]));
  assign Display[6] = M[3] | (M[2] ^ M[1]) | (M[1] & ~M[0]);
endmodule


module comparator_gt9 (V, z);
  // Checks if the value of V is greater than 9
  input [3:0] V;
  output z;
  
  assign z = (V[3] & V[2]) | (V[3] & V[1]);
endmodule


module circuit_A (V, W);
  input [2:0] V;
  output [2:0] W;
  
  assign W[2] = V[2] & V[1];
  assign W[1] = V[2] & ~V[1];
  assign W[0] = V[0];
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
