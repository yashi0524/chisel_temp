import chisel3._
import chiseltest._
import chiselverify.coverage.CoverageReporter
import chiselverify.coverage._
import chiselverify.coverage.{cover => ccover}
import chiselverify.timing._
import org.scalatest.flatspec.AnyFlatSpec
import simpleModule._

/**
 * 
 */

class simpleTester extends AnyFlatSpec with ChiselScalatestTester {

    def testFun[T <: simpleModule](dut: T): Unit = {

        val cr = new CoverageReporter(dut)
        cr.register(
            //Declare CoverPoints
            ccover("in_a", dut.io.in_a)( //CoverPoint 1
                bin("lo10", 0 to 10),
                bin("First100", 0 to 100)
            ),
            ccover("in_b", dut.io.in_b)(DefaultBin(dut.io.in_b)),
            ccover("time cross", dut.io.in_a, dut.io.out_a)(Exactly(1))(
            cross("both1", Seq(1 to 1, 1 to 1))
                )
        )
        
        def testSingle( a:UInt, b:UInt, c:UInt ): Unit ={
            dut.io.in_a.poke(a)
            dut.io.in_b.poke(b)
            dut.io.in_c.poke(c)
            dut.clock.step(1) 
            
            cr.sample()
            cr.step()
        }
        
        for( a <- 0 until 10){
            for( b <- 0 until 1000)
                testSingle( a.U, b.U, 1.U)
        }
        
        
        
        cr.printReport()
    }

  "simpleTest1" should "pass" in {
    test(new simpleModule) { dut =>
        dut.io.in_a.poke(4.U)
        dut.io.in_b.poke(3.U)
        dut.io.in_c.poke(2.U)
        dut.clock.step(10)
        
        //printf("out_a = %d", dut.io.out_a)
    }
  }
    
  "chiselVerifyTest1" should "pass" in {
    test(new simpleModule) { dut => testFun(dut)}
  }    
}