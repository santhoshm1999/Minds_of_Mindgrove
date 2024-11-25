package MAC_unpipelined_top;

import MAC_unpipelined_float :: *;
import MAC_unpipelined_int :: *;

interface Ifc_MAC_unpipelined;
    // method Action get_int_a(Bit#(16) a);
    // method Action get_int_b(Bit#(16) b);
    // method Action get_int_c(Bit#(32) c);
    method Action get_fl_a(Bit#(16) a);
    method Action get_fl_b(Bit#(16) b);
    method Action get_fl_c(Bit#(32) b);
    method Action get_s1_or_s2(Bit#(1) s1_s2);
    method Bit#(32) get_end_res();
endinterface: Ifc_MAC_unpipelined

(*synthesize*)
module mkMAC (Ifc_MAC_unpipelined);
    Ifc_MAC_unpipelined_int int_mac <- mkintmul;
    Ifc_MAC_unpipelined_float float_mac <- mkUnpipelined_float;
    Reg#(Bit#(16)) int_a <- mkReg(16'd0);
    Reg#(Bit#(16)) int_b <- mkReg(16'd0);
    Reg#(Bit#(32)) int_c <- mkReg(32'd0);
    Reg#(Bit#(32)) int_res <- mkReg(32'd0);
    Reg#(Bit#(16)) fl_a <- mkReg(16'd0);
    Reg#(Bit#(16)) fl_b <- mkReg(16'd0);
    Reg#(Bit#(32)) fl_c <- mkReg(32'd0);
    Reg#(Bit#(32)) fl_res <- mkReg(32'd0);
    Reg#(Bit#(32)) end_res <- mkReg(32'd0);
    Reg#(Bit#(1)) s1_or_s2 <- mkReg(1'b0);
    Reg#(Bool) got_a <- mkReg(False);
    Reg#(Bool) got_b <- mkReg(False);
    Reg#(Bool) got_c <- mkReg(False);
    Reg#(Bool) got_si <- mkReg(False);
    Reg#(Bool) float_inp_done <- mkReg(False);
    Reg#(Bool) end_res_done <- mkReg(False);

    rule rl_put_float_val(got_si && got_a && got_b && got_c && !float_inp_done);
	    if(s1_or_s2 == 0) begin
		    int_mac.get_A(fl_a);
		    int_mac.get_B(fl_b);
		    int_mac.get_C(fl_c);
	    end
	    else if(s1_or_s2 == 1) begin
		    float_mac.get_input_a(fl_a);
		    float_mac.get_input_b(fl_b);
		    float_mac.get_input_c(fl_c);
	    end
        float_inp_done <= True;
    endrule

    rule rl_get_float_res(float_inp_done && !end_res_done);
        if(s1_or_s2 == 0) begin
            end_res <= int_mac.get_output();
        end
        else if(s1_or_s2 == 1) begin
            end_res <= float_mac.get_MAC_result();
        end
        end_res_done <= True;
    endrule

    rule deasdrt_signal(float_inp_done && end_res_done);
        got_si <= False;
        got_a <= False;
        got_b <= False;
        got_c <= False;
        float_inp_done <= False;
        end_res_done <= False;
    endrule
    


    method Action get_s1_or_s2(Bit#(1) si);
	    s1_or_s2 <= si;
	    got_si <= True;
    endmethod

    // method Action get_int_a(Bit#(16) a) if(got_si && s1_or_s2 == 0);
	//     int_a <= a;
	//     got_a <= True;
    // endmethod

    // method Action get_int_b(Bit#(16) b) if(got_si && s1_or_s2 == 0);
	//     int_b <= b;
	//     got_b <= True;
    // endmethod

    // method Action get_int_c(Bit#(32) c) if(got_si && s1_or_s2 == 0);
	//     int_c <= c;
	//     got_c <= True;
    // endmethod

    method Action get_fl_a(Bit#(16) a) if(!got_a);
	    fl_a <= a;
	    got_a <= True;
    endmethod

    method Action get_fl_b(Bit#(16) b) if(!got_b);
	    fl_b <= b;
	    got_b <= True;
    endmethod

    method Action get_fl_c(Bit#(32) c) if(!got_c);
	    fl_c <= c;
	    got_c <= True;
    endmethod

    method Bit#(32) get_end_res() if(end_res_done);
        return end_res;
    endmethod

endmodule: mkMAC

endpackage : MAC_unpipelined_top
