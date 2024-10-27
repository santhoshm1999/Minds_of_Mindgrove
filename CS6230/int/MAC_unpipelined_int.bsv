package MAC_unpipelined_int;

import add :: *;
import mul :: *;

interface Ifc_MAC_unpipelined_int;
    method Action get_A(Bit#(16)a);
    method Action get_B(Bit#(16)b);
    method Action get_C(Bit#(32)c);
    // method Value get_select(Bit#(1)select);
    method Bit#(32) get_output();
    // method ActionValue #(Bit#(32)) get_output(Bit#(32)out);
endinterface

(*synthesize*)
module mkintmul(Ifc_MAC_unpipelined_int);

    Reg#(Bit#(16)) inp_A <- mkReg(0);
    Reg#(Bit#(16)) inp_B <- mkReg(0);
    Reg#(Bit#(32)) inp_C <- mkReg(0);
    Reg#(Bit#(32)) mul_out <- mkReg(0);
    Reg#(Bit#(32)) add_out <- mkReg(0);
    Reg#(Bit#(32)) final_out <- mkReg(0);

    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) got_C <- mkReg(False);
    Reg#(Bool) prepmul <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) got_result <- mkReg(False);

    Reg#(Bit#(1)) sign_A <- mkReg(0);
    Reg#(Bit#(1)) sign_B <- mkReg(0);
    Reg#(Bit#(32)) temp <- mkReg(0);
    Reg#(Bit#(5)) counter <- mkReg(9);
    Reg#(Bit#(1)) sign <- mkReg(0);

    // Ifc_add addition <- mk_add();
    // Ifc_mul multiply <- mk_mul();

    function Bit#(32) twos_comp(Bit#(32)x);
        Bit#(32)mask = 32'hffffffff;
        x = x & mask;
        x = add(x,1);
        return x;
    endfunction

    // function Bit#(32) mulint(Bit#(16) a, Bit#(16) b);
    //     Bit#(1) sign_A = a[0];
    //     Bit#(1) sign_B = b[0];
    //     Bit#(32)temp = 0;

    //     Bit#(1) sign = sign_A & sign_B;

    //     // Loop to perform binary addition
    //     a = abs(a);
    //     b = abs(b);
    //     for (int i = 0; i < 16; i = i + 1) 
    //     begin
    //     if(b[i] == 0)
    //     begin
    //         temp = temp + zeroExtend(a<<i);
    //     end
    //     //     if(b[0] & (1<< i) != 0)
    //     end
    //     if(sign == 1'b1)
    //         temp = temp & (1<<31);
    //     return temp; // Return the final sum
    // endfunction : mulint

    function Bit#(32) addint(Bit#(32) a, Bit#(32) b);
        Bit#(32) sum;
        Bit#(33) carry = 33'b0;

        carry[0] = 1;
        if(a[0] == 1)
        a = twos_comp(a);
        if(b[0] == 1)
        b = twos_comp(b);

        // Loop to perform binary addition
        for(Integer i=0; i<32; i=i+1)
        begin
            sum[i] = a[i] ^ b[i] ^ carry[i];
            carry[i+1] = (a[i] & b[i]) | (a[i] ^ b[i]) & carry[i];
        end
        return sum; // Return the final sum
    endfunction

    rule prep_mul(got_A && got_B && got_C && !prepmul);
    begin
        sign_A <= inp_A[0]; 
        sign_B <= inp_B[0];
        sign <= sign_A & sign_B;

        inp_A <= abs(inp_A);
        inp_B <= abs(inp_B);
        prepmul <= True;
    end
    endrule

    rule multiply(prepmul && counter != 5'b0);
    begin
        if(counter == 5'd1)
        begin
            if(inp_B[0] == 1)
            begin
            temp <= addint(temp,zeroExtend(inp_A));
            end
        end
        inp_A <= inp_A << 1;
        inp_B <= inp_B >> 1;
        counter <= counter - 1;  
    end
    endrule

    rule rl_mul(!mul_done && counter == 5'd0);
    begin
        if(sign == 1'b1)
            temp <= temp & (1<<31);
        mul_out <= temp;
        mul_done <= True;
    end
    endrule

    rule rl_add(mul_done && !add_done);
    begin
        // addition.give_inp(out,inp_C);
        add_out <= addint(mul_out,inp_C);
        // got_A <= False;
        // got_B <= False; 
        // got_C <= False;
        // mul_done <= False; 
        got_result <= True; 
    end
    endrule

    method Action get_A(Bit#(16)a);
        inp_A <= a;
        got_A <= True;
    endmethod

    method Action get_B(Bit#(16)b);
        inp_B <= b;
        got_B <= True;
    endmethod

    method Action get_C(Bit#(32)c);
        inp_C <= c;
        got_C <= True;
    endmethod

    // method Action get_select(Bit#(1)select);
    //     inp_A <= select;
    //     got_A <= True;
    // endmethod

    method Bit#(32) get_output();
        return add_out;
    endmethod

endmodule
endpackage : MAC_unpipelined_int
