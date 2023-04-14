module OneDigitRecog (G, A, B, C, D);
	output logic G;
	input logic A, B, C, D;
	logic E;
	
	nand G1 (E, A, B);
	nand G2 (F, C, D);
	nor G3 (G, E, F); 
endmodule

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
	
	// Logic to check if SW[3]..SW[0] match your bottom digit,
	// and SW[7]..SW[4] match the next.
	// Result should drive LEDR[0].
	
	OneDigitRecog O1 (X, ~SW[3], ~SW[2], ~SW[1], SW[0]);
	OneDigitRecog O2 (Y, ~SW[7], ~SW[6], ~SW[5], ~SW[4]);
	assign LEDR[0] = X & Y;
	
endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
	.SW);
	
	// Try all combinations of inputs.
	integer i;
	initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for(i = 0; i <256; i++) begin
			SW[7:0] = i; #10;
		end
	end
endmodule