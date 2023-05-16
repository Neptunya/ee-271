module cyberplayer (clk, reset, ctrl, advance);
	input logic clk;
	input logic [9:0] ctrl;
	output logic advance;
	logic [9:0] d;

	initial begin
		assign d = 10'b0000000000;
	end

	lsfr_10(clk, reset, d, q);
	comparator_10(q, ctrl, q_greater);

	always_ff @(posedge clk) begin
		advance <= q_greater;
		d <= q;
	end
endmodule