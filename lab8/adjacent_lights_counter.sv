module adjacent_lights_counter (clk, n, ne, e, se, s, sw, w, nw, count);
	input logic clk;
	input logic n, ne, e, se, s, sw, w, nw;
	output reg count;
	reg [7:0] combined_inputs;

	always @* begin
		combined_inputs = {n, ne, e, se, s, sw, w, nw};

		count = 0;
		for (int i = 0; i < 8; i++) begin
			if (combined_inputs[i] == 1) begin
				count++;
			end
		end
	end
endmodule