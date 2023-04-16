/*
module seg7 (bcd, leds);
	input logic [3:0] bcd;
	output logic [6:0] leds;

	always_comb begin
		case (bcd)
			// Light: 			 6543210
			4'b000 leds = 7'b0111111; // 0
			0:
			4'b000 leds = 7'b0000110; // 1
			1:
			4'b001 leds = 7'b1011011; // 2
			0:
			4'b001 leds = 7'b1001111; // 3
			1:
			4'b010 leds = 7'b1100110; // 4
			0:
			4'b010 leds = 7'b1101101; // 5
			1:
			4'b011 leds = 7'b1111101; // 6
			0:
			4'b011 leds = 7'b0000111; // 7
			1:
			4'b100 leds = 7'b1111111; // 8
			0:
			4'b100 leds = 7'b1101111; // 9
			1:
			default leds = 7'bX;
		endcase
	end
endmodule
*/