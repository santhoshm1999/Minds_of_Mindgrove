package MAC_unpipelined_int;

interface Ifc_MAC_unpipelined_int;
    method Action get_A(Bit#(16)a);
    method Action get_B(Bit#(16)b);
    method Action get_C(Bit#(32)c);
    method Bit#(32) get_output();
endinterface

(*synthesize*)
module mkintmul(Ifc_MAC_unpipelined_int);

    Reg#(Bit#(16)) inpA <- mkReg(0);
    Reg#(Bit#(16)) inpB <- mkReg(0);
    Reg#(Bit#(32)) inpC <- mkReg(0);
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

    rule rl_multiply(got_A && got_B && got_C && counter != 5'd0 && finish);
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

    rule rl_mul(!mul_done && counter == 5'd0 && !add_done && !got_result);
        finish <= False;
        mul_out <= signExtend(temp);
        mul_done <= True;
        temp <= 0;
    endrule

    rule rl_add(mul_done && !add_done && !got_result);
        add_out <= addint(mul_out, inpC);
        add_done <= True; 
    endrule

    rule rl_done(add_done && !got_result);
        add_done <= False;
        got_result <= True;
        counter <= 9;
    endrule

    rule finished(got_result);
        got_A <= False;
        got_B <= False;
        got_C <= False;
        mul_done <= False;
        finish <= True;
        got_result <= False;
    endrule

    method Action get_A(Bit#(16)a); 
        inpA <= a;
        got_A <= True;
    endmethod

    method Action get_B(Bit#(16)b); 
        inpB <= b;
        got_B <= True;
    endmethod

    method Action get_C(Bit#(32)c);
        inpC <= c;
        got_C <= True;
    endmethod

    method Bit#(32) get_output() if(got_result);
        return add_out;
    endmethod

endmodule
endpackage : MAC_unpipelined_int
