package MAC_unpipelined_int;

import add :: *;
import mul :: *;

interface Ifc_MAC_unpipelined_int;
    method Action get_A(Bit#(16)a);
    method Action get_B(Bit#(16)b);
    method Action get_C(Bit#(32)c);
    method Action get_select(Bit#(1)s);
    method Bit#(32) get_output();
endinterface

(*synthesize*)
module mkintmul(Ifc_MAC_unpipelined_int);

    Reg#(Bit#(16)) inp_A <- mkReg(0);
    Reg#(Bit#(16)) inp_B <- mkReg(0);
    Reg#(Bit#(32)) inp_C <- mkReg(0);
    Reg#(Bit#(1)) select <- mkReg(0);
    Reg#(Bit#(32)) mul_out <- mkReg(0);
    Reg#(Bit#(32)) add_out <- mkReg(0);

    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) got_C <- mkReg(False);
    Reg#(Bool) prepmul <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) got_result <- mkReg(False);
    Reg#(Bool) got_select <- mkReg(False);

    Reg#(Bit#(16)) temp <- mkReg(0);
    Reg#(Bit#(5)) counter <- mkReg(9);

    function Bit#(32) twos_comp(Bit#(32)x);
        Bit#(32)mask = 32'hffffffff;
        x = x & mask;
        x = add(x,1);
        return x;
    endfunction

    function Bit#(16) twos_comp_16b(Bit#(16)x);
        Bit#(16)mask = 16'hffff;
        x = x & mask;
        x = add(x,1);
        return x;
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

    function Bit#(16) add_16bit(Bit#(16) a, Bit#(16) b);
        Bit#(16) sum;
        Bit#(1) carry = 0;

        for(Integer i=0; i<16; i=i+1)
        begin
            sum[i] = a[i] ^ b[i] ^ carry;
            carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
        end
        return sum;
    endfunction

    rule rl_multiply(got_A && got_B && got_C && got_select && counter != 5'd0);
    if(inp_B[0] == 1)
    begin
        if(counter == 5'd1)
        begin
            temp <= add_16bit(temp , signExtend(twos_comp_16b(inp_A)));
        end
        else
        begin
            temp <= add_16bit(temp , signExtend(inp_A));
        end
    end
    inp_A <= inp_A << 1;
    inp_B <= inp_B >> 1;
    counter <= counter - 1; 
    endrule


    rule rl_mul(!mul_done && counter == 5'd0 && !add_done && !got_result);
    begin
        mul_out <= signExtend(temp);
        mul_done <= True;
        temp <= 0;
    end
    endrule

    rule rl_add(mul_done && !add_done && !got_result);
    begin
        add_out <= addint(mul_out,inp_C);
        add_done <= True; 
    end
    endrule

    rule rl_done(add_done && !got_result);
    begin
        got_result <= True;
    end
    endrule

    rule finished(got_result);
    begin
        counter <= 9;
        got_A <= False;
        got_B <= False;
        got_C <= False;
        got_select <= False;
        mul_done <= False;
        add_done <= False;
        got_result <= False;
    end
    endrule

    method Action get_A(Bit#(16)a) if(!got_A && !mul_done && !add_done && !got_result);
        inp_A <= a;
        got_A <= True;
    endmethod

    method Action get_B(Bit#(16)b) if(!got_B && !mul_done && !add_done && !got_result);
        inp_B <= b;
        got_B <= True;
    endmethod

    method Action get_C(Bit#(32)c)  if(!got_C && !mul_done && !add_done && !got_result);
        inp_C <= c;
        got_C <= True;
    endmethod

    method Action get_select(Bit#(1)s)  if(!got_select && !mul_done && !add_done && !got_result);
        select <= s;
        got_select <= True;
    endmethod

    method Bit#(32) get_output() if(got_result == True);
        return add_out;
    endmethod

endmodule
endpackage : MAC_unpipelined_int
