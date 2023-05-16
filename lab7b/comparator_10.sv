module comparator_10 (a, b, a_greater);
  input logic [9:0] a, b;
  output logic a_greater;

  initial begin
    a_greater = 0;
    for (int i = 0; i < 10; i = i + 1) begin
      logic c = a[i] ^ b[i];
      if (c) begin
        if (a[i] > b[i]) begin
          a_greater = 1;
        end
        break;
      end
    end
  end
endmodule
