module simpleTest(
  input        clock,
  input        reset,
  input  [9:0] io_in_a,
  output [9:0] io_out_a
);
  assign io_out_a = io_in_a; // @[DUT.scala 11:12]
endmodule
