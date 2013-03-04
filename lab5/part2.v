module part2 (SW, LEDR, KEY);
  input [7:0] SW;
  input [1:0] KEY;
  
  output [8:0] LEDR;
  
  accumulator_circuit(SW, LEDR[7:0], KEY[1], LEDR[8]);
endmodule

module accumulator_circuit (A, S, Clk, Overflow, Reset);
  input [7:0] A;
  input Clk;
  input Reset;
  output reg [7:0] S;
  output Overflow;
  
  wire S_temp;
  wire overflow;
  
  assign {overflow, S_temp} = S + A;
  
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

