module DE1_SoC (CLOCK_50, HEX5, HEX0, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX5, HEX0;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	logic l_btn, r_btn, l_pressed, r_pressed, l, r, l_winner, r_winner, l_win, r_win;
	logic led1, led2, led3, led4, led5, led6, led7, led8, led9;
	logic reset_round, soft_reset;

	dff_pair dff_pairL(.clk(CLOCK_50), .d(l), .q(l_btn));
	dff_pair dff_pairR(.clk(CLOCK_50), .d(r), .q(r_btn));

	button_fsm btnL(.clk(CLOCK_50), .reset(reset_round), .button(l_btn), .pressed(l_pressed));
	button_fsm btnR(.clk(CLOCK_50), .reset(reset_round), .button(r_btn), .pressed(r_pressed));

	end_light_right elr(CLOCK_50, reset_round, l_pressed, r_pressed, led2, LEDR[1], r_winner);
	normal_light nl2(CLOCK_50, reset_round, l_pressed, r_pressed, led3, led1, LEDR[2]);
	normal_light nl3(CLOCK_50, reset_round, l_pressed, r_pressed, led4, led2, LEDR[3]);
	normal_light nl4(CLOCK_50, reset_round, l_pressed, r_pressed, led5, led3, LEDR[4]);
	center_light cl(CLOCK_50, reset_round, l_pressed, r_pressed, led6, led4, LEDR[5]);
	normal_light nl6(CLOCK_50, reset_round, l_pressed, r_pressed, led7, led5, LEDR[6]);
	normal_light nl7(CLOCK_50, reset_round, l_pressed, r_pressed, led8, led6, LEDR[7]);
	normal_light nl8(CLOCK_50, reset_round, l_pressed, r_pressed, led9, led7, LEDR[8]);
	end_light_left ell(CLOCK_50, reset_round, l_pressed, r_pressed, led8, LEDR[9], l_winner);
	
	score_counter sc1(CLOCK_50, SW[9], l_win, r_win, reset_round, HEX5, HEX0);

	always_ff @(posedge CLOCK_50) begin
		soft_reset <= SW[9] | reset_round;
		if (reset_round) begin
			led1 <= 0;
			led2 <= 0;
			led3 <= 0;
			led4 <= 0;
			led5 <= 0;
			led6 <= 0;
			led7 <= 0;
			led8 <= 0;
			led9 <= 0;
		end
		
		led1 <= LEDR[1];
		led2 <= LEDR[2];
		led3 <= LEDR[3];
		led4 <= LEDR[4];
		led5 <= LEDR[5];
		led6 <= LEDR[6];
		led7 <= LEDR[7];
		led8 <= LEDR[8];
		led9 <= LEDR[9];
		
		l <= KEY[3];
		r <= KEY[0];
		
		l_win <= l_winner;
		r_win <= r_winner;
	end
endmodule

module DE1_SOC_testbench();
	logic CLOCK_50; 
	logic [6:0] HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; 
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
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[9] <= 0;
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);

		/* back and forth
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		*/

		// left win then right win
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
		KEY[3] <= 0; KEY[0] <= 0; repeat (6) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (6) @(posedge CLOCK_50);
		

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
		

		/* overlapping inputs test
		KEY[3] <= 1; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 1; repeat (5) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		*/
		$stop;
	end
endmodule