module pixel_selected_coords (reset, left, right, row_select, current_x, current_y, next_x, next_y);
	input logic reset;
	input logic left, right; // run through fsm so only up for 1 clock input
	input logic [7:0] row_select;
	input reg current_x, current_y;
	output reg next_x, next_y;

	always_comb begin
		if (reset) begin
			next_x = 0;
			next_y = 0;
		end
		else begin
			// left right stuff
			if (left & !right) begin
				next_x = current_x + 1;
			end
			else if (right & !left) begin
				next_x = current_x - 1;
			end
			else begin
				next_x = current_x;
			end

			// row stuff
			if (column_select == 0) begin
				next_y = current_y;
			end
			else begin
				for (int i = 0; i < 8; i++) begin
					if (row_select[i] == 1) begin
						next_y = i;
					end
				end
			end
		end
	end
endmodule