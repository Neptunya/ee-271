module dff_single (clk, d, q);
	input logic clk, d;
	output logic q;

	always @(posedge clk) begin
		q <= d;
	end
endmodule