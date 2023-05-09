module end_light_right (clk, reset, l, r, nl, light_on, winner);
	input logic clk, reset;
	input logic l, r, nl;
	output logic light_on;
	output logic [1:0] winner;

	enum { on, to_left, game_over, idle } ps, ns;

	always_comb begin
		case (ps)
			on:
				if (l & ~r) begin
					ns = to_left;
				end
				else if (r & ~l) begin
					ns = game_over;
				end
				else begin
					ns = on;
				end
			to_left:
				if (r & ~l) begin
					ns = on;
				end
				else if (l & ~r) begin
					ns = idle;
				end
				else begin
					ns = to_left;
				end
			game_over:
				ns = game_over;
			idle:
				if (nl) begin
					ns = to_left;
				end
				else begin
					ns = idle;
				end
		endcase
	end

	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= idle;
			light_on <= 1'b0;
			winner <= 2'b00;
		end
		else begin
			ps <= ns;
			case (ps)
				on: begin
					light_on <= 1'b1;
				end
				to_left: begin
					light_on <= 1'b0;
				end
				game_over: begin
					light_on <= 1'b0;
					winner <= 2'b10;
				end
				idle: begin
					light_on <= light_on;
				end
			endcase
		end
	end
endmodule