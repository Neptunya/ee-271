module lfsr_10 (clk, reset, q, q_n);
	input logic [9:0] q;
	input logic clk, reset;
	output logic [9:0] q_n;
	logic d;
	logic [9:0] q_next;
	
	dff_single d0 (clk, d, q_next[0]);
	dff_single d1 (clk, q[0], q_next[1]);
	dff_single d2 (clk, q[1], q_next[2]);
	dff_single d3 (clk, q[2], q_next[3]);
	dff_single d4 (clk, q[3], q_next[4]);
	dff_single d5 (clk, q[4], q_next[5]);
	dff_single d6 (clk, q[5], q_next[6]);
	dff_single d7 (clk, q[6], q_next[7]);
	dff_single d8 (clk, q[7], q_next[8]);
	dff_single d9 (clk, q[8], q_next[9]);

	always_ff @(posedge clk) begin
		if (reset) begin
			assign q_next = 10'b0000000000;
		end
		else begin
			q_n <= q_next;
			d <= ~(q_n[6] ^ q_n[9]);
		end
	end
endmodule

module lfsr_10_testbench();
	logic CLOCK_50;
	logic [9:0] SW, q_n;
	logic d;
	lfsr_10 dut (CLOCK_50, SW[9], 10'b0000000000, q_n);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
						repeat (1) @(posedge CLOCK_50);
		SW[9] = 1;	repeat (3) @(posedge CLOCK_50);
		SW[9] = 0;	repeat (20) @(posedge CLOCK_50);
		$stop;
	end

endmodule