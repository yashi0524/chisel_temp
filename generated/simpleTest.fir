circuit simpleTest :
  module simpleTest :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in_a : UInt<10>, out_a : UInt<10>}

    io.out_a <= io.in_a @[DUT.scala 11:12]

