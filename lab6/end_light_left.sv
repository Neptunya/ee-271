module end_light_left (clk, reset, l, r, nr, light_on, winner);
	input logic clk, reset;
	input logic l, r, nr;
	output logic light_on;
	output logic winner;

	enum { on, to_right, game_over, idle } ps, ns;

	always_comb begin
		case (ps)
			on:
				if (l & ~r) begin
					ns = game_over;
				end
				else if (r & ~l) begin
					ns = to_right;
				end
				else begin
					ns = on;
				end
			game_over:
				ns = game_over;
			to_right:
				if (~nr) begin
					ns = idle;
				end
				else if (r & ~l & nr) begin
					ns = idle;
				end
				else if (l & ~r & nr) begin
					ns = on;
				end
				else begin
					ns = to_right;
				end
			idle:
				if (nr) begin
					ns = to_right;
				end
				else begin
					ns = idle;
				end
		endcase
	end

	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= idle;
			winner <= 0;
		end
		else begin
			ps <= ns;
			case (ps)
				on: begin
					light_on <= 1'b1;
				end
				to_right, idle: begin
					light_on <= 1'b0;
				end
				game_over: begin
					light_on <= 1'b0;
					winner <= 1'b1;
				end
			endcase
		end
	end
endmodule