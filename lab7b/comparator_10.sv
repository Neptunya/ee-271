module comparator_10 (a, b, a_greater);
  input logic [9:0] a, b;
  output logic a_greater;

  assign a_greater = (a > b);
endmodule

module comparator_10_testbench;

  // Inputs
  logic [9:0] a;
  logic [9:0] b;
  
  // Outputs
  logic a_greater;
  
  // Instantiate the comparator module
  comparator_10 dut (
    .a(a),
    .b(b),
    .a_greater(a_greater)
  );
  
  // Stimulus generation
  initial begin
    // Test case 1: a = 5, b = 3 (a > b)
    a = 10'b0000000100;
    b = 10'b0000000011;
    #10;  // Wait for some time
    
    // Assertion to check the output
    if (a_greater !== 1'b1)
      $display("Test case 1 failed!");
    else
      $display("Test case 1 passed!");
    
    // Test case 2: a = 3, b = 5 (a < b)
    a = 10'b0000000011;
    b = 10'b0000000101;
    #10;  // Wait for some time
    
    // Assertion to check the output
    if (a_greater !== 1'b0)
      $display("Test case 2 failed!");
    else
      $display("Test case 2 passed!");
    
    // Add more test cases as needed
    
    $finish;  // End simulation
  end

endmodule