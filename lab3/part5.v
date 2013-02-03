module part5 (SW, LEDR);
  input [17:0] SW;
  output [17:0] LEDR;
  
  master_slave_D_flip_flop(SW[1], SW[0], LEDR[0]);
  
endmodule


module master_slave_D_flip_flop (Clk, D, Q);
  input Clk, D;
  output Q;
  
  wire Q_m, Q_s;
  
  gated_D_latch(~Clk, D, Q_m);
  gated_D_latch(Clk, Q_m, Q_s);
  
  assign Q = Q_s;
  
endmodule


// A gated D latch
module gated_D_latch (Clk, D, Q);
  input Clk, D;
  output Q;
  
  wire R, S, R_g, S_g, Qa, Qb /* synthesis keep */ ;
  
  assign S = D;
  assign R = ~D;
  assign R_g = ~(R & Clk);
  assign S_g = ~(S & Clk);
  assign Qa = ~(S_g & Qb);
  assign Qb = ~(R_g & Qa);
  
  assign Q = Qa;
  
endmodule
