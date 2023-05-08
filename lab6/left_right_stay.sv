module left_right_stay (clk, reset, l, r, led_start, led);
	input logic clk, reset, l, r;
	input logic [3:0] led_start;
	output logic [3:0] led;
	logic l_btn, r_btn, l_pressed, r_pressed;

	dff_pair dff_pairL(.clk(clk), .d(l), .q(l_btn));
	dff_pair dff_pairR(.clk(clk), .d(r), .q(r_btn));

	button_fsm btnL(.clk(clk), .reset(reset), .button(l_btn), .pressed(l_pressed));
	button_fsm btnR(.clk(clk), .reset(reset), .button(r_btn), .pressed(r_pressed));

	always_ff @(posedge clk) begin
		if (l_pressed & !r_pressed) begin
			led <= led_start - 1;
		end
		else if (!l_pressed & r_pressed) begin
			led <= led_start + 1;
		end
		else begin
			led <= led_start;
		end
	end
endmodule

module left_right_stay_testbench();
	logic CLOCK_50;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [3:0] led_start;
	logic [3:0] led;

	left_right_stay dut (CLOCK_50, SW[9], KEY[3], KEY[0], led_start, led);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
		assign led_start = 4'b0101;
										  repeat (1) @(posedge CLOCK_50);
		SW[9] <= 1;
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		SW[9] <= 0;
		KEY[3] <= 1; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		$stop;
	end
endmodule