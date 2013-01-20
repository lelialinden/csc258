module part4 (SW, HEX0);
  input [17:0] SW;
  output [0:6] HEX0;
  
  char_7seg(SW[2:0], HEX0);
endmodule

module char_7seg (C, Display);
  input [2:0] C;        // input code
  output [0:6] Display; // output 7-seg code
  
  assign Display[0] = ~C[2] & C[0];
  assign Display[1] = ~C[2] & (C[1] ~^ C[0]);
  assign Display[2] = ~C[2] & (C[1] ~^ C[0]);
  assign Display[3] = ~C[2] & (C[1] | C[0]);
  assign Display[4] = ~C[2];
  assign Display[5] = ~C[2];
  assign Display[6] = ~C[2] & ~C[1];
endmodule

module mux_5to1 (S, u, v, w, x, y, m);
  input [2:0] S;
  input u, v, w, x, y;
  output m;
  
  mux_2to1(S[0], u, v, out1);
  mux_2to1(S[0], w, x, out2);
  mux_2to1(S[1], out1, out2, out3);
  mux_2to1(S[2], out3, y, m);
endmodule

module mux_2to1(s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule

