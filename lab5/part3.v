module part3 (SW, LEDR, KEY);
  input [8:0] SW;
  input [1:0] KEY;
  
  output [8:0] LEDR;
  
  accumulator_circuit(SW[7:0], LEDR[7:0], KEY[1], LEDR[8], SW[8]);
  
endmodule

module accumulator_circuit (A, S, Clk, Overflow, Reset, add_sub);
  input [7:0] A;
  input Clk;
  input add_sub;
  input Reset;
  output reg [7:0] S;
  output Overflow;
  
  wire S_temp;
  wire overflow;
  
  mux_2to1(add_sub, S + A, S - A, {overflow, S_temp});
  pos_triggered_D_flipflop(Clk, overflow, Overflow);
  
  // Last flip-flop?
  
  always @ (Reset)
    if (~Reset)
	   S = 0;
  
endmodule

module pos_triggered_D_flipflop (Clk, D, Q);
  input Clk, D;
  output reg Q;
  
  always @ (posedge Clk)
    Q = D;

endmodule

module mux_2to1 (s, x, y, m);
  input s, x, y;
  output m;
  
  assign m = (~s & x) | (s & y);
  
endmodule

