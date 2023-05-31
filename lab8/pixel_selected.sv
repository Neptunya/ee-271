module pixel_selected (reset, setup, l, r, row_select, pixel_board, previous_x, previous_y, next_x, next_y)
	input logic reset;
	input logic left, right;
	input logic [7:0] row_select;
	input logic [7:0][7:0] pixel_board;
	output logic [7:0] next_x, next_y;
	output logic [8:0] previous_x, previous_y;
	logic [7:0][7:0] p_pix, n_pix;
	
	// check for a row that doesn't equal 0, then grab that row and find which led is on in that row
	// then assign to x and y for coords and plop in coords module
	// turn current_pixel off, and turn next_pixel on - do outside
	// if no pixels, set to (3, 3)
	always_comb begin
		previous_y = 8;
		previous_x = 8;
		
		// check columns, set to base coords if none are on
		for (int i = 0; i < 8; i++) begin
			if (pixel_board == 1) begin
				previous_y = i;
			end
		end
		if (previous_y == 8) begin
			previous_y = 3;
			previous_x = 3;
		end
		
		// get specific coord
		if (previous_x == 8) begin
			for (int i = 0; i < 8; i++) begin
				if (pixel_board[previous_y] == 1) begin
					previous_x = i;
				end
			end
		end
	end

endmodule