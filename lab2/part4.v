module part4 (SW, LEDR, LEDG, HEX6, HEX4, HEX1, HEX0);
  input [8:0] SW;
  output [8:0] LEDR;
  output [8:0] LEDG;
  output [6:0] HEX6;
  output [6:0] HEX4;
  output [6:0] HEX1;
  output [6:0] HEX0;
  wire [3:0] A;
  wire [3:0] B;
  wire [3:0] d1;
  wire [3:0] d0;
  wire [3:0] S;
  wire c_out;
  
  assign LEDR = SW;
  assign A[3:0] = SW[7:4];
  assign B[3:0] = SW[3:0];
  assign LEDG[4] = c_out;
  assign LEDG[3:0] = S;
  
  comparator_gt9 (A, e1);
  comparator_gt9 (B, e2);
  assign LEDG[8] = e1 | e2;
  
  ripple_carry_adder (SW[8], A, B, S, c_out);
  BCD_conversion_circuit_5to2 (c_out, S, d1, d0);
  
  decoder_7seg(A, HEX6);
  decoder_7seg(B, HEX4);
  decoder_7seg(d1, HEX1);
  decoder_7seg(d0, HEX0);
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
