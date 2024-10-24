package MAC_unpipelined_int;

interface Ifc_MAC_unpipelined_int;
    method Action get_A(Bit#(16)a);
    method Action get_B(Bit#(16)b);
    method Action get_C(Bit#(16)c);
    method Action get_select(Bit#(1)select);
    method ActionValue #(Bit#(32)) get_output(Bit#(32)out);
endinterface

(*synthesize*)
module mkintmul(Ifc_MAC_unpipelined_int);

    Reg#(Bit#(16)) inp_A <- mkReg(0);
    Reg#(Bit#(16)) inp_B <- mkReg(0);
    Reg#(Bit#(32)) inp_C <- mkReg(0);
    Reg#(Bit#(32)) out <- mkReg(0);

    Reg#(Bool) got_A <- mkReg(False);
    Reg#(Bool) got_B <- mkReg(False);
    Reg#(Bool) got_C <- mkReg(False);
    Reg#(Bool) got_result <- mkReg(False);

    function Bit#(16) twos_comp(Bit#(16)x);
        Bit#(16)mask = 16'hffff;
        x = x & mask;
        x = add(x,1);
        return x;
    endfunction

    function Bit#(32) multiply(Bit#(16) a, Bit#(16) b);
        Bit#(16) mul = 0;
        Bit#(1) carry = 1'd0;
        Bit#(32)temp;
        // Loop to perform binary addition
        a = abs(a);
        b = abs(b);
        for (int i = 0; i < 16; i = i + 1) 
        begin
            if(b & (1<< i) != 0)
                temp = temp + (a<<i);
        end
        return temp; // Return the final sum
    endfunction

    function Bit#(32) add(Bit#(16) a, Bit#(16) b);
        Bit#(32) sum;
        Bit#(1) carry = 0;
        
        if(a < 0)
        a = twos_comp(a);

        if(b < 0)
        b = twos_comp(b);

        // Loop to perform binary addition
        for(Integer i=0; i<32; i=i+1)
        begin
            sum[i] = a[i] ^ b[i] ^ carry[i];
            carry[i+1] = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
        end
        return sum; // Return the final sum
    endfunction

    rule addition(got_A && got_B && got_C && got_result==False);
    begin
        out <= add(a,b);
        got_A <= False;
        got_B <= False; 
        got_C <= False; 
        got_result <= True; 
    end
    endrule

endmodule
endpackage : MAC_unpipelined_int
