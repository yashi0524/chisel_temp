circuit simpleModule :
  module MAC :
    input clock : Clock
    input reset : Reset
    output io : { flip in_a : UInt<8>, flip in_b : UInt<8>, flip in_c : UInt<8>, out_a : UInt<8>}

    node _io_out_a_T = mul(io.in_a, io.in_b) @[mul_mac.scala 14:23]
    node _io_out_a_T_1 = add(_io_out_a_T, io.in_c) @[mul_mac.scala 14:33]
    node _io_out_a_T_2 = tail(_io_out_a_T_1, 1) @[mul_mac.scala 14:33]
    io.out_a <= _io_out_a_T_2 @[mul_mac.scala 14:12]

  module simpleModule :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<10>, flip in_b : UInt<10>, flip in_c : UInt<10>, out_a : UInt<10>}

    inst mac_1 of MAC @[simpleModule.scala 15:21]
    mac_1.clock <= clock
    mac_1.reset <= reset
    mac_1.io.in_a <= io.in_a @[simpleModule.scala 17:17]
    mac_1.io.in_b <= io.in_b @[simpleModule.scala 18:17]
    mac_1.io.in_c <= io.in_c @[simpleModule.scala 19:17]
    io.out_a <= mac_1.io.out_a @[simpleModule.scala 21:12]

