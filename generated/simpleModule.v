module MAC(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  input  [7:0] io_in_c,
  output [7:0] io_out_a
);
  wire [15:0] _io_out_a_T = io_in_a * io_in_b; // @[mul_mac.scala 14:23]
  wire [15:0] _GEN_0 = {{8'd0}, io_in_c}; // @[mul_mac.scala 14:33]
  wire [15:0] _io_out_a_T_2 = _io_out_a_T + _GEN_0; // @[mul_mac.scala 14:33]
  assign io_out_a = _io_out_a_T_2[7:0]; // @[mul_mac.scala 14:12]
endmodule
module simpleModule(
  input        clock,
  input        reset,
  input  [9:0] io_in_a,
  input  [9:0] io_in_b,
  input  [9:0] io_in_c,
  output [9:0] io_out_a
);
  wire [7:0] mac_1_io_in_a; // @[simpleModule.scala 15:21]
  wire [7:0] mac_1_io_in_b; // @[simpleModule.scala 15:21]
  wire [7:0] mac_1_io_in_c; // @[simpleModule.scala 15:21]
  wire [7:0] mac_1_io_out_a; // @[simpleModule.scala 15:21]
  MAC mac_1 ( // @[simpleModule.scala 15:21]
    .io_in_a(mac_1_io_in_a),
    .io_in_b(mac_1_io_in_b),
    .io_in_c(mac_1_io_in_c),
    .io_out_a(mac_1_io_out_a)
  );
  assign io_out_a = {{2'd0}, mac_1_io_out_a}; // @[simpleModule.scala 21:12]
  assign mac_1_io_in_a = io_in_a[7:0]; // @[simpleModule.scala 17:17]
  assign mac_1_io_in_b = io_in_b[7:0]; // @[simpleModule.scala 18:17]
  assign mac_1_io_in_c = io_in_c[7:0]; // @[simpleModule.scala 19:17]
endmodule
