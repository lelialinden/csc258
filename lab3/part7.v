module part7 (SW, KEY, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input [15:0] SW;
  input [1:0] KEY;
  output [7:0] HEX7;
  output [7:0] HEX6;
  output [7:0] HEX5;
  output [7:0] HEX4;
  output [7:0] HEX3;
  output [7:0] HEX2;
  output [7:0] HEX1;
  output [7:0] HEX0;
  
  wire [15:0] A;
  wire [15:0] B;
  
  // TODO: Figure out where to put KEY[0].
  
  sixteen_posedge_flipflops(SW, KEY[1], A);
  assign B = SW;
  
  display_hexadecimal(A, HEX7, HEX6, HEX5, HEX4);
  display_hexadecimal(B, HEX3, HEX2, HEX1, HEX0);
  
endmodule


module display_hexadecimal (V, Display3, Display2, Display1, Display0);
  input [15:0] V;
  output [7:0] Display3;
  output [7:0] Display2;
  output [7:0] Display1;
  output [7:0] Display0;
  
  // TODO: Figure out how to display a hexadecimal number.
  
endmodule


module sixteen_posedge_flipflops (SW, Clk, OUT);
  input [15:0] SW;
  input Clk;
  output [15:0] OUT;
  
  posedge_triggered_flipflop(SW[15], Clk, OUT[15]);
  posedge_triggered_flipflop(SW[14], Clk, OUT[14]);
  posedge_triggered_flipflop(SW[13], Clk, OUT[13]);
  posedge_triggered_flipflop(SW[12], Clk, OUT[12]);
  posedge_triggered_flipflop(SW[11], Clk, OUT[11]);
  posedge_triggered_flipflop(SW[10], Clk, OUT[10]);
  posedge_triggered_flipflop(SW[9], Clk, OUT[9]);
  posedge_triggered_flipflop(SW[8], Clk, OUT[8]);
  posedge_triggered_flipflop(SW[7], Clk, OUT[7]);
  posedge_triggered_flipflop(SW[6], Clk, OUT[6]);
  posedge_triggered_flipflop(SW[5], Clk, OUT[5]);
  posedge_triggered_flipflop(SW[4], Clk, OUT[4]);
  posedge_triggered_flipflop(SW[3], Clk, OUT[3]);
  posedge_triggered_flipflop(SW[2], Clk, OUT[2]);
  posedge_triggered_flipflop(SW[1], Clk, OUT[1]);
  posedge_triggered_flipflop(SW[0], Clk, OUT[0]);
  
endmodule


module posedge_triggered_flipflop (D, Clk, Q);
  input Clk, D;
  output reg Q;
  
  always @ (posedge Clk)
    Q = D;
  
endmodule
