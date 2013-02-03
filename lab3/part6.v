module part6 (SW, LEDR);
  input [17:0] SW;
  output [17:0] LEDR;
  
  D_latch(SW[1], SW[0], LEDR[2]);
  pos_triggered_D_flipflop(SW[1], SW[0], LEDR[1]);
  neg_triggered_D_flipflop(SW[1], SW[0], LEDR[0]);
endmodule


module D_latch (Clk, D, Q);
  input Clk, D;
  output reg Q;
  
  always @ (D, Clk)
    if (Clk)
	   Q = D;

endmodule


module pos_triggered_D_flipflop (Clk, D, Q);
  input Clk, D;
  output reg Q;
  
  always @ (posedge Clk)
    Q = D;

endmodule


module neg_triggered_D_flipflop (D, Clk, Q);
  input Clk, D;
  output reg Q;
  
  always @ (negedge Clk)
    Q = D;
  
endmodule
