package MAC_unpipelined_float;

import MAC_unpipelined_float_mul :: *;
import MAC_unpipelined_float_add :: *;

interface Ifc_MAC_unpipelined_float;
    method Action get_input_a(Bit#(16) a);
    method Action get_input_b(Bit#(16) b);
    method Action get_input_s();
    method Action get_input_c(Bit#(32) c);
    method Bit#(32) get_MAC_result();
endinterface: Ifc_MAC_unpipelined_float

(*synthesize*)
module mkUnpipelined_float(Ifc_MAC_unpipelined_float);

    Reg#(Bit#(16)) rg_a <- mkReg(16'd0);
    Reg#(Bit#(16)) rg_b <- mkReg(16'd0);
    Reg#(Bit#(16)) rg_s <- mkReg(16'd0);
    Reg#(Bit#(32)) rg_c <- mkReg(32'd0);
    Reg#(Bit#(32)) rg_mac_result <- mkReg(32'd0);
    // Reg#(Bit#(32)) rg_result <- mkReg(0);
    Reg#(Bool) got_rg_a <- mkReg(False);
    Reg#(Bool) got_rg_b <- mkReg(False);
    Reg#(Bool) got_rg_s <- mkReg(False);
    Reg#(Bool) got_rg_c <- mkReg(False);
    Reg#(Bool) mul_started <- mkReg(False);
    Reg#(Bool) add_started <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) mac_completed <- mkReg(False);
    Bool start_value = True;

    Ifc_MAC_unpipelined_float_mul mul <- mkUnpipelined_float_mul;
    Ifc_MAC_unpipelined_float_add add <- mkUnpipelined_float_add;

    rule rl_put_mul_val ( got_rg_a && got_rg_b && !mul_started);
	    $display($stime," A: %b  B: %b",rg_a, rg_b);
        mul.get_inp_a(rg_a);
        mul.get_inp_b(rg_b);
	    mul_started <= True;
    endrule

    rule get_mul_result(mul_started);
	    rg_s <= mul.get_result();
	    mul_done <= True;
    endrule


    rule rl_put_add_val (got_rg_a && got_rg_b && got_rg_c && mul_done && !add_started);
	    $display($stime," C: %b S: %b",rg_c, rg_s);
        add.get_inp_s({rg_s,16'd0});
        add.get_inp_c(rg_c);
	    add_started <= True;
    endrule

    rule rl_get_add_result(add_started);
	    rg_mac_result <= add.get_result();
	    mac_completed <= True;
    endrule

    rule rl_deassert_signals(mac_completed);
        $display($stime," Everything Done!");
	    got_rg_a <= False;
	    got_rg_b <= False;
	    got_rg_c <= False;
        mul_started <= False;
        mul_done <= False;
	    add_started <= False;
        mac_completed <= False;
    endrule

    method Action get_input_a(Bit#(16) a) if(!got_rg_a);
        rg_a <= a;
        got_rg_a <= True;
    endmethod

    method Action get_input_b(Bit#(16) b)if(!got_rg_b);
        rg_b <= b;
        got_rg_b <= True;
    endmethod

    method Action get_input_c(Bit#(32) c)if(!got_rg_c);
        rg_c <= c;
        got_rg_c <= True;
    endmethod

    method Bit#(32) get_MAC_result() if(mac_completed);
        return rg_mac_result;
    endmethod

endmodule

endpackage
