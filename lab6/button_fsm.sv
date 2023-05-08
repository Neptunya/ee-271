// button active only for one cycle fsm
// set middle led as true then feed it into a left/right/stay module, wrap that in a while loop until LED[X] goes above 9 or below 0

module button_fsm (clk, reset, button, pressed);
	input logic clk, reset, button;
	output logic pressed;
	
	enum { idle, button_pressed, long_press } ps, ns;
	
	always_comb begin
		case (ps)
			idle: 
				if (button) begin
					pressed <= 1'b1;
					ns <= button_pressed;
				end
				else begin
					pressed <= 1'b0;
					ns <= idle;
				end
			button_pressed:
				if (!button) begin
					pressed <= 1'b0;
					ns <= idle;
				end
				else begin
					pressed <= 1'b0;
					ns <= long_press;
				end
			long_press:
				if (!button) begin
					pressed <= 1'b0;
					ns <= idle;
				end
				else begin
					pressed <= 1'b0;
					ns <= long_press;
				end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= idle;
		else
			ps <= ns;
	end
endmodule

module button_fsm_testbench();
	logic CLOCK_50;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	button_fsm dut (CLOCK_50, SW[9], KEY[0], LEDR[0]);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	initial begin
										 repeat (1) @(posedge CLOCK_50);
		KEY[0] <= 0; SW[9] <= 1; repeat (1) @(posedge CLOCK_50);
		KEY[0] <= 0; SW[9] <= 0; repeat (1) @(posedge CLOCK_50);
		KEY[0] <= 1; 				 repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; 				 repeat (1) @(posedge CLOCK_50);
		KEY[0] <= 1; 				 repeat (1) @(posedge CLOCK_50);
		KEY[0] <= 0; 				 repeat (3) @(posedge CLOCK_50);
		$stop;
	end
endmodule