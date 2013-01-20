module part3(SW, LEDR, LEDG);
  input [17:0]SW;
  output [17:0]LEDR;
  output [2:0]LEDG;
  assign LEDR = SW;
  
  five_to_one_mux(SW[17:15], SW[14], SW[13], SW[12], SW[11], SW[10], LEDG[2]);
  five_to_one_mux(SW[17:15], SW[9], SW[8], SW[7], SW[6], SW[5], LEDG[1]);
  five_to_one_mux(SW[17:15], SW[4], SW[3], SW[2], SW[1], SW[0], LEDG[0]);
endmodule
  
module five_to_one_mux(s, u, v, w, x, y, m);
  input [2:0]s;
  input u, v, w, x, y;
  output m;
  
  two_to_one_mux(s0, u, v, out1);
  two_to_one_mux(s0, w, x, out2);
  two_to_one_mux(s1, out1, out2, out3);
  two_to_one_mux(s2, out3, y, m);
endmodule

module two_to_one_mux(s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule
