package MAC_pipelined_int;

import FIFO :: *;
import SpecialFIFOs :: *;

interface Ifc_MAC_pipelined_int;
    method Action get_A(Bit#(16)a);
    method Action get_B(Bit#(16)b);
    method Action get_C(Bit#(32)c);
    method Action get_select(Bit#(1)select);
    method ActionValue#(Bit#(32)) get_output();
endinterface

(*synthesize*)
module mkintmul(Ifc_MAC_pipelined_int);

    FIFO#(Bit#(16)) val_a <- mkPipelineFIFO(); 
	FIFO#(Bit#(16)) val_b <- mkPipelineFIFO(); 
	FIFO#(Bit#(32)) val_c <- mkPipelineFIFO(); 
	FIFO#(Bit#(32)) val_mul <- mkPipelineFIFO(); 
	FIFO#(Bit#(32)) val_mac <- mkPipelineFIFO(); 

    Reg#(Bit#(16)) inpA <- mkReg(0);
    Reg#(Bit#(16)) inpB <- mkReg(0);
    Reg#(Bit#(32)) inpC <- mkReg(0);
    Reg#(Bit#(1)) select <- mkReg(0);
    Reg#(Bit#(32)) mul_out <- mkReg(0);
    Reg#(Bit#(32)) add_out <- mkReg(0);

    Reg#(Bool) start_done <- mkReg(False);
    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) got_C <- mkReg(False);
    Reg#(Bool) prepmul <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) got_result <- mkReg(False);
    Reg#(Bool) got_select <- mkReg(False);
    Reg#(Bool) finish <- mkReg(True);

    Reg#(Bit#(16)) temp <- mkReg(0);
    Reg#(Bit#(5)) counter <- mkReg(9);

    function Bit#(16) add16(Bit#(16) a, Bit#(16) b);
        Bit#(16) sum;
        Bit#(1) carry = 0;

        sum[0] = a[0] ^ b[0];
        carry = a[0] & b[0];
        for(Integer i=1; i<16; i=i+1)
        begin
            sum[i] = a[i] ^ b[i] ^ carry;
            carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
        end
        return sum;
    endfunction

    function Bit#(16) twos_comp(Bit#(16)num);
        Bit#(16) mask = 16'hFFFF;
        Bit#(16) temp = 16'd0;
        temp = num ^ mask;
        temp = add16(temp,1);
        return temp;
    endfunction

    function Bit#(32) addint(Bit#(32) a, Bit#(32) b);
        Bit#(32) sum;
        Bit#(1) carry = 0;

        sum[0] = a[0] ^ b[0];
        carry = a[0] & b[0];

        for(Integer i=1; i<32; i=i+1)
        begin
            sum[i] = a[i] ^ b[i] ^ carry;
            carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
        end
        return sum;
    endfunction


    rule rl_start_MAC(!start_done);
        $display("start_MAC");
	    Bit#(16) temp_a = val_a.first();
	    Bit#(16) temp_b = val_b.first();
	    Bit#(32) temp_c = val_c.first();
	    inpA <= temp_a;
	    inpB <= temp_b;
	    inpC <= temp_c;
	    val_a.deq();
	    val_b.deq();
	    val_c.deq();
	    start_done <= True;
    endrule

    rule rl_multiply(start_done && got_A && got_B && got_C && got_select && counter != 5'd0 && finish);
        $display("Multiply");
        if(inpB[0] == 1)
        begin
            if(counter == 5'd1)
                temp <= add16(temp, twos_comp(inpA));
            else
                temp <= add16(temp, inpA);
        end
        inpA <= inpA << 1;
        inpB <= inpB >> 1;
        counter <= counter - 1; 
    endrule

    rule rl_mul(start_done && !mul_done && counter == 5'd0 && !add_done && !got_result);
        $display("Mul");
        finish <= False;
        mul_out <= signExtend(temp);
        val_mul.enq(pack(mul_out)); 
        mul_done <= True;
        temp <= 0;
    endrule

    rule rl_add(start_done && mul_done && !add_done && !got_result);
        $display("Add");
        mul_out <= val_mul.first();
        val_mul.deq();
        add_out <= addint(mul_out, inpC);
        add_done <= True;
        $display("Add comp");
    endrule

    rule rl_done(start_done && add_done && !got_result);
        $display("Done");
        val_mac.enq(pack(add_out));
        add_done <= False;
        got_result <= True;
        counter <= 9;
    endrule

    rule finished(start_done && got_result);
        $display("finished");
        got_A <= False;
        got_B <= False;
        got_C <= False;
        got_select <= False;
        mul_done <= False;
        finish <= True;
        got_result <= False;
        start_done <= False;
    endrule

    method Action get_A(Bit#(16)a); 
        val_a.enq(a);
        got_A <= True;
    endmethod

    method Action get_B(Bit#(16)b); 
        val_b.enq(b);
        got_B <= True;
    endmethod

    method Action get_C(Bit#(32)c);
        val_c.enq(c);
        got_C <= True;
    endmethod

    method Action get_select(Bit#(1)s); 
        select <= s;
        got_select <= True;
    endmethod

    method ActionValue#(Bit#(32)) get_output() if(got_result);
        Bit#(32)rg_mac_result = val_mac.first();
	    val_mac.deq();
        return rg_mac_result;
    endmethod

endmodule
endpackage