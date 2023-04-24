module isLesser(x_less_than_y, X, Y);
  input logic [1:0] X, Y;
  output logic x_less_than_y;

  assign x_less_than_y = (~X[0] & ~X[1]) | (Y[0] & Y[1]) | (~X[0] & Y[0]);
endmodule

module compare(a_less_than_or_equal_to_b, A, B);
  input logic [1:0] A, B;
  output logic a_less_than_or_equal_to_b;
  logic b_less_than_a;

  isLesser isL1 (b_less_than_a, B, A);
  assign a_less_than_or_equal_to_b = ~b_less_than_a;
endmodule

