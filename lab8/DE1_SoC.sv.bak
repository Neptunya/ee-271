// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
   output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
   input  logic [3:0]  KEY;
   input  logic [9:0]  SW;
   output logic [35:0] GPIO_1;
   input logic CLOCK_50;

	logic led_g00, led_g01, led_g02, led_g03, led_g04, led_g05, led_g06, led_g07;
	logic led_g10, led_g11, led_g12, led_g13, led_g14, led_g15, led_g16, led_g17;
	logic led_g20, led_g21, led_g22, led_g23, led_g24, led_g25, led_g26, led_g27;
	logic led_g30, led_g31, led_g32, led_g33, led_g34, led_g35, led_g36, led_g37;
	logic led_g40, led_g41, led_g42, led_g43, led_g44, led_g45, led_g46, led_g47;
	logic led_g50, led_g51, led_g52, led_g53, led_g54, led_g55, led_g56, led_g57;
	logic led_g60, led_g61, led_g62, led_g63, led_g64, led_g65, led_g66, led_g67;
	logic led_g70, led_g71, led_g72, led_g73, led_g74, led_g75, led_g76, led_g77;
	logic [7:0] next_x, next_y;
	logic [8:0] current_x, current_y;
	logic [7:0] board;


	// Turn off HEX displays
   assign HEX0 = '1;
   assign HEX1 = '1;
   assign HEX2 = '1;
   assign HEX3 = '1;
   assign HEX4 = '1;
   assign HEX5 = '1;


	/* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	   ===========================================================*/
	logic [31:0] clk;
	logic SYSTEM_CLOCK;

	clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));

	assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal

	/* If you notice flickering, set SYSTEM_CLOCK faster.
	   However, this may reduce the brightness of the LED board. */


	/* Set up LED board driver
	   ================================================================== */
	logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
   logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	logic RST;                   // reset - toggle this on startup

	assign RST = SW[9];
	assign toggle = ~KEY[3];
	assign setup = SW[8];
	assign board = RedPixels[7:0];

	/* Standard LED Driver instantiation - set once and 'forget it'.
	   See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);


	/* LED board test submodule - paints the board with a static pattern.
		Replace with your own code driving RedPixels and GrnPixels.

		KEY0      : Reset
		=================================================================== */
	pixel_selected p_slct (.clk(SYSTEM_CLOCK), .reset(RST), .l(~KEY[0]), .r(~KEY[1]), .row_select(SW[7:0]), .pixel_board(board[7:0]), .current_x, .current_y, .next_x, .next_y);
	pixel_norm pn_00 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g10), .ne(led_g11), .e(led_g01), .se(led_g71), .s(led_g70), .sw(led_g77), .w(led_g07), .nw(led_g17), .toggle, .light_selected(RedPixels[00][00]), .setup, .light_on(GrnPixels[00][00]));
	pixel_norm pn_01 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g11), .ne(led_g12), .e(led_g02), .se(led_g72), .s(led_g71), .sw(led_g70), .w(led_g00), .nw(led_g10), .toggle, .light_selected(RedPixels[00][01]), .setup, .light_on(GrnPixels[00][01]));
	pixel_norm pn_02 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g12), .ne(led_g13), .e(led_g03), .se(led_g73), .s(led_g72), .sw(led_g71), .w(led_g01), .nw(led_g11), .toggle, .light_selected(RedPixels[00][02]), .setup, .light_on(GrnPixels[00][02]));
	pixel_norm pn_03 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g13), .ne(led_g14), .e(led_g04), .se(led_g74), .s(led_g73), .sw(led_g72), .w(led_g02), .nw(led_g12), .toggle, .light_selected(RedPixels[00][03]), .setup, .light_on(GrnPixels[00][03]));

	pixel_norm pn_10 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g20), .ne(led_g21), .e(led_g11), .se(led_g01), .s(led_g00), .sw(led_g07), .w(led_g17), .nw(led_g17), .toggle, .light_selected(RedPixels[01][00]), .setup, .light_on(GrnPixels[01][00]));
	pixel_norm pn_11 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g21), .ne(led_g22), .e(led_g12), .se(led_g02), .s(led_g01), .sw(led_g00), .w(led_g10), .nw(led_g10), .toggle, .light_selected(RedPixels[01][01]), .setup, .light_on(GrnPixels[01][01]));
	pixel_norm pn_12 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g22), .ne(led_g23), .e(led_g13), .se(led_g03), .s(led_g02), .sw(led_g01), .w(led_g11), .nw(led_g11), .toggle, .light_selected(RedPixels[01][02]), .setup, .light_on(GrnPixels[01][02]));
	pixel_norm pn_13 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g23), .ne(led_g24), .e(led_g14), .se(led_g04), .s(led_g03), .sw(led_g02), .w(led_g12), .nw(led_g12), .toggle, .light_selected(RedPixels[01][03]), .setup, .light_on(GrnPixels[01][03]));

	pixel_norm pn_20 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g30), .ne(led_g31), .e(led_g21), .se(led_g11), .s(led_g10), .sw(led_g17), .w(led_g27), .nw(led_g17), .toggle, .light_selected(RedPixels[02][00]), .setup, .light_on(GrnPixels[02][00]));
	pixel_norm pn_21 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g31), .ne(led_g32), .e(led_g22), .se(led_g12), .s(led_g11), .sw(led_g10), .w(led_g20), .nw(led_g10), .toggle, .light_selected(RedPixels[02][01]), .setup, .light_on(GrnPixels[02][01]));
	pixel_norm pn_22 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g32), .ne(led_g33), .e(led_g23), .se(led_g13), .s(led_g12), .sw(led_g11), .w(led_g21), .nw(led_g11), .toggle, .light_selected(RedPixels[02][02]), .setup, .light_on(GrnPixels[02][02]));
	pixel_norm pn_23 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g33), .ne(led_g34), .e(led_g24), .se(led_g14), .s(led_g13), .sw(led_g12), .w(led_g22), .nw(led_g12), .toggle, .light_selected(RedPixels[02][03]), .setup, .light_on(GrnPixels[02][03]));

	pixel_norm pn_30 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g40), .ne(led_g41), .e(led_g31), .se(led_g21), .s(led_g20), .sw(led_g27), .w(led_g37), .nw(led_g47), .toggle, .light_selected(RedPixels[03][00]), .setup, .light_on(GrnPixels[03][00]));
	pixel_norm pn_31 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g41), .ne(led_g42), .e(led_g32), .se(led_g22), .s(led_g21), .sw(led_g20), .w(led_g30), .nw(led_g40), .toggle, .light_selected(RedPixels[03][01]), .setup, .light_on(GrnPixels[03][01]));
	pixel_norm pn_32 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g42), .ne(led_g43), .e(led_g33), .se(led_g23), .s(led_g22), .sw(led_g21), .w(led_g31), .nw(led_g41), .toggle, .light_selected(RedPixels[03][02]), .setup, .light_on(GrnPixels[03][02]));
	pixel_norm pn_33 (.clk(SYSTEM_CLOCK), .reset(RST), .n(led_g43), .ne(led_g44), .e(led_g34), .se(led_g24), .s(led_g23), .sw(led_g22), .w(led_g32), .nw(led_g42), .toggle, .light_selected(RedPixels[03][03]), .setup, .light_on(GrnPixels[03][03]));

	always_ff @(posedge SYSTEM_CLOCK) begin
		if (RST) begin
			led_g00 <= 0;
			led_g01 <= 0;
			led_g02 <= 0;
			led_g03 <= 0;
			led_g04 <= 0;
			led_g05 <= 0;
			led_g06 <= 0;
			led_g07 <= 0;

			led_g10 <= 0;
			led_g11 <= 0;
			led_g12 <= 0;
			led_g13 <= 0;
			led_g14 <= 0;
			led_g15 <= 0;
			led_g16 <= 0;
			led_g17 <= 0;

			led_g20 <= 0;
			led_g21 <= 0;
			led_g22 <= 0;
			led_g23 <= 0;
			led_g24 <= 0;
			led_g25 <= 0;
			led_g26 <= 0;
			led_g27 <= 0;

			led_g30 <= 0;
			led_g31 <= 0;
			led_g32 <= 0;
			led_g33 <= 0;
			led_g34 <= 0;
			led_g35 <= 0;
			led_g36 <= 0;
			led_g37 <= 0;

			led_g40 <= 0;
			led_g41 <= 0;
			led_g42 <= 0;
			led_g43 <= 0;
			led_g44 <= 0;
			led_g45 <= 0;
			led_g46 <= 0;
			led_g47 <= 0;

			led_g50 <= 0;
			led_g51 <= 0;
			led_g52 <= 0;
			led_g53 <= 0;
			led_g54 <= 0;
			led_g55 <= 0;
			led_g56 <= 0;
			led_g57 <= 0;

			led_g60 <= 0;
			led_g61 <= 0;
			led_g62 <= 0;
			led_g63 <= 0;
			led_g64 <= 0;
			led_g65 <= 0;
			led_g66 <= 0;
			led_g67 <= 0;

			led_g70 <= 0;
			led_g71 <= 0;
			led_g72 <= 0;
			led_g73 <= 0;
			led_g74 <= 0;
			led_g75 <= 0;
			led_g76 <= 0;
			led_g77 <= 0;
		end

		else begin
			led_g00 <= GrnPixels[00][00];
			led_g01 <= GrnPixels[00][01];
			led_g02 <= GrnPixels[00][02];
			led_g03 <= GrnPixels[00][03];
			led_g04 <= GrnPixels[00][04];
			led_g05 <= GrnPixels[00][05];
			led_g06 <= GrnPixels[00][06];
			led_g07 <= GrnPixels[00][07];

			led_g10 <= GrnPixels[01][00];
			led_g11 <= GrnPixels[01][01];
			led_g12 <= GrnPixels[01][02];
			led_g13 <= GrnPixels[01][03];
			led_g14 <= GrnPixels[01][04];
			led_g15 <= GrnPixels[01][05];
			led_g16 <= GrnPixels[01][06];
			led_g17 <= GrnPixels[01][07];

			led_g20 <= GrnPixels[02][00];
			led_g21 <= GrnPixels[02][01];
			led_g22 <= GrnPixels[02][02];
			led_g23 <= GrnPixels[02][03];
			led_g24 <= GrnPixels[02][04];
			led_g25 <= GrnPixels[02][05];
			led_g26 <= GrnPixels[02][06];
			led_g27 <= GrnPixels[02][07];

			led_g30 <= GrnPixels[03][00];
			led_g31 <= GrnPixels[03][01];
			led_g32 <= GrnPixels[03][02];
			led_g33 <= GrnPixels[03][03];
			led_g34 <= GrnPixels[03][04];
			led_g35 <= GrnPixels[03][05];
			led_g36 <= GrnPixels[03][06];
			led_g37 <= GrnPixels[03][07];

			led_g40 <= GrnPixels[04][00];
			led_g41 <= GrnPixels[04][01];
			led_g42 <= GrnPixels[04][02];
			led_g43 <= GrnPixels[04][03];
			led_g44 <= GrnPixels[04][04];
			led_g45 <= GrnPixels[04][05];
			led_g46 <= GrnPixels[04][06];
			led_g47 <= GrnPixels[04][07];

			led_g50 <= GrnPixels[05][00];
			led_g51 <= GrnPixels[05][01];
			led_g52 <= GrnPixels[05][02];
			led_g53 <= GrnPixels[05][03];
			led_g54 <= GrnPixels[05][04];
			led_g55 <= GrnPixels[05][05];
			led_g56 <= GrnPixels[05][06];
			led_g57 <= GrnPixels[05][07];

			led_g60 <= GrnPixels[06][00];
			led_g61 <= GrnPixels[06][01];
			led_g62 <= GrnPixels[06][02];
			led_g63 <= GrnPixels[06][03];
			led_g64 <= GrnPixels[06][04];
			led_g65 <= GrnPixels[06][05];
			led_g66 <= GrnPixels[06][06];
			led_g67 <= GrnPixels[06][07];

			led_g70 <= GrnPixels[07][00];
			led_g71 <= GrnPixels[07][01];
			led_g72 <= GrnPixels[07][02];
			led_g73 <= GrnPixels[07][03];
			led_g74 <= GrnPixels[07][04];
			led_g75 <= GrnPixels[07][05];
			led_g76 <= GrnPixels[07][06];
			led_g77 <= GrnPixels[07][07];

			RedPixels[next_y][next_x] <= 1;
			RedPixels[current_y][current_x] <= 0;
		end
	end
endmodule