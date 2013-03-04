module part4(SW, HEX3, HEX2, HEX1, HEX0)
  input [7:0] SW;
  wire [7:0] P;
  output [6:0] HEX3;
  output [6:0] HEX2;
  output [6:0] HEX1;
  output [6:0] HEX0;
  
  array_multiplier(SW[7:4], SW[3:0], P);
  
  one_digit_hex_display(A, HEX1);
  one_digit_hex_display(B, HEX0);
  two_digit_hex_display(P, HEX3, HEX2);
  
endmodule


module array_multiplier (A, B, P);
  input [3:0] A;
  input [3:0] B;
  output [7:0] P;
  
  wire [5:0] sums;
  wire [10:0] carries;
  
  P[0] = A[0] & B[0];
  
  // First row of adders.
  full_adder(0,          A[1] & B[0], A[0] & B[1], P[1],    carries[0]);
  full_adder(carries[0], A[2] & B[0], A[1] & B[1], sums[0], carries[1]);
  full_adder(carries[1], A[3] & B[0], A[2] & B[1], sums[1], carries[2]);
  full_adder(carries[2], 0,           A[3] & B[1], sums[2], carries[3]);
  
  // Second row.
  full_adder(0,          sums[0]   , A[0] & B[2], P[2],    carries[4]);
  full_adder(carries[4], sums[1]   , A[1] & B[2], sums[3], carries[5]);
  full_adder(carries[5], sums[2]   , A[2] & B[2], sums[4], carries[6]);
  full_adder(carries[6], carries[3], A[3] & B[2], sums[5], carries[7]);
  
  // Third row.
  full_adder(0,           sums[3]   , A[0] & B[3], P[3], carries[8]);
  full_adder(carries[8] , sums[4]   , A[1] & B[3], P[4], carries[9]);
  full_adder(carries[9] , sums[5]   , A[2] & B[3], P[5], carries[10]);
  full_adder(carries[10], carries[7], A[3] & B[3], P[6], P[7]);
  
endmodule


module full_adder (c_in, a, b, s, c_out);
  input c_in, a, b;
  output s, c_out;
  
  assign {c_out, s} = a + b + c_in;
  
endmodule
