module pixel_selected_coords (clk, reset, l, r, row_select, pixel_board, current_x, current_y, next_x, next_y);
	input logic clk, reset;
	input logic l, r; // run through fsm so only up for 1 clock input
	input logic [7:0] row_select;
	input logic [7:0][7:0] pixel_board;
	input logic [7:0] current_x, current_y;
	output logic [7:0] next_x, next_y;
	

	always_ff @(posedge clk) begin
		if (reset) begin
			next_x = 0;
			next_y = 0;
		end
		else begin
			if (row_select != 0) begin
				for (int i = 0; i < 8; i++) begin
					if (row_select[i] != 0) begin
						next_y = i;
					end
				end
			end
			else begin
				next_y = 0;
			end
			
			if (l & !r) begin
				next_x = current_x + 1;
			end
			else if (r & !l) begin
				next_x = current_x - 1;
			end
		end
	end
endmodule