package MUL_MAC

import chisel3._
import chisel3.util._

class MAC( n: Int) extends Module {
  val io = IO(new Bundle {
    val in_a = Input(UInt( n.W))
    val in_b = Input(UInt( n.W))
    val in_c = Input(UInt( n.W))  
    val out_a = Output(UInt( n.W))
  })

  io.out_a := io.in_a * io.in_b + io.in_c
}

