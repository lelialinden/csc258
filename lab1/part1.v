// Simple module that connects the SW switches to the LEDR lights
module part1(SW, LEDR);
  input [17:0]SW;    // toggle switches
  output [17:0]LEDR; // red LEDs
  
  assign LEDR = SW;
endmodule
