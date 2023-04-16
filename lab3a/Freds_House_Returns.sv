module Freds_House_Returns (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [9:0] SW;
	logic U, P, C, D, S;
	logic [2:0] UPC;

  assign U = SW[9];
  assign P = SW[8];
  assign C = SW[7];
	Discount_Checker dc1 (.D(D), .U(U), .P(P), .C(C));
	Stolen_Checker sc1 (.S(S), .U(U), .P(P), .C(C), .M(SW[0]));
  UPC = {U, P, C};

	always_comb begin
		LEDR[9] = D;
		LEDR[0] = S;

    case (UPC)
      3'b000: begin // shoes
      //          6543210
        HEX0 = 7'b1101101;
        HEX1 = 7'b1110110;
        HEX2 = 7'b0111111;
        HEX3 = 7'b1111001;
        HEX4 = 7'b1101101;
      end

      3'b001: begin // costume jewelry (jwlry)
      //          6543210
        HEX0 = 7'b1111111;
        HEX1 = 7'b1111111;
        HEX2 = 7'b1111111;
        HEX3 = 7'b1111111;
        HEX4 = 7'b1111111;
        HEX5 = 7'b1111111;
      end

      3'b010: begin // ornament (ornmnt)
      //          6543210
        HEX0 = 7'b1111111;
        HEX1 = 7'b1111111;
        HEX2 = 7'b1111111;
        HEX3 = 7'b1111111;
        HEX4 = 7'b1111111;
        HEX5 = 7'b1111111;
      end

      3'b000: begin // suit
      //          6543210
        HEX0 = 7'b1111111;
        HEX1 = 7'b1111111;
        HEX2 = 7'b1111111;
        HEX3 = 7'b1111111;
        HEX4 = 7'b1111111;
        HEX5 = 7'b1111111;
      end

      3'b000: begin // coat
      //          6543210
        HEX0 = 7'b1111111;
        HEX1 = 7'b1111111;
        HEX2 = 7'b1111111;
        HEX3 = 7'b1111111;
        HEX4 = 7'b1111111;
        HEX5 = 7'b1111111;
      end

      3'b000: begin // socks
      //          6543210
        HEX0 = 7'b1111111;
        HEX1 = 7'b1111111;
        HEX2 = 7'b1111111;
        HEX3 = 7'b1111111;
        HEX4 = 7'b1111111;
        HEX5 = 7'b1111111;
      end

      default HEX0 = 7'b0000000;
      default HEX1 = 7'b0000000;
      default HEX2 = 7'b0000000;
      default HEX3 = 7'b0000000;
      default HEX4 = 7'b0000000;
      default HEX5 = 7'b0000000;
    endcase
	end
endmodule