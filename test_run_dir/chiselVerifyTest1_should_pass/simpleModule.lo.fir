circuit simpleModule :
  module MAC :
    input clock : Clock
    input reset : UInt<1>
    input io_in_a : UInt<8>
    input io_in_b : UInt<8>
    input io_in_c : UInt<8>
    output io_out_a : UInt<8>

    node _io_out_a_T = mul(io_in_a, io_in_b) @[mul_mac.scala 14:23]
    node _io_out_a_T_1 = add(_io_out_a_T, io_in_c) @[mul_mac.scala 14:33]
    node _io_out_a_T_2 = tail(_io_out_a_T_1, 1) @[mul_mac.scala 14:33]
    io_out_a <= bits(_io_out_a_T_2, 7, 0) @[mul_mac.scala 14:12]

  module MyManyDynamicElementVecFir :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<8>
    input io_valid : UInt<1>
    output io_out : UInt<8>
    input io_consts_0 : UInt<8>
    input io_consts_1 : UInt<8>
    input io_consts_2 : UInt<8>
    input io_consts_3 : UInt<8>

    reg taps_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), taps_1) @[fir.scala 15:66]
    reg taps_2 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), taps_2) @[fir.scala 15:66]
    reg taps_3 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), taps_3) @[fir.scala 15:66]
    node _GEN_0 = mux(io_valid, io_in, taps_1) @[fir.scala 16:64 15:66 16:68]
    node _GEN_1 = mux(io_valid, taps_1, taps_2) @[fir.scala 16:64 15:66 16:68]
    node _GEN_2 = mux(io_valid, taps_2, taps_3) @[fir.scala 16:64 15:66 16:68]
    node _io_out_T = mul(io_in, io_consts_0) @[fir.scala 18:56]
    node _io_out_T_1 = mul(taps_1, io_consts_1) @[fir.scala 18:56]
    node _io_out_T_2 = mul(taps_2, io_consts_2) @[fir.scala 18:56]
    node _io_out_T_3 = mul(taps_3, io_consts_3) @[fir.scala 18:56]
    node _io_out_T_4 = add(_io_out_T, _io_out_T_1) @[fir.scala 18:71]
    node _io_out_T_5 = tail(_io_out_T_4, 1) @[fir.scala 18:71]
    node _io_out_T_6 = add(_io_out_T_5, _io_out_T_2) @[fir.scala 18:71]
    node _io_out_T_7 = tail(_io_out_T_6, 1) @[fir.scala 18:71]
    node _io_out_T_8 = add(_io_out_T_7, _io_out_T_3) @[fir.scala 18:71]
    node _io_out_T_9 = tail(_io_out_T_8, 1) @[fir.scala 18:71]
    io_out <= bits(_io_out_T_9, 7, 0) @[fir.scala 18:10]
    taps_1 <= mux(reset, UInt<8>("h0"), _GEN_0) @[fir.scala 15:{66,66}]
    taps_2 <= mux(reset, UInt<8>("h0"), _GEN_1) @[fir.scala 15:{66,66}]
    taps_3 <= mux(reset, UInt<8>("h0"), _GEN_2) @[fir.scala 15:{66,66}]

  module simpleModule :
    input clock : Clock
    input reset : UInt<1>
    input io_in_a : UInt<10>
    input io_in_b : UInt<10>
    input io_in_c : UInt<10>
    output io_out_a : UInt<10>

    inst mac_1 of MAC @[simpleModule.scala 16:21]
    inst fir_1 of MyManyDynamicElementVecFir @[simpleModule.scala 24:21]
    node const_0 = UInt<8>("h1") @[simpleModule.scala 30:19 33:14]
    node const_1 = UInt<8>("h1") @[simpleModule.scala 30:19 34:14]
    node const_2 = UInt<8>("h1") @[simpleModule.scala 30:19 35:14]
    node const_3 = UInt<8>("h1") @[simpleModule.scala 30:19 36:14]
    io_out_a <= pad(fir_1.io_out, 10) @[simpleModule.scala 42:12]
    mac_1.clock <= clock
    mac_1.reset <= reset
    mac_1.io_in_a <= bits(io_in_a, 7, 0) @[simpleModule.scala 18:17]
    mac_1.io_in_b <= bits(io_in_b, 7, 0) @[simpleModule.scala 19:17]
    mac_1.io_in_c <= bits(io_in_c, 7, 0) @[simpleModule.scala 20:17]
    fir_1.clock <= clock
    fir_1.reset <= reset
    fir_1.io_in <= mac_1.io_out_a @[simpleModule.scala 26:15]
    fir_1.io_valid <= UInt<1>("h1") @[simpleModule.scala 28:18]
    fir_1.io_consts_0 <= const_0 @[simpleModule.scala 38:19]
    fir_1.io_consts_1 <= const_1 @[simpleModule.scala 38:19]
    fir_1.io_consts_2 <= const_2 @[simpleModule.scala 38:19]
    fir_1.io_consts_3 <= const_3 @[simpleModule.scala 38:19]
