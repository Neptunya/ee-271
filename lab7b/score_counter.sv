module score_counter (clk, reset, l, r, reset_round, l_hex, r_hex);
	input logic clk, reset;
	input logic l, r;
	output logic reset_round;
	output logic [6:0] l_hex, r_hex;
	logic [2:0] l_count, r_count;
	logic l_win, r_win;
	
	button_fsm win1(.clk(clk), .reset(reset), .button(l), .pressed(l_win));
	button_fsm win2(.clk(clk), .reset(reset), .button(r), .pressed(r_win));
	
	enum { l_won, r_won, game_over, clean_up, idle } ps, ns;
	
	always_comb begin
		case (ps)
			idle:
				if (l_win) begin
					ns = l_won;
				end
				else if (r_win) begin
					ns = r_won;
				end
				else begin
					ns = idle;
				end
			l_won:
				if (l_count < 3'b110) begin
					ns = clean_up;
				end
				else begin
					ns = game_over;
				end
			r_won:
				if (r_count < 3'b110) begin
					ns = clean_up;
				end
				else begin
					ns = game_over;
				end
			game_over:
				ns = game_over;
			clean_up:
				ns = idle;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			l_count <= 3'b000;
			r_count <= 3'b000;
			reset_round <= 1;
			ps <= idle;
		end
		else begin
			ps <= ns;
			case (ps)
				idle: begin
					reset_round <= 0;
					l_count <= l_count;
					r_count <= r_count;
				end
				l_won: begin
					l_count <= l_count + 1;
					r_count <= r_count;
				end
				r_won: begin
					l_count <= l_count;
					r_count <= r_count + 1;
				end
				clean_up: begin
					reset_round <= 1;
					l_count <= l_count;
					r_count <= r_count;
				end
				game_over: begin
					l_count <= l_count;
					r_count <= r_count;
				end
			endcase
		end
		
		case (l_count)
			3'b000: begin l_hex <= 7'b1000000; end
			3'b001: begin l_hex <= 7'b1111001; end
			3'b010: begin l_hex <= 7'b0100100; end
			3'b011: begin l_hex <= 7'b0110000; end
			3'b100: begin l_hex <= 7'b0011001; end
			3'b101: begin l_hex <= 7'b0010010; end
			3'b110: begin l_hex <= 7'b0000010; end
			3'b111: begin l_hex <= 7'b1111000; end
		endcase
		
		case (r_count)
			3'b000: begin r_hex <= 7'b1000000; end
			3'b001: begin r_hex <= 7'b1111001; end
			3'b010: begin r_hex <= 7'b0100100; end
			3'b011: begin r_hex <= 7'b0110000; end
			3'b100: begin r_hex <= 7'b0011001; end
			3'b101: begin r_hex <= 7'b0010010; end
			3'b110: begin r_hex <= 7'b0000010; end
			3'b111: begin r_hex <= 7'b1111000; end
		endcase
	end
endmodule