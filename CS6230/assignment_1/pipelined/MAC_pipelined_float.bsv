package MAC_pipelined_float;

	import FIFO :: *;
	import SpecialFIFOs :: *;

	import MAC_types :: *;

import MAC_pipelined_float_mul :: *;
import MAC_pipelined_float_add :: *;

interface Ifc_MAC_pipelined_float;
    method Action get_input_a(Bit#(16) a);
    method Action get_input_b(Bit#(16) b);
    method Action get_input_s();
    method Action get_input_c(Bit#(32) c);
    method ActionValue#(Bit#(32)) get_MAC_result();
endinterface: Ifc_MAC_pipelined_float

(*synthesize*)
module mkPipelined_float(Ifc_MAC_pipelined_float);

	FIFO#(Bit#(16)) val_a <- mkPipelineFIFO(); 
	FIFO#(Bit#(16)) val_b <- mkPipelineFIFO(); 
	FIFO#(Bit#(32)) val_c <- mkPipelineFIFO(); 
	FIFO#(Bit#(16)) val_mul <- mkPipelineFIFO(); 
	FIFO#(Bit#(32)) val_mac <- mkPipelineFIFO(); 

    Reg#(Bit#(16)) rg_a <- mkReg(16'd0);
    Reg#(Bit#(16)) rg_b <- mkReg(16'd0);
    // Reg#(Bf16) rg_s <- mkReg(16'd0);
    Reg#(Bit#(32)) rg_c <- mkReg(32'd0);
    // Reg#(Bit#(32)) rg_mac_result <- mkReg(32'd0);
    // Reg#(Bit#(32)) rg_result <- mkReg(0);
    Reg#(Bool) got_rg_a <- mkReg(False);
    Reg#(Bool) got_rg_b <- mkReg(False);
    Reg#(Bool) got_rg_s <- mkReg(False);
    Reg#(Bool) got_rg_c <- mkReg(False);
    Reg#(Bool) mul_started <- mkReg(False);
    Reg#(Bool) add_started <- mkReg(False);
    Reg#(Bool) start_done <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) mac_completed <- mkReg(False);
    Bool start_value = True;

    Ifc_MAC_pipelined_float_mul mul <- mkPipelined_float_mul;
    Ifc_MAC_pipelined_float_add add <- mkPipelined_float_add;

    rule rl_start_MAC(!start_done);
	    Bit#(16) temp_a = val_a.first();
	    Bit#(16) temp_b = val_b.first();
	    Bit#(32) temp_c = val_c.first();
	    rg_a <= temp_a;
	    rg_b <= temp_b;
	    rg_c <= temp_c;
	    val_a.deq();
	    val_b.deq();
	    val_c.deq();
	    start_done <= True;
    endrule

    rule rl_put_mul_val ( start_done && !mul_started);
	    $display($stime," A: %b  B: %b",rg_a, rg_b);
        mul.get_inp_a(rg_a);
        mul.get_inp_b(rg_b);
	    mul_started <= True;
    endrule

    rule get_mul_result(mul_started);
	    Bf16 s = mul.get_result();
	    val_mul.enq(pack(s)); 
	    mul_done <= True;
    endrule


    rule rl_put_add_val ;
	    Bit#(16) rg_s = val_mul.first();
	    val_mul.deq();
	    add.get_inp_s({rg_s,16'd0});
	    add.get_inp_c(rg_c);
	    add_started <= True;
    endrule

    rule rl_get_add_result(start_done && add_started);
	    Fp32 temp_mac_res <- add.get_result();
	    val_mac.enq(pack(temp_mac_res));
	    mac_completed <= True;
    endrule

    rule rl_deassert_signals(mac_completed);
	    $display($stime," Everything Done!");
	    mul_started <= False;
	    mul_done <= False;
	    add_started <= False;
	    mac_completed <= False;
	    start_done <= False;
    endrule

    method Action get_input_a(Bit#(16) a);
        val_a.enq(a);
    endmethod

    method Action get_input_b(Bit#(16) b);
        val_b.enq(b);
    endmethod

    method Action get_input_c(Bit#(32) c);
        val_c.enq(c);
    endmethod

    method ActionValue#(Bit#(32)) get_MAC_result() if(mac_completed);
	    Bit#(32)rg_mac_result = val_mac.first();
	    val_mac.deq();
	    return rg_mac_result;
    endmethod

endmodule:mkPipelined_float

endpackage
