module landing_lights (clk, reset, x, y, out);
	input logic clk, reset, x, y;
	output logic [2:0] out;
	
	// State variables
	enum { calm1, calm2, right_left1, right_left2, right_left3, left_right1, left_right2, left_right3, none } ps, ns;
	
	// Next State logic
	always_comb begin
		case (ps)
			calm1: 		 if (~x & ~y)		 begin ns = calm2; 		 out = 3'b010; end
							 else if (~x & y)  begin ns = right_left1; out = 3'b001; end
							 else if (x & ~y)  begin ns = left_right1; out = 3'b100; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			calm2: 		 if (~x & ~y)		 begin ns = calm1; 		 out = 3'b101; end
							 else if (~x & y)  begin ns = right_left1; out = 3'b001; end
							 else if (x & ~y)  begin ns = left_right1; out = 3'b100; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			right_left1: if (~x & y) 		 begin ns = right_left2; out = 3'b010; end
							 else if (~x & ~y) begin ns = calm1; 		 out = 3'b101; end
							 else if (x & ~y)  begin ns = left_right1; out = 3'b100; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			right_left2: if (~x & y) 		 begin ns = right_left3; out = 3'b100; end
							 else if (~x & ~y) begin ns = calm1; 		 out = 3'b101; end
							 else if (x & ~y)  begin ns = left_right1; out = 3'b100; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			right_left3: if (~x & y) 		 begin ns = right_left1; out = 3'b001; end
							 else if (~x & ~y) begin ns = calm1; 		 out = 3'b101; end
							 else if (x & ~y)  begin ns = left_right1; out = 3'b100; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			left_right1: if (x & ~y) 		 begin ns = left_right2; out = 3'b010; end
							 else if (~x & ~y) begin ns = calm1; 		 out = 3'b101; end
							 else if (~x & y)  begin ns = right_left1; out = 3'b001; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			left_right2: if (x & ~y) 		 begin ns = left_right3; out = 3'b001; end
							 else if (~x & ~y) begin ns = calm1; 		 out = 3'b101; end
							 else if (~x & y)  begin ns = right_left1; out = 3'b001; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			left_right3: if (x & ~y)		 begin ns = left_right1; out = 3'b100; end
							 else if (~x & ~y) begin ns = calm1; 		 out = 3'b101; end
							 else if (~x & y)  begin ns = right_left1; out = 3'b001; end
							 else 				 begin ns = none; 		 out = 3'b111; end
			none:			 if (~x & ~y)		 begin ns = calm1; 		 out = 3'b101; end
							 else if (~x & y)	 begin ns = right_left1; out = 3'b001; end
							 else if (x & ~y)  begin ns = left_right1; out = 3'b100; end
							 else 				 begin ns = none; 		 out = 3'b111; end
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= none;
		else
			ps <= ns;
	end
endmodule