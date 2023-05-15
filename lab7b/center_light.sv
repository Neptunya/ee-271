module center_light (clk, reset, l, r, nl, nr, light_on);
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
			ps <= on;
			light_on <= 1;
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
module center_light_testbench();
	logic CLOCK_50;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic l_btn, r_btn, l_pressed, r_pressed;

	dff_pair dff_pairL(.clk(CLOCK_50), .d(KEY[3]), .q(l_btn));
	dff_pair dff_pairR(.clk(CLOCK_50), .d(KEY[0]), .q(r_btn));

	button_fsm btnL(.clk(CLOCK_50), .reset(SW[9]), .button(l_btn), .pressed(l_pressed));
	button_fsm btnR(.clk(CLOCK_50), .reset(SW[9]), .button(r_btn), .pressed(r_pressed));

	center_light dut (CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[6], LEDR[4], LEDR[5]);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
										  repeat (1) @(posedge CLOCK_50);
		SW[9] <= 1;
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		SW[9] <= 0;
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 1; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		$stop;
	end
endmodule
