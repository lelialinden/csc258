module part1 (SW, LEDR, HEX1, HEX0);
  input [17:0] SW;
  output [17:0] LEDR;
  output [6:0] HEX1;
  output [6:0] HEX0;
  
  wire [3:0] d1;
  wire [3:0] d0;
  
  assign LEDR = SW;
  
  BCD_conversion_circuit(SW[3:0], d1, d0);
  
  decoder_7seg(d1, HEX1);
  decoder_7seg(d0, HEX0);
endmodule


module BCD_conversion_circuit (V, d1, d0);
  input [3:0] V;
  output [3:0] d1;
  output [3:0] d0;
  wire [3:0] M;
  wire [2:0] W;
  wire z;
  
  assign d0 = M;
  comparator_gt9 (V, z);
  circuit_A (V[2:0], W);
  circuit_B (z, d1);
  
  mux_2to1 (z, V[3], 0, M[3]);
  mux_2to1 (z, V[2], W[2], M[2]);
  mux_2to1 (z, V[1], W[1], M[1]);
  mux_2to1 (z, V[0], W[0], M[0]);
endmodule


module decoder_7seg (M, Display);
  input [3:0] M;
  output [6:0] Display;
  
  assign Display[0] = (M[2] & ~M[1] & ~M[0]) | (~M[3] & ~M[2] & ~M[1] & M[0]);
  assign Display[1] = (M[2] & ~M[1] & M[0]) | (M[2] & M[1] & ~M[0]);
  assign Display[2] = ~M[3] & ~M[2] & M[1] & ~M[0];
  assign Display[3] = (M[2] & M[1] & M[0]) | (~M[2] & ~M[1] & M[0]) | (M[2] & ~M[1] & ~M[0]);
  assign Display[4] = (M[2] & M[0]) | (~M[1] & M[0]) | (M[2] & ~M[1]) | (~M[3] & M[0]);
  assign Display[5] = (M[1] & M[0]) | (~M[3] & ~M[2] & M[0]) | (~M[3] & ~M[2] & M[1]);
  assign Display[6] = (M[2] & M[1] & M[0]) | (~M[3] & ~M[2] & ~M[1]);
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


module circuit_B (z, U);
  input z;
  output [3:0] U;
  
  assign U[0] = z;
  assign U[1] = 0;
  assign U[2] = 0;
  assign U[3] = 0;
endmodule


module mux_2to1 (s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule
