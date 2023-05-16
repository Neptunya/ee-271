module lfsr_10 (clk, reset, q_n);
	input logic clk, reset;
	output logic [9:0] q_n;
	logic [9:0] q;

	always_ff @(posedge clk) begin
		if (reset) begin
			q <= 10'b0;
		end
		else begin
			q <= {q[8:0], ~(q[6] ^ q[9])};
		end
	end
	assign q_n = q;
endmodule

module lfsr_10_testbench();
	logic CLOCK_50;
	logic [9:0] SW, q_n;
	logic d;
	lfsr_10 dut (CLOCK_50, SW[9], q_n);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
						repeat (1) @(posedge CLOCK_50);
		SW[9] = 1;	repeat (3) @(posedge CLOCK_50);
		SW[9] = 0;	repeat (100) @(posedge CLOCK_50);
		$stop;
	end

endmodule