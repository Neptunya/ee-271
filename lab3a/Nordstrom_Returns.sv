/*
// Lights up LEDs depending on if an item is discounted or stolen.
module Nordstrom_Returns (LEDR, SW);
	output logic [9:0] LEDR;
	input logic [9:0] SW;
	logic D, S;

	Discount_Checker dc1 (.D(D), .U(SW[9]), .P(SW[8]), .C(SW[7]));
	Stolen_Checker sc1 (.S(S), .U(SW[9]), .P(SW[8]), .C(SW[7]), .M(SW[0]));

	always_comb begin
		LEDR[9] = D;
		LEDR[0] = S;
	end
endmodule

module tb_Nordstrom_Returns();
logic [9:0] LEDR;
logic [9:0] SW;

	Nordstrom_Returns dut (.LEDR, .SW);

	integer i;
	initial begin
		SW [0] = 1'b0;
		for (i = 0; i < 8; i++) begin
			SW[9:7] = i;
			#10;
		end

		SW [0] = 1'b1;
		for (i = 0; i < 8; i++) begin
			SW[9:7] = i;
			#10;
		end
	end
endmodule
*/