module part4 (SW, LEDR, LEDG, HEX6, HEX4, HEX1, HEX0);
  input [8:0] SW;
  output [8:0] LEDR, [8:0] LEDG;
  output [6:0] HEX6, [6:0] HEX4, [6:0] HEX1, [6:0] HEX0;
  wire [3:0] A, [3:0] B;
  
  assign SW = LEDR;
  assign SW[7:4] = A[3:0];
  assign SW[3:0] = B[3:0];
  
  comparator(A, e1);
  comparator(B, e2);
  assign LEDG[8] = e1 | e2;
  
  decoder_7seg(A, HEX6);
  decoder_7seg(B, HEX4);
  
  // Produce 4-bit sum
  // Convert this 5 bit result into BCD S1 and S0
  

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


module comparator (V, z);
  // Checks if the value of V is greater than 9
  input [3:0] V;
  output z;
  
  assign z = (V[3] & V[2]) | (V[3] & V[1]);
endmodule


module decoder_7seg (M, Display);
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
