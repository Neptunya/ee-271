module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
endmodule


// big while loop for when current_led isn't 4'b1010 or 4'b0000
// update LEDRs (turn LEDR[previous_led] off, then LEDR[current_led] on)
// update previous_led to be current_led
// update current_led

// out of while loop
// turn off all LEDRs
// depending on what current_led is, display victory message for player 1 or 2