// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	logic X, Y;
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
endmodule

// Checks if a given object is discounted based on its UPC code.
module Discount_Checker (D, U, P, C);
	output logic D;
	input logic U, P, C;

	always_comb begin
		assign D = P | (U & C);
	end
endmodule

// Checks if a given object has been stolen based on its UPC code and if it has a mark (M).
module Stolen_Checker (S, U, P, C, M);
	output logic S;
	input logic U, P, C, M;

	always_comb begin
		assign S = ~(P | M | ~(U & (~C)));
	end
endmodule

module Nordstrom_Returns (LEDR, SW);
	output logic [9:0] LEDR;
	input logic [9:0] SW;

	Discount_Checker G1 (.D(LEDR[9]), .U(SW[9]), .P(SW[8]), .C(SW[7]));
	Stolen_Checker G2 (.S(LEDR[0]), .U(SW[9]), .P(SW[8]), .C(SW[7]), .M(SW[0]));
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