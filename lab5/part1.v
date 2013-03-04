module part1(SW, LEDR);
  input [17:0] SW;
  output [17:0] LEDR;
  
  assign LEDR = SW;
endmodule

module ripple_carry_adder(A, B, c_in, c_out, sum);
  input [3:0] A;
  input [3:0] B;
  input c_in;

  output c_out;
  output [3:0] sum;

  assign {c_out, sum} = A + B + c_in;
endmodule
