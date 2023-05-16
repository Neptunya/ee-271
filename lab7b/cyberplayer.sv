module cyberplayer (clk, reset, winner, ctrl, tap);
	input logic clk, reset, winner;
	input logic [8:0] ctrl;
	output logic tap;
	logic [9:0] lvl, q;
	
	parameter COUNT_THRESHOLD = 7;
	
	logic [31:0] counter;

	assign lvl[9] = 0;
	assign lvl[8] = ctrl[8];
	assign lvl[7] = ctrl[7];
	assign lvl[6] = ctrl[6];
	assign lvl[5] = ctrl[5];
	assign lvl[4] = ctrl[4];
	assign lvl[3] = ctrl[3];
	assign lvl[2] = ctrl[2];
	assign lvl[1] = ctrl[1];
	assign lvl[0] = ctrl[0];
	
	lfsr_10 l10 (clk, reset, q);
	comparator_10 c10 (lvl, q, lvl_greater);

	always_ff @(posedge clk) begin
		if (reset | winner) begin
			counter <= 0;
			tap <= 0;  // Initial value of signal_out
    	end 
		else begin
			if (counter < COUNT_THRESHOLD) begin
				counter <= counter + 1;
				tap <= 0;
			end
			else begin
				tap <= lvl_greater;
			end
		end
	end
endmodule

module cyberplayer_testbench();
	logic CLOCK_50;
	logic [9:0] SW;
	logic [9:0] LEDR;

	cyberplayer dut (CLOCK_50, SW[9], SW[8:0], LEDR[0]);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
						repeat (1) @(posedge CLOCK_50);
		SW[0] <= 1;
		SW[1] <= 1;
		SW[2] <= 1;
		SW[3] <= 1;
		SW[4] <= 0;
		SW[5] <= 0;
		SW[6] <= 0;
		SW[7] <= 0;
		SW[8] <= 0;
		SW[9] <= 1; repeat (3) @(posedge CLOCK_50);
		SW[9] <= 0; repeat (20) @(posedge CLOCK_50);

	

		/* click
		KEY[3] <= 1; repeat (5) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		*/
		$stop;
	end
endmodule