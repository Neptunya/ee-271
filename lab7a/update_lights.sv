module update_lights (clk, reset, l, r, c_led, n_led);
	input logic clk, reset, l , r;
	input logic [4:0] c_led;
	output logic [4:0] n_led;
	
	always_comb begin
		previous_led = current_led;
		left_right_stay lrs(.led_on(n_led), .clk(clk), .reset(reset), .l(~l), .r(~r), .led_start(c_led));
	end
	
	always_ff @(posedge CLOCK_50) begin
		LEDR[c_led] <= 1'b0;
		LEDR[n_led] <= 1'b1;
	end
endmodule