module DE1_SoC (CLOCK_50, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	logic l_btn, r_btn, l_pressed, r_pressed, l, r;
	logic [1:0] winner;

	dff_pair dff_pairL(.clk(CLOCK_50), .d(l), .q(l_btn));
	dff_pair dff_pairR(.clk(CLOCK_50), .d(r), .q(r_btn));

	button_fsm btnL(.clk(CLOCK_50), .reset(SW[9]), .button(l_btn), .pressed(l_pressed));
	button_fsm btnR(.clk(CLOCK_50), .reset(SW[9]), .button(r_btn), .pressed(r_pressed));

	end_light_right elr(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[2], LEDR[1], winner);
	normal_light nl2(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[3], LEDR[1], LEDR[2]);
	normal_light nl3(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[4], LEDR[2], LEDR[3]);
	normal_light nl4(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[5], LEDR[3], LEDR[4]);
	center_light cl(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[6], LEDR[4], LEDR[5]);
	normal_light nl6(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[7], LEDR[5], LEDR[6]);
	normal_light nl7(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[8], LEDR[6], LEDR[7]);
	normal_light nl8(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[9], LEDR[7], LEDR[8]);
	end_light_left ell(CLOCK_50, SW[9], l_pressed, r_pressed, LEDR[8], LEDR[9], winner);

	always_comb begin
		case (winner)
			2'b01: begin
				HEX5 <= 7'b1111111;
			end
			2'b10: begin
				HEX5 <= 7'b1111111;
			end
			default: begin
				HEX5 <= 7'b1111111;
			end
		endcase
	end

	always_ff @(posedge CLOCK_50) begin
		if (SW[9]) begin
			winner <= 2'b00;
		end
		else begin
			winner <= winner;
			l <= KEY[3];
			r <= KEY[0];
		end
	end
endmodule

module DE1_SOC_testbench();
	logic CLOCK_50; // 50MHz clock.
	logic [6:0] HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;

	DE1_SoC dut (CLOCK_50, HEX5, KEY, LEDR, SW);

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
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);

		/* left win w/overshooting
		KEY[3] <= 1; KEY[0] <= 0; repeat (5) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (5) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		*/

		/* right win w/overshooting
		KEY[3] <= 0; KEY[0] <= 1; repeat (5) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (5) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		*/

		/* spam click test
		KEY[3] <= 0; KEY[0] <= 1; repeat (2) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (2) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (2) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (2) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (2) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (2) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (1) @(posedge CLOCK_50);
		*/

		/* overlapping inputs test
		KEY[3] <= 1; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		*/
		$stop;
	end
endmodule