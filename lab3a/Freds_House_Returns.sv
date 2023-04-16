module Freds_House_Returns (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [9:0] SW;
	logic U, P, C, D, S;
	logic [3:0] UPC;

	assign U = SW[9];
	assign P = SW[8];
	assign C = SW[7];
 
	assign UPC = {SW[9], SW[8], SW[7]};
	
	Discount_Checker dc1 (.D(D), .U(U), .P(P), .C(C));
	Stolen_Checker sc1 (.S(S), .U(U), .P(P), .C(C), .M(SW[0]));

	always_comb begin
		LEDR[9] = D;
		LEDR[0] = S;

		case (UPC)
			3'b000: begin // shoes
			 //          6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b0010010;
				HEX2 = 7'b0000110;
				HEX3 = 7'b1000000;
				HEX4 = 7'b0001001;
				HEX5 = 7'b0010010;
			end

			3'b001: begin // costume jewelry (jwlry)
			 //          6543210
				HEX0 = 7'b0010001;
				HEX1 = 7'b1001110;
				HEX2 = 7'b1000111;
				HEX3 = 7'b1000001;
				HEX4 = 7'b1000001;
				HEX5 = 7'b1100001;
			end

			3'b010: begin // ornament (ornmnt)
			 //          6543210
				HEX0 = 7'b0000111;
				HEX1 = 7'b0101011;
				HEX2 = 7'b0001000;
				HEX3 = 7'b0101011;
				HEX4 = 7'b0101111;
				HEX5 = 7'b1000000;
			end

			3'b100: begin // suit
			 //          6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b0000111;
				HEX3 = 7'b1111001;
				HEX4 = 7'b1000001;
				HEX5 = 7'b0010010;
			end

			3'b101: begin // coat
			 //          6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b0000111;
				HEX3 = 7'b0001000;
				HEX4 = 7'b1000000;
				HEX5 = 7'b1000110;
			end

			3'b111: begin // socks
			 //          6543210
				HEX0 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX2 = 7'b0010010;
				HEX3 = 7'b1000110;
				HEX4 = 7'b1000000;
				HEX5 = 7'b0010010;
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

	assign D = P | (U & C);
endmodule

// Checks if a given object has been stolen based on its UPC code and if it has a mark (M).
module Stolen_Checker (S, U, P, C, M);
	output logic S;
	input logic U, P, C, M;

	assign S = ~(P | M | ~(U | ~C));
endmodule