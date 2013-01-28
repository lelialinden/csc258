module part3 (SW, LEDR, LEDG);
  input [8:0] SW;
  output [8:0] LEDR;
  output [4:0] LEDG;
  
  ripple_carry_adder(SW[8], SW[7:4], SW[3:0], LEDG[3:0], LEDG[4]);
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
