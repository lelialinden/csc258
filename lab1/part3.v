module part3(SW, LEDR, LEDG);
  input [17:0]SW;
  output [17:0]LEDR;
  output [2:0]LEDG;
  assign LEDR = SW;
  
  mux_3bit_5to1(SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], LEDG[2:0]);
endmodule
  
module mux_3bit_5to1 (S, U, V, W, X, Y, M)
  input [2:0] S, U, V, W, X, Y;
  output [2:0] M;
  
  mux_5to1(S, U[2], V[2], W[2], X[2], Y[2], M[2]);
  mux_5to1(S, U[1], V[1], W[1], X[1], Y[1], M[1]);
  mux_5to1(S, U[0], V[0], W[0], X[0], Y[0], M[0]);
endmodule  

module mux_5to1 (s, u, v, w, x, y, m);
  input [2:0] s;
  input u, v, w, x, y;
  output m;
  
  mux_2to1(s[0], u, v, out1);
  mux_2to1(s[0], w, x, out2);
  mux_2to1(s[1], out1, out2, out3);
  mux_2to1(s[2], out3, y, m);
endmodule

module mux_2to1(s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule
