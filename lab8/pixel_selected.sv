module pixel_selected (clk, reset, l, r, row_select, pixel_board, current_x, current_y, next_x, next_y);
	input logic clk, reset;
	input logic l, r;
	input logic [7:0] row_select;
	input logic [7:0][7:0] pixel_board;
	output logic [7:0] next_x, next_y;
	output logic [8:0] current_x, current_y;

	// check for a row that doesn't equal 0, then grab that row and find which led is on in that row
	// then assign to x and y for coords and plop in coords module
	// turn current_pixel off, and turn next_pixel on - do outside
	// if no pixels, set to (3, 3)

	always_comb begin
		if (reset) begin
			current_y = 0;
			current_x = 0;
		end
		else begin
			current_y = 8;
			// check columns, set to base coords if none are on
			for (int i = 0; i < 8; i++) begin
				if (pixel_board[i] == 1) begin
					current_y = i;
					for (int j = 0; j < 8; j++) begin
						if (pixel_board[i][j] == 1) begin
							current_x = j;
							break;
						end
					end
				end
			end
			
			if (current_y == 8) begin
				current_y = 0;
			end
		end
	end
	pixel_selected_coords psc (.clk(clk), .reset(reset), .l(l), .r(r), .row_select(row_select), .pixel_board, .current_x(current_x), .current_y(current_y), .next_x(next_x), .next_y(next_y));
endmodule