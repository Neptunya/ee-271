module Marketboard (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
  logic D, S;
	logic [3:0] UPC;

  assign UPC = {SW[9], SW[8], SW[7]};

  Discount_Checker dc1 (.D(D), .U(SW[9]), .P(SW[8]), .C(SW[7]));
	Stolen_Checker sc1 (.S(S), .U(SW[9]), .P(SW[8]), .C(SW[7]), .M(SW[0]));

  always_comb begin
		LEDR[9] = D;
		LEDR[0] = S;

		case (UPC)
			3'b000: begin // shrd
			 //         6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b0100001;
				HEX3 = 7'b0101111;
				HEX4 = 7'b0001001;
				HEX5 = 7'b0010010;
			end

			3'b001: begin // lps
			 //         6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX3 = 7'b0010010;
				HEX4 = 7'b0001100;
				HEX5 = 7'b1000111;
			end

			3'b011: begin // gs
			 //         6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX3 = 7'b1111111;
				HEX4 = 7'b0010010;
				HEX5 = 7'b1000010;
			end

			3'b100: begin // ds
			 //         6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX3 = 7'b1111111;
				HEX4 = 7'b0010010;
				HEX5 = 7'b0100001;
			end

			3'b101: begin // slr
			 //         6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX3 = 7'b0101111;
				HEX4 = 7'b1000111;
				HEX5 = 7'b0010010;
			end

			3'b110: begin // fsn
			 //         6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX3 = 7'b1001000;
				HEX4 = 7'b0010010;
				HEX5 = 7'b0001110;
			end

			default: begin
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX3 = 7'b1111111;
				HEX4 = 7'b1111111;
				HEX5 = 7'b1111111;
			end
		endcase
	end
endmodule

// Checks if a given object is discounted based on its UPC code.
module Discount_Checker (D, U, P, C);
	output logic D;
	input logic U, P, C;

	assign D = ~(P ^ C);
endmodule

// Checks if a given object has been stolen based on its UPC code and if it has a mark (M).
module Stolen_Checker (S, U, P, C, M);
	output logic S;
	input logic U, P, C, M;

	assign S = M & ~P & (U | C);
endmodule

module tb_Marketboard();
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic [9:0] SW;

	Marketboard dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .SW);

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