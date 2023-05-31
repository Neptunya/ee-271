module pixel_start (clk, reset, n, ne, e, se, s, sw, w, nw, toggle, light_selected, setup, light_on);
	input logic clk, reset; // standard inputs
	input logic n, ne, e, se, s, sw, w, nw; // adjacent light statuses
	input logic toggle; // switch light state (run the button press through a dff so it's only up for 1 clock cycle)
	input logic light_selected; // is light's red pixel on?
	input logic setup; // setup switch that determines current state;
	input logic [8:0] row;
	output logic light_on; // determines light's green pixel state
	reg count;

	enum { setup_off, setup_on, game_off, game_on, idle } ps, ns;
	adjacent_lights_counter alc (.clk(clk), .n(n), .ne(ne), .e(e), .se(se), .s(s), .sw(sw), .w(w), .nw(nw), .count(count));

	always_comb begin
		case (ps)
			game_off:
				if (setup) begin
					ns = setup_off;
				end
				else if (count == 3) begin
					ns = game_on;
				end
				else begin
					ns = game_off;
				end

			game_on:
				if (setup) begin
					ns = setup_on;
				end
				else if (count == 2 | count == 3) begin
					ns = game_on;
				end
				else begin
					ns = game_off;
				end

			setup_off:
				if (!setup) begin
					ns = game_off;
				end
				else if (light_selected & toggle) begin
					ns = setup_on;
				end
				else begin
					ns = setup_off;
				end

			setup_on:
				if (!setup) begin
					ns = game_on;
				end
				else if (light_selected & toggle) begin
					ns = setup_off;
				end
				else begin
					ns = setup_on;
				end

			idle:
				if (setup) begin
					ns = setup_on;
				end
				else begin
					ns = game_on;
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
				game_on, setup_on, idle:
					light_on = 1;
				game_off, setup_off:
					light_on = 0;
			endcase
		end
	end
endmodule