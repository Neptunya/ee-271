module dff_pair(clk, d, q);
	input logic clk, d;
	output logic q;
	logic intermediate_q;

	dff_single dff1(.clk(clk), .d(d), .q(intermediate_q));
	dff_single dff2(.clk(clk), .d(d), .q(q));
endmodule