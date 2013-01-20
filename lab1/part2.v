module part2(SW, LEDR)
  input [17:0]SW;    // toggle switches
  output [17:0]LEDR; // red LEDs
  
  assign s = SW[17];
  
  assign m = [7:0]LEDG;
  
  mux(s, x[7], y[7], m[7]);
  mux(s, x[6], y[6], m[6]);
  mux(s, x[5], y[5], m[5]);
  mux(s, x[4], y[4], m[4]);
  mux(s, x[3], y[3], m[3]);
  mux(s, x[2], y[2], m[2]);
  mux(s, x[1], y[1], m[1]);
  mux(s, x[0], y[0], m[0]);
endmodule

module mux(s, x, y, m)
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
endmodule