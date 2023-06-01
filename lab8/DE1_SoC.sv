// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (KEY, SW, GPIO_1, CLOCK_50);
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
	logic [7:0] current_x, current_y;
	logic [7:0] board;
	
	logic t_btn, l_btn, r_btn;


	/* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	   ===========================================================*/
	logic [31:0] clk;
	logic GAME_CLOCK, SYSTEM_CLOCK;

	clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));

	assign GAME_CLOCK = clk[20];
	assign SYSTEM_CLOCK = clk[14]; // 

	/* If you notice flickering, set GAME_CLOCK faster.
	   However, this may reduce the brightness of the LED board. */


	/* Set up LED board driver
	   ================================================================== */
	logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
   logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	logic RST;                   // reset - toggle this on startup

	assign RST = SW[9];
	assign setup = SW[8];
	assign board = RedPixels[7:0];

	/* Standard LED Driver instantiation - set once and 'forget it'.
	   See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);


	/* LED board test submodule - paints the board with a static pattern.
		Replace with your own code driving RedPixels and GrnPixels.

		KEY0      : Reset
		=================================================================== */
	
	button_fsm btn_t (.clk(GAME_CLOCK), .reset(RST), .button(t_btn), .pressed(toggle));
	button_fsm btn_l (.clk(GAME_CLOCK), .reset(RST), .button(l_btn), .pressed(l));
	button_fsm btn_r (.clk(GAME_CLOCK), .reset(RST), .button(r_btn), .pressed(r));
	
	// pixel_selected p_slct (.clk(GAME_CLOCK), .reset(RST), .l, .r, .row_select(SW[7:0]), .pixel_board(board[7:0]), .current_x, .current_y, .next_x, .next_y);
	
	pixel_selected_coords p_slct_c (.clk(GAME_CLOCK), .reset(RST), .l, .r, .row_select(SW[7:0]), .pixel_board(board[7:0]), .current_x, .current_y, .next_x, .next_y);
	
	pixel_norm pn_00 (.clk(GAME_CLOCK), .reset(RST), .n(led_g10), .ne(led_g11), .e(led_g01), .se(led_g71), .s(led_g70), .sw(led_g77), .w(led_g07), .nw(led_g17), .toggle, .light_selected(RedPixels[00][00]), .setup, .light_on(GrnPixels[00][00]));
	pixel_norm pn_01 (.clk(GAME_CLOCK), .reset(RST), .n(led_g11), .ne(led_g12), .e(led_g02), .se(led_g72), .s(led_g71), .sw(led_g70), .w(led_g00), .nw(led_g10), .toggle, .light_selected(RedPixels[00][01]), .setup, .light_on(GrnPixels[00][01]));
	pixel_norm pn_02 (.clk(GAME_CLOCK), .reset(RST), .n(led_g12), .ne(led_g13), .e(led_g03), .se(led_g73), .s(led_g72), .sw(led_g71), .w(led_g01), .nw(led_g11), .toggle, .light_selected(RedPixels[00][02]), .setup, .light_on(GrnPixels[00][02]));
	pixel_norm pn_03 (.clk(GAME_CLOCK), .reset(RST), .n(led_g13), .ne(led_g14), .e(led_g04), .se(led_g74), .s(led_g73), .sw(led_g72), .w(led_g02), .nw(led_g12), .toggle, .light_selected(RedPixels[00][03]), .setup, .light_on(GrnPixels[00][03]));
	pixel_norm pn_04 (.clk(GAME_CLOCK), .reset(RST), .n(led_g14), .ne(led_g15), .e(led_g05), .se(led_g75), .s(led_g74), .sw(led_g73), .w(led_g03), .nw(led_g13), .toggle, .light_selected(RedPixels[00][04]), .setup, .light_on(GrnPixels[00][04]));
	pixel_norm pn_05 (.clk(GAME_CLOCK), .reset(RST), .n(led_g15), .ne(led_g16), .e(led_g06), .se(led_g76), .s(led_g75), .sw(led_g74), .w(led_g04), .nw(led_g14), .toggle, .light_selected(RedPixels[00][05]), .setup, .light_on(GrnPixels[00][05]));
	pixel_norm pn_06 (.clk(GAME_CLOCK), .reset(RST), .n(led_g16), .ne(led_g17), .e(led_g07), .se(led_g77), .s(led_g76), .sw(led_g75), .w(led_g05), .nw(led_g15), .toggle, .light_selected(RedPixels[00][06]), .setup, .light_on(GrnPixels[00][06]));
	pixel_norm pn_07 (.clk(GAME_CLOCK), .reset(RST), .n(led_g17), .ne(led_g10), .e(led_g00), .se(led_g70), .s(led_g77), .sw(led_g76), .w(led_g06), .nw(led_g16), .toggle, .light_selected(RedPixels[00][07]), .setup, .light_on(GrnPixels[00][07]));

	pixel_norm pn_10 (.clk(GAME_CLOCK), .reset(RST), .n(led_g20), .ne(led_g21), .e(led_g11), .se(led_g01), .s(led_g00), .sw(led_g07), .w(led_g17), .nw(led_g27), .toggle, .light_selected(RedPixels[01][00]), .setup, .light_on(GrnPixels[01][00]));
	pixel_norm pn_11 (.clk(GAME_CLOCK), .reset(RST), .n(led_g21), .ne(led_g22), .e(led_g12), .se(led_g02), .s(led_g01), .sw(led_g00), .w(led_g10), .nw(led_g20), .toggle, .light_selected(RedPixels[01][01]), .setup, .light_on(GrnPixels[01][01]));
	pixel_norm pn_12 (.clk(GAME_CLOCK), .reset(RST), .n(led_g22), .ne(led_g23), .e(led_g13), .se(led_g03), .s(led_g02), .sw(led_g01), .w(led_g11), .nw(led_g21), .toggle, .light_selected(RedPixels[01][02]), .setup, .light_on(GrnPixels[01][02]));
	pixel_norm pn_13 (.clk(GAME_CLOCK), .reset(RST), .n(led_g23), .ne(led_g24), .e(led_g14), .se(led_g04), .s(led_g03), .sw(led_g02), .w(led_g12), .nw(led_g22), .toggle, .light_selected(RedPixels[01][03]), .setup, .light_on(GrnPixels[01][03]));
	pixel_norm pn_14 (.clk(GAME_CLOCK), .reset(RST), .n(led_g24), .ne(led_g25), .e(led_g15), .se(led_g05), .s(led_g04), .sw(led_g03), .w(led_g13), .nw(led_g23), .toggle, .light_selected(RedPixels[01][04]), .setup, .light_on(GrnPixels[01][04]));
	pixel_norm pn_15 (.clk(GAME_CLOCK), .reset(RST), .n(led_g25), .ne(led_g26), .e(led_g16), .se(led_g06), .s(led_g05), .sw(led_g04), .w(led_g14), .nw(led_g24), .toggle, .light_selected(RedPixels[01][05]), .setup, .light_on(GrnPixels[01][05]));
	pixel_norm pn_16 (.clk(GAME_CLOCK), .reset(RST), .n(led_g26), .ne(led_g27), .e(led_g17), .se(led_g07), .s(led_g06), .sw(led_g05), .w(led_g15), .nw(led_g25), .toggle, .light_selected(RedPixels[01][06]), .setup, .light_on(GrnPixels[01][06]));
	pixel_norm pn_17 (.clk(GAME_CLOCK), .reset(RST), .n(led_g27), .ne(led_g20), .e(led_g10), .se(led_g00), .s(led_g07), .sw(led_g06), .w(led_g16), .nw(led_g26), .toggle, .light_selected(RedPixels[01][07]), .setup, .light_on(GrnPixels[01][07]));

	pixel_norm pn_20 (.clk(GAME_CLOCK), .reset(RST), .n(led_g30), .ne(led_g31), .e(led_g21), .se(led_g11), .s(led_g10), .sw(led_g17), .w(led_g27), .nw(led_g37), .toggle, .light_selected(RedPixels[02][00]), .setup, .light_on(GrnPixels[02][00]));
	pixel_norm pn_21 (.clk(GAME_CLOCK), .reset(RST), .n(led_g31), .ne(led_g32), .e(led_g22), .se(led_g12), .s(led_g11), .sw(led_g10), .w(led_g20), .nw(led_g30), .toggle, .light_selected(RedPixels[02][01]), .setup, .light_on(GrnPixels[02][01]));
	pixel_norm pn_22 (.clk(GAME_CLOCK), .reset(RST), .n(led_g32), .ne(led_g33), .e(led_g23), .se(led_g13), .s(led_g12), .sw(led_g11), .w(led_g21), .nw(led_g31), .toggle, .light_selected(RedPixels[02][02]), .setup, .light_on(GrnPixels[02][02]));
	pixel_norm pn_23 (.clk(GAME_CLOCK), .reset(RST), .n(led_g33), .ne(led_g34), .e(led_g24), .se(led_g14), .s(led_g13), .sw(led_g12), .w(led_g22), .nw(led_g32), .toggle, .light_selected(RedPixels[02][03]), .setup, .light_on(GrnPixels[02][03]));
	pixel_norm pn_24 (.clk(GAME_CLOCK), .reset(RST), .n(led_g34), .ne(led_g35), .e(led_g25), .se(led_g15), .s(led_g14), .sw(led_g13), .w(led_g23), .nw(led_g33), .toggle, .light_selected(RedPixels[02][04]), .setup, .light_on(GrnPixels[02][04]));
	pixel_norm pn_25 (.clk(GAME_CLOCK), .reset(RST), .n(led_g35), .ne(led_g36), .e(led_g26), .se(led_g16), .s(led_g15), .sw(led_g14), .w(led_g24), .nw(led_g34), .toggle, .light_selected(RedPixels[02][05]), .setup, .light_on(GrnPixels[02][05]));
	pixel_norm pn_26 (.clk(GAME_CLOCK), .reset(RST), .n(led_g36), .ne(led_g37), .e(led_g27), .se(led_g17), .s(led_g16), .sw(led_g15), .w(led_g25), .nw(led_g35), .toggle, .light_selected(RedPixels[02][06]), .setup, .light_on(GrnPixels[02][06]));
	pixel_norm pn_27 (.clk(GAME_CLOCK), .reset(RST), .n(led_g37), .ne(led_g30), .e(led_g20), .se(led_g10), .s(led_g17), .sw(led_g16), .w(led_g26), .nw(led_g36), .toggle, .light_selected(RedPixels[02][07]), .setup, .light_on(GrnPixels[02][07]));


	pixel_norm pn_30 (.clk(GAME_CLOCK), .reset(RST), .n(led_g40), .ne(led_g41), .e(led_g31), .se(led_g21), .s(led_g20), .sw(led_g27), .w(led_g37), .nw(led_g47), .toggle, .light_selected(RedPixels[03][00]), .setup, .light_on(GrnPixels[03][00]));
	pixel_norm pn_31 (.clk(GAME_CLOCK), .reset(RST), .n(led_g41), .ne(led_g42), .e(led_g32), .se(led_g22), .s(led_g21), .sw(led_g20), .w(led_g30), .nw(led_g40), .toggle, .light_selected(RedPixels[03][01]), .setup, .light_on(GrnPixels[03][01]));
	pixel_norm pn_32 (.clk(GAME_CLOCK), .reset(RST), .n(led_g42), .ne(led_g43), .e(led_g33), .se(led_g23), .s(led_g22), .sw(led_g21), .w(led_g31), .nw(led_g41), .toggle, .light_selected(RedPixels[03][02]), .setup, .light_on(GrnPixels[03][02]));
	pixel_norm pn_33 (.clk(GAME_CLOCK), .reset(RST), .n(led_g43), .ne(led_g44), .e(led_g34), .se(led_g24), .s(led_g23), .sw(led_g22), .w(led_g32), .nw(led_g42), .toggle, .light_selected(RedPixels[03][03]), .setup, .light_on(GrnPixels[03][03]));
	pixel_norm pn_34 (.clk(GAME_CLOCK), .reset(RST), .n(led_g44), .ne(led_g45), .e(led_g35), .se(led_g25), .s(led_g24), .sw(led_g23), .w(led_g33), .nw(led_g43), .toggle, .light_selected(RedPixels[03][04]), .setup, .light_on(GrnPixels[03][04]));
	pixel_norm pn_35 (.clk(GAME_CLOCK), .reset(RST), .n(led_g45), .ne(led_g46), .e(led_g36), .se(led_g26), .s(led_g25), .sw(led_g24), .w(led_g34), .nw(led_g44), .toggle, .light_selected(RedPixels[03][05]), .setup, .light_on(GrnPixels[03][05]));
	pixel_norm pn_36 (.clk(GAME_CLOCK), .reset(RST), .n(led_g46), .ne(led_g47), .e(led_g37), .se(led_g27), .s(led_g26), .sw(led_g25), .w(led_g35), .nw(led_g45), .toggle, .light_selected(RedPixels[03][06]), .setup, .light_on(GrnPixels[03][06]));
	pixel_norm pn_37 (.clk(GAME_CLOCK), .reset(RST), .n(led_g47), .ne(led_g40), .e(led_g30), .se(led_g20), .s(led_g27), .sw(led_g26), .w(led_g36), .nw(led_g46), .toggle, .light_selected(RedPixels[03][07]), .setup, .light_on(GrnPixels[03][07]));

	pixel_norm pn_40 (.clk(GAME_CLOCK), .reset(RST), .n(led_g50), .ne(led_g51), .e(led_g41), .se(led_g31), .s(led_g30), .sw(led_g37), .w(led_g47), .nw(led_g57), .toggle, .light_selected(RedPixels[04][00]), .setup, .light_on(GrnPixels[04][00]));
	pixel_norm pn_41 (.clk(GAME_CLOCK), .reset(RST), .n(led_g51), .ne(led_g52), .e(led_g42), .se(led_g32), .s(led_g31), .sw(led_g30), .w(led_g40), .nw(led_g50), .toggle, .light_selected(RedPixels[04][01]), .setup, .light_on(GrnPixels[04][01]));
	pixel_norm pn_42 (.clk(GAME_CLOCK), .reset(RST), .n(led_g52), .ne(led_g53), .e(led_g43), .se(led_g33), .s(led_g32), .sw(led_g31), .w(led_g41), .nw(led_g51), .toggle, .light_selected(RedPixels[04][02]), .setup, .light_on(GrnPixels[04][02]));
	pixel_norm pn_43 (.clk(GAME_CLOCK), .reset(RST), .n(led_g53), .ne(led_g54), .e(led_g44), .se(led_g34), .s(led_g33), .sw(led_g32), .w(led_g42), .nw(led_g52), .toggle, .light_selected(RedPixels[04][03]), .setup, .light_on(GrnPixels[04][03]));
	pixel_norm pn_44 (.clk(GAME_CLOCK), .reset(RST), .n(led_g54), .ne(led_g55), .e(led_g45), .se(led_g35), .s(led_g34), .sw(led_g33), .w(led_g43), .nw(led_g53), .toggle, .light_selected(RedPixels[04][04]), .setup, .light_on(GrnPixels[04][04]));
	pixel_norm pn_45 (.clk(GAME_CLOCK), .reset(RST), .n(led_g55), .ne(led_g56), .e(led_g46), .se(led_g36), .s(led_g35), .sw(led_g34), .w(led_g44), .nw(led_g54), .toggle, .light_selected(RedPixels[04][05]), .setup, .light_on(GrnPixels[04][05]));
	pixel_norm pn_46 (.clk(GAME_CLOCK), .reset(RST), .n(led_g56), .ne(led_g57), .e(led_g47), .se(led_g37), .s(led_g36), .sw(led_g35), .w(led_g45), .nw(led_g55), .toggle, .light_selected(RedPixels[04][06]), .setup, .light_on(GrnPixels[04][06]));
	pixel_norm pn_47 (.clk(GAME_CLOCK), .reset(RST), .n(led_g57), .ne(led_g50), .e(led_g40), .se(led_g30), .s(led_g37), .sw(led_g36), .w(led_g46), .nw(led_g56), .toggle, .light_selected(RedPixels[04][07]), .setup, .light_on(GrnPixels[04][07]));
	
	pixel_norm pn_50 (.clk(GAME_CLOCK), .reset(RST), .n(led_g60), .ne(led_g61), .e(led_g51), .se(led_g41), .s(led_g40), .sw(led_g47), .w(led_g57), .nw(led_g67), .toggle, .light_selected(RedPixels[05][00]), .setup, .light_on(GrnPixels[05][00]));
	pixel_norm pn_51 (.clk(GAME_CLOCK), .reset(RST), .n(led_g61), .ne(led_g62), .e(led_g52), .se(led_g42), .s(led_g41), .sw(led_g40), .w(led_g50), .nw(led_g60), .toggle, .light_selected(RedPixels[05][01]), .setup, .light_on(GrnPixels[05][01]));
	pixel_norm pn_52 (.clk(GAME_CLOCK), .reset(RST), .n(led_g62), .ne(led_g63), .e(led_g53), .se(led_g43), .s(led_g42), .sw(led_g41), .w(led_g51), .nw(led_g61), .toggle, .light_selected(RedPixels[05][02]), .setup, .light_on(GrnPixels[05][02]));
	pixel_norm pn_53 (.clk(GAME_CLOCK), .reset(RST), .n(led_g63), .ne(led_g64), .e(led_g54), .se(led_g44), .s(led_g43), .sw(led_g42), .w(led_g52), .nw(led_g62), .toggle, .light_selected(RedPixels[05][03]), .setup, .light_on(GrnPixels[05][03]));
	pixel_norm pn_54 (.clk(GAME_CLOCK), .reset(RST), .n(led_g64), .ne(led_g65), .e(led_g55), .se(led_g45), .s(led_g44), .sw(led_g43), .w(led_g53), .nw(led_g63), .toggle, .light_selected(RedPixels[05][04]), .setup, .light_on(GrnPixels[05][04]));
	pixel_norm pn_55 (.clk(GAME_CLOCK), .reset(RST), .n(led_g65), .ne(led_g66), .e(led_g56), .se(led_g46), .s(led_g45), .sw(led_g44), .w(led_g54), .nw(led_g64), .toggle, .light_selected(RedPixels[05][05]), .setup, .light_on(GrnPixels[05][05]));
	pixel_norm pn_56 (.clk(GAME_CLOCK), .reset(RST), .n(led_g66), .ne(led_g67), .e(led_g57), .se(led_g47), .s(led_g46), .sw(led_g45), .w(led_g55), .nw(led_g65), .toggle, .light_selected(RedPixels[05][06]), .setup, .light_on(GrnPixels[05][06]));
	pixel_norm pn_57 (.clk(GAME_CLOCK), .reset(RST), .n(led_g67), .ne(led_g60), .e(led_g50), .se(led_g40), .s(led_g47), .sw(led_g46), .w(led_g56), .nw(led_g66), .toggle, .light_selected(RedPixels[05][07]), .setup, .light_on(GrnPixels[05][07]));
	
	pixel_norm pn_60 (.clk(GAME_CLOCK), .reset(RST), .n(led_g70), .ne(led_g71), .e(led_g61), .se(led_g51), .s(led_g50), .sw(led_g57), .w(led_g67), .nw(led_g77), .toggle, .light_selected(RedPixels[06][00]), .setup, .light_on(GrnPixels[06][00]));
	pixel_norm pn_61 (.clk(GAME_CLOCK), .reset(RST), .n(led_g71), .ne(led_g72), .e(led_g62), .se(led_g52), .s(led_g51), .sw(led_g50), .w(led_g60), .nw(led_g70), .toggle, .light_selected(RedPixels[06][01]), .setup, .light_on(GrnPixels[06][01]));
	pixel_norm pn_62 (.clk(GAME_CLOCK), .reset(RST), .n(led_g72), .ne(led_g73), .e(led_g63), .se(led_g53), .s(led_g52), .sw(led_g51), .w(led_g61), .nw(led_g71), .toggle, .light_selected(RedPixels[06][02]), .setup, .light_on(GrnPixels[06][02]));
	pixel_norm pn_63 (.clk(GAME_CLOCK), .reset(RST), .n(led_g73), .ne(led_g74), .e(led_g64), .se(led_g54), .s(led_g53), .sw(led_g52), .w(led_g62), .nw(led_g72), .toggle, .light_selected(RedPixels[06][03]), .setup, .light_on(GrnPixels[06][03]));
	pixel_norm pn_64 (.clk(GAME_CLOCK), .reset(RST), .n(led_g74), .ne(led_g75), .e(led_g65), .se(led_g55), .s(led_g54), .sw(led_g53), .w(led_g63), .nw(led_g73), .toggle, .light_selected(RedPixels[06][04]), .setup, .light_on(GrnPixels[06][04]));
	pixel_norm pn_65 (.clk(GAME_CLOCK), .reset(RST), .n(led_g75), .ne(led_g76), .e(led_g66), .se(led_g56), .s(led_g55), .sw(led_g54), .w(led_g64), .nw(led_g74), .toggle, .light_selected(RedPixels[06][05]), .setup, .light_on(GrnPixels[06][05]));
	pixel_norm pn_66 (.clk(GAME_CLOCK), .reset(RST), .n(led_g76), .ne(led_g77), .e(led_g67), .se(led_g57), .s(led_g56), .sw(led_g55), .w(led_g65), .nw(led_g75), .toggle, .light_selected(RedPixels[06][06]), .setup, .light_on(GrnPixels[06][06]));
	pixel_norm pn_67 (.clk(GAME_CLOCK), .reset(RST), .n(led_g77), .ne(led_g70), .e(led_g60), .se(led_g50), .s(led_g57), .sw(led_g56), .w(led_g66), .nw(led_g76), .toggle, .light_selected(RedPixels[06][07]), .setup, .light_on(GrnPixels[06][07]));
	
	pixel_norm pn_70 (.clk(GAME_CLOCK), .reset(RST), .n(led_g00), .ne(led_g01), .e(led_g71), .se(led_g61), .s(led_g60), .sw(led_g67), .w(led_g77), .nw(led_g07), .toggle, .light_selected(RedPixels[07][00]), .setup, .light_on(GrnPixels[07][00]));
	pixel_norm pn_71 (.clk(GAME_CLOCK), .reset(RST), .n(led_g01), .ne(led_g02), .e(led_g72), .se(led_g62), .s(led_g61), .sw(led_g60), .w(led_g70), .nw(led_g00), .toggle, .light_selected(RedPixels[07][01]), .setup, .light_on(GrnPixels[07][01]));
	pixel_norm pn_72 (.clk(GAME_CLOCK), .reset(RST), .n(led_g02), .ne(led_g03), .e(led_g73), .se(led_g63), .s(led_g62), .sw(led_g61), .w(led_g71), .nw(led_g01), .toggle, .light_selected(RedPixels[07][02]), .setup, .light_on(GrnPixels[07][02]));
	pixel_norm pn_73 (.clk(GAME_CLOCK), .reset(RST), .n(led_g03), .ne(led_g04), .e(led_g74), .se(led_g64), .s(led_g63), .sw(led_g62), .w(led_g72), .nw(led_g02), .toggle, .light_selected(RedPixels[07][03]), .setup, .light_on(GrnPixels[07][03]));
	pixel_norm pn_74 (.clk(GAME_CLOCK), .reset(RST), .n(led_g04), .ne(led_g05), .e(led_g75), .se(led_g65), .s(led_g64), .sw(led_g63), .w(led_g73), .nw(led_g03), .toggle, .light_selected(RedPixels[07][04]), .setup, .light_on(GrnPixels[07][04]));
	pixel_norm pn_75 (.clk(GAME_CLOCK), .reset(RST), .n(led_g05), .ne(led_g06), .e(led_g76), .se(led_g66), .s(led_g65), .sw(led_g64), .w(led_g74), .nw(led_g04), .toggle, .light_selected(RedPixels[07][05]), .setup, .light_on(GrnPixels[07][05]));
	pixel_norm pn_76 (.clk(GAME_CLOCK), .reset(RST), .n(led_g06), .ne(led_g07), .e(led_g77), .se(led_g67), .s(led_g66), .sw(led_g65), .w(led_g75), .nw(led_g05), .toggle, .light_selected(RedPixels[07][06]), .setup, .light_on(GrnPixels[07][06]));
	pixel_norm pn_77 (.clk(GAME_CLOCK), .reset(RST), .n(led_g07), .ne(led_g00), .e(led_g70), .se(led_g60), .s(led_g67), .sw(led_g66), .w(led_g76), .nw(led_g06), .toggle, .light_selected(RedPixels[07][07]), .setup, .light_on(GrnPixels[07][07]));
	
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
			
			GrnPixels[08][08] <= 0;
		end

		else begin
			RedPixels <= '0;
			if (setup) begin
				RedPixels[next_y][next_x] <= 1;
				current_y <= next_y;
				current_x <= next_x;
			end
		end
		
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
		
		t_btn <= KEY[0];
		l_btn <= KEY[3];
		r_btn <= KEY[2];
	end
endmodule

module DE1_SoC_testbench();
	logic [3:0]  KEY;
   logic [9:0]  SW;
   logic [35:0] GPIO_1;
   logic CLOCK_50;
	
	DE1_SoC dut (KEY, SW, GPIO_1, CLOCK_50);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
		SW[9] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[9] <= 1;
		SW[8] <= 1;  
		SW[7] <= 0;
		SW[6] <= 0;
		SW[5] <= 0;
		SW[4] <= 0;
		SW[3] <= 0;
		SW[2] <= 0;
		SW[1] <= 0;
		SW[0] <= 0;
		KEY[3] <= 0;
		KEY[2] <= 0;
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		
		/* test setup row changing
		SW[9] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 1;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 1;  repeat (3) @(posedge CLOCK_50);
		SW[2] <= 1;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[1] <= 1;  repeat (3) @(posedge CLOCK_50);
		SW[1] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[1] <= 1;  repeat (3) @(posedge CLOCK_50);
		SW[2] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[1] <= 0;  repeat (3) @(posedge CLOCK_50);
		*/
		
		/* test setup row and side to side
		SW[9] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 1;  repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[2] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[2] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[2] <= 1;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 0;  repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[2] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[1] <= 1;  repeat (5) @(posedge CLOCK_50);
		SW[1] <= 0;  repeat (3) @(posedge CLOCK_50);
		*/
		
		/* test blinker pattern
		SW[9] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 1;  repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		
		SW[3] <= 0;
		SW[8] <= 0;  repeat (20) @(posedge CLOCK_50);
		SW[8] <= 1;  repeat (9) @(posedge CLOCK_50);
		*/
		
		/* test static pattern
		SW[9] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[3] <= 1;  repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[3] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[3] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[2] <= 1;  repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[2] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[2] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[2] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[8] <= 0;  repeat (20) @(posedge CLOCK_50)
		*/
		
		/* range troubleshooting
		*/
		SW[9] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[4] <= 1;  repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[4] <= 0;  repeat (3) @(posedge CLOCK_50);
		SW[6] <= 1;  repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 1; repeat (3) @(posedge CLOCK_50);
		KEY[0] <= 0; repeat (3) @(posedge CLOCK_50);
		SW[6] <= 0;  repeat (3) @(posedge CLOCK_50);
		
		SW[8] <= 0;  repeat (9) @(posedge CLOCK_50);
		$stop;
	end
endmodule