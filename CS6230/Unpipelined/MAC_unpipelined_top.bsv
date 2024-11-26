package MAC_unpipelined_top;

import MAC_unpipelined_float :: *;
import MAC_unpipelined_int :: *;

interface Ifc_MAC_unpipelined;
    // method Action get_int_a(Bit#(16) a);
    // method Action get_int_b(Bit#(16) b);
    // method Action get_int_c(Bit#(32) c);
    method Action get_mac_a(Bit#(16) a);
    method Action get_mac_b(Bit#(16) b);
    method Action get_mac_c(Bit#(32) c);
    method Action get_s1_or_s2(Bit#(1) s1_s2);
    method Bit#(32) get_end_res();
endinterface: Ifc_MAC_unpipelined

(*synthesize*)
module mkMAC (Ifc_MAC_unpipelined);
    Ifc_MAC_unpipelined_int int_mac <- mkintmul;
    Ifc_MAC_unpipelined_float float_mac <- mkUnpipelined_float;
    // Reg#(Bit#(16)) int_a <- mkReg(16'd0);
    // Reg#(Bit#(16)) int_b <- mkReg(16'd0);
    // Reg#(Bit#(32)) int_c <- mkReg(32'd0);
    // Reg#(Bit#(32)) int_res <- mkReg(32'd0);
    Reg#(Bit#(16)) mac_a <- mkReg(16'd0);
    Reg#(Bit#(16)) mac_b <- mkReg(16'd0);
    Reg#(Bit#(32)) mac_c <- mkReg(32'd0);
    // Reg#(Bit#(32)) mac_res <- mkReg(32'd0);
    Reg#(Bit#(32)) end_res <- mkReg(32'd0);
    Reg#(Bit#(1)) s1_or_s2 <- mkReg(1'b0);
    Reg#(Bit#(3)) counter <- mkReg(3'b0);
    Reg#(Bool) got_a <- mkReg(False);
    Reg#(Bool) got_b <- mkReg(False);
    Reg#(Bool) got_c <- mkReg(False);
    Reg#(Bool) got_si <- mkReg(False);
    Reg#(Bool) int_inp_done <- mkReg(False);
    Reg#(Bool) float_inp_done <- mkReg(False);
    Reg#(Bool) end_res_done <- mkReg(False);

    rule rl_put_mac_val(got_si && got_a && got_b && got_c && !int_inp_done && !float_inp_done);
	    if(s1_or_s2 == 0) begin
		    int_mac.get_A(mac_a);
		    int_mac.get_B(mac_b);
		    int_mac.get_C(mac_c);
            int_inp_done <= True;
	    end
	    else if(s1_or_s2 == 1) begin
		    float_mac.get_input_a(mac_a);
		    float_mac.get_input_b(mac_b);
		    float_mac.get_input_c(mac_c);
            float_inp_done <= True;
	    end
        counter <= 1;
    endrule

    rule rl_get_mac_int_res(int_inp_done && !end_res_done && counter!=0);
        if (counter == 1) begin
            $display($stime, " Access Integer before add");
            end_res <= int_mac.get_output();
            end_res_done <= True;
            $display($stime, " Acccess Integer after add");
        end
        counter <= counter - 1;
    endrule

    rule rl_get_mac_float_res(float_inp_done && !end_res_done);
        end_res <= float_mac.get_MAC_result();
        end_res_done <= True;
    endrule

    rule deassert_signal((int_inp_done || float_inp_done) && end_res_done);
        $display("result: inrt: emd_w,:, end_res");
        got_si <= False;
        got_a <= False;
        got_b <= False;
        got_c <= False;
        int_inp_done <= False;
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

    method Action get_mac_a(Bit#(16) a) if(!got_a);
	    mac_a <= a;
	    got_a <= True;
    endmethod

    method Action get_mac_b(Bit#(16) b) if(!got_b);
	    mac_b <= b;
	    got_b <= True;
    endmethod

    method Action get_mac_c(Bit#(32) c) if(!got_c);
	    mac_c <= c;
	    got_c <= True;
    endmethod

    method Bit#(32) get_end_res() if(end_res_done);
        return end_res;
    endmethod

endmodule: mkMAC

endpackage : MAC_unpipelined_top
