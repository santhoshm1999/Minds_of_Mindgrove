package MAC_unpipelined_float;

import MAC_unpipelined_float_mul :: *;
import MAC_unpipelined_float_add :: *;

interface Ifc_MAC_unpipelined_float;
    method Action get_start(Bit#(1) start);
    method Action get_input_a(Bit#(16) a);
    method Action get_input_b(Bit#(16) b);
    method Action get_input_s();
    method Action get_input_c(Bit#(32) c);
    method Bit#(32) get_MAC_result();
    method Bit#(1) get_stop();
endinterface: Ifc_MAC_unpipelined_float

(*synthesize*)
module mkUnpipelined_float(Ifc_MAC_unpipelined_float);

    Reg#(Bit#(16)) rg_a <- mkReg(16'd0);
    Reg#(Bit#(16)) rg_b <- mkReg(16'd0);
    Reg#(Bit#(16)) rg_s <- mkReg(16'd0);
    Reg#(Bit#(32)) rg_c <- mkReg(32'd0);
    Reg#(Bit#(1)) rg_start <- mkReg(1'd0);
    Reg#(Bit#(32)) rg_mac_result <- mkReg(32'd0);
    // Reg#(Bit#(32)) rg_result <- mkReg(0);
    Reg#(Bool) got_rg_a <- mkReg(False);
    Reg#(Bool) got_rg_b <- mkReg(False);
    Reg#(Bool) got_rg_s <- mkReg(False);
    Reg#(Bool) got_rg_c <- mkReg(False);
    Reg#(Bool) got_rg_start <- mkReg(False);
    Reg#(Bool) mul_started <- mkReg(False);
    Reg#(Bool) add_started <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Bool start_value = True;

    Ifc_MAC_unpipelined_float_mul mul <- mkUnpipelined_float_mul;
    Ifc_MAC_unpipelined_float_add add <- mkUnpipelined_float_add;

    rule rl_put_mul_val ( got_rg_a && got_rg_b && !mul_started);
	$display($stime," A: %b  B: %b",rg_a, rg_b);
        mul.get_inp_a(rg_a);
        mul.get_inp_b(rg_b);
	    mul_started <= True;
    endrule

    rule get_mul_result(mul_started && !mul_done);
	    rg_s <= mul.get_result();
	    got_rg_s <= True;
	    mul_done <= True;
    endrule


    rule rl_put_add_val (got_rg_s && got_rg_c && mul_done && !add_started);
	$display($stime," C: %b S: %b",rg_c, rg_s);
        add.get_inp_s({rg_s,16'd0});
        add.get_inp_c(rg_c);
    	mul_done <= False;
	    add_started <= True;
    endrule

    rule rl_get_add_result(add_started && !add_done);
	    rg_mac_result <= add.get_result();
	    add_started <= False;
	    add_done <= True;
    endrule

    rule rl_deassert_signals(add_done);
	    // got_rg_a <= False;
	    // got_rg_b <= False;
	    // got_rg_c <= False;
	    // got_rg_s <= False;
        mul_started <= False;
	    add_done <= False;
        // got_rg_start <= False;
        rg_start <= 0;
    endrule

    method Action get_start(Bit#(1) start) if(!got_rg_start);
        rg_start <= start;
        got_rg_start <= True;
    endmethod

    method Action get_input_a(Bit#(16) a) if(rg_start == 1 && !got_rg_a);
        rg_a <= a;
        got_rg_a <= True;
    endmethod

    method Action get_input_b(Bit#(16) b)if(rg_start == 1 && !got_rg_b);
        rg_b <= b;
        got_rg_b <= True;
    endmethod

    // method Action get_input_s() if(!got_rg_s);
    //     rg_s <= mul.get_result();
    //     got_rg_s <= True;
    //     add.add_start(True);
    // endmethod

    method Action get_input_c(Bit#(32) c)if(rg_start == 1 && !got_rg_c);
        rg_c <= c;
        got_rg_c <= True;
        // rg_start <= 0;
        // got_rg_start <= False;
    endmethod

    method Bit#(32) get_MAC_result() if(add_done);
        return rg_mac_result;
    endmethod

    method Bit#(1) get_stop();
        return rg_start;
    endmethod

endmodule

endpackage
