module normal_light (clk, reset, l, r, nl, nr, light_on);
	input logic clk, reset;
	input logic l, r, nl, nr;
	output logic light_on;

	enum { on, to_left, to_right, idle } ps, ns;

	always_comb begin
		case (ps)
			on:
				if (l & ~r) begin
					ns = to_left;
				end
				else if (r & ~l) begin
					ns = to_right;
				end
				else begin
					ns = on;
				end
			to_left:
				if (~nl) begin
					ns = idle;
				end
				else if (l & ~r & nl) begin
					ns = idle;
				end
				else if (r & ~l & nl) begin
					ns = on;
				end
				else begin
					ns = to_left;
				end
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
				if (nl) begin
					ns = to_left;
				end
				else if (nr) begin
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
		end
		else begin
			ps <= ns;
			case (ps)
				on:
					light_on <= 1'b1;
				to_left, to_right, idle:
					light_on <= 1'b0;
			endcase
		end
	end
endmodule
