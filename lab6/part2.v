module part2(SW, KEY, LEDR, LEDG);
  input [1:0] SW;
  input [4:0] KEY;
  output [8:0] LEDR;
  output [8:0] LEDG;
  
  one_hot_FSM(KEY[0], SW[1], LEDG[0], SW[0], LEDR);

endmodule


module one_hot_FSM (Clock, w, z, Reset, y);
  input Clock, w, Reset;
  output [8:0] y;
  output z;
  
  wire [8:0] x;
  
  assign z = y[8] | y[4];
  assign x[0] = ~Reset;
  assign x[1] = Reset & (~w & (y[0] | y[5] | y[6] | y[7] | y[8]));
  assign x[2] = Reset & (~w & y[1]);
  assign x[3] = Reset & (~w & y[2]);
  assign x[4] = Reset & (~w & (y[3] | y[4]));
  assign x[5] = Reset & (w & (y[0] | y[1] | y[2] | y[3] | y[4]));
  assign x[6] = Reset & (w & y[5]);
  assign x[7] = Reset & (w & y[6]);
  assign x[8] = Reset & (w & (y[7] | y[8]));
  
  pos_triggered_D_flipflop(Clock, x[8], y[8]);
  pos_triggered_D_flipflop(Clock, x[7], y[7]);
  pos_triggered_D_flipflop(Clock, x[6], y[6]);
  pos_triggered_D_flipflop(Clock, x[5], y[5]);
  pos_triggered_D_flipflop(Clock, x[4], y[4]);
  pos_triggered_D_flipflop(Clock, x[3], y[3]);
  pos_triggered_D_flipflop(Clock, x[2], y[2]);
  pos_triggered_D_flipflop(Clock, x[1], y[1]);
  pos_triggered_D_flipflop(Clock, x[0], y[0]);

endmodule


module pos_triggered_D_flipflop (Clk, D, Q);
  input Clk, D;
  output reg Q;
  
  always @ (posedge Clk)
    Q = D;

endmodule
