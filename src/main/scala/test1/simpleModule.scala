package simpleModule

import chisel3._
import chisel3.util._
import MUL_MAC._
import FIR._

class simpleModule extends Module {
  val io = IO(new Bundle {
    val in_a = Input(UInt(10.W))
    val in_b = Input(UInt(10.W))
    val in_c = Input(UInt(10.W))  
    val out_a = Output(UInt(10.W))
  })
  
  val mac_1 = Module( new MAC(8))
    
  mac_1.io.in_a := io.in_a
  mac_1.io.in_b := io.in_b
  mac_1.io.in_c := io.in_c  
    
  //io.out_a := mac_1.io.out_a
    
  val fir_1 = Module( new MyManyDynamicElementVecFir(4))
    
  fir_1.io.in := mac_1.io.out_a
    
  fir_1.io.valid := true.B
  
  val const = Wire(Vec(4, UInt(8.W)))
    
  
    const(0) := 1.U
    const(1) := 1.U
    const(2) := 1.U
    const(3) := 1.U
    
  fir_1.io.consts := const
    
  
    
  io.out_a := fir_1.io.out
    
    
}

// Generate the Verilog code
object simpleModuleMain extends App {
  println("SimpleTest ")
  (new chisel3.stage.ChiselStage).emitVerilog(new simpleModule(), Array("--target-dir", "generated"))

}

