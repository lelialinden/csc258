module part5 (SW, LEDR, HEX2, HEX1, HEX0);
  input [15:0] SW;
  input [15:0] LEDR;
  output [6:0] HEX2;
  output [6:0] HEX1;
  output [6:0] HEX0;
  
  wire [3:0] S2;
  wire [3:0] S1;
  wire [3:0] S0;
  
  assign LEDR = SW;
  
  decoder_7seg (S2, HEX2)
  decoder_7seg (S1, HEX1)
  decoder_7seg (S0, HEX0)
endmodule


module BCD_conversion_circuit_5to2 (c_in, S, d1, d0);
  // Converts a 5-bit binary number into two-digit BCD format.
  // Only works for 5-bit binary numbers less than 20.
  input c_in;
  input [3:0] S;
  output [3:0] d1;
  output [3:0] d0;
  
  wire [4:0] V;
  wire [3:0] W;
  wire z;       // This will represent the first digit.
  
  assign V[4] = c_in;
  assign V[3:0] = S;
  
  comparator_gt9 (V, z);
  circuit_A (V[3:0], W);
  circuit_B (z, d1);
  
  mux_2to1 (z, V[3], W[3], d0[3]);
  mux_2to1 (z, V[2], W[2], d0[2]);
  mux_2to1 (z, V[1], W[1], d0[1]);
  mux_2to1 (z, V[0], W[0], d0[0]);
endmodule


module ripple_carry_adder (c_in, A, B, S, c_out);
  input c_in;
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  output c_out;
  
  wire [3:1] C;
  
  full_adder(c_in, A[0], B[0], S[0], C[1]);
  full_adder(C[1], A[1], B[1], S[1], C[2]);
  full_adder(C[2], A[2], B[2], S[2], C[3]);
  full_adder(C[3], A[3], B[3], S[3], c_out);
endmodule


module comparator_gt9 (V, z);
  // Output is 1 if value of V is greater than 9
  input [4:0] V;
  output z;
  
  assign z = (V[3] & V[2]) | (V[3] & V[1]) | V[4];
endmodule


module decoder_7seg (M, Display);
  // Displays a 4-bit binary number representing a digit.
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


module circuit_A (V, W);
  input [3:0] V;
  output [3:0] W;
  
  assign W[3] = ~V[3] & ~V[2] & V[1];
  assign W[2] = (~V[3] & ~V[2] & ~V[1]) | (V[3] & V[2] & V[1]);
  assign W[1] = ~V[1] & (V[3] ~^ V[2]);
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


module full_adder (c_in, a, b, s, c_out);
  input c_in, a, b;
  output s, c_out;
  
  wire z;
  assign z = a ^ b;
  
  assign s = c_in ^ z;
  mux_2to1(z, b, c_in, c_out);
endmodule


module mux_2to1 (s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule
