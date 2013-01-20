module part2(SW, LEDR, LEDG);
  input [17:0]SW;    // toggle switches
  output [17:0]LEDR; // red LEDs
  output [7:0]LEDG;  // green LEDs
  assign LEDR = SW;
  
  mux(SW[17], SW[7], SW[15], LEDG[7]);
  mux(SW[17], SW[6], SW[14], LEDG[6]);
  mux(SW[17], SW[5], SW[13], LEDG[5]);
  mux(SW[17], SW[4], SW[12], LEDG[4]);
  mux(SW[17], SW[3], SW[11], LEDG[3]);
  mux(SW[17], SW[2], SW[10], LEDG[2]);
  mux(SW[17], SW[1], SW[9], LEDG[1]);
  mux(SW[17], SW[0], SW[8], LEDG[0]);
endmodule

module mux(s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule